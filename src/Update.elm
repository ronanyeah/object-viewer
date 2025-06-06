module Update exposing (update)

import Dict exposing (Dict)
import GraphQL.Engine
import Json.Decode
import List.Extra
import Maybe.Extra exposing (unwrap)
import Ports
import Queries.FetchOwnedObjects
import Queries.FetchPackage
import Result.Extra exposing (unpack)
import Set
import Sui
import Task
import Types exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetView view ->
            ( { model | view = view }, Cmd.none )

        TogglePackage playerId ->
            let
                xs =
                    if Set.member playerId model.visiblePackages then
                        Set.remove playerId model.visiblePackages

                    else
                        Set.insert playerId model.visiblePackages
            in
            ( { model | visiblePackages = xs }
            , Cmd.none
            )

        AddrSubmit ->
            ( model
            , fetchObjects model.addrInput Nothing
                |> Task.attempt (ObjsCb model.addrInput)
            )

        AddrChg v ->
            ( { model | addrInput = v }, Cmd.none )

        AddrClear ->
            ( { model
                | addrInput = ""
                , objects = Dict.empty
                , addr = Nothing
              }
            , Cmd.none
            )

        ObjsCb addr res ->
            res
                |> unpack
                    (\_ ->
                        ( model
                        , Ports.log "fetch error"
                        )
                    )
                    (\data ->
                        let
                            objRes =
                                data.address
                                    |> unwrap
                                        (Err "empty address response")
                                        parseObjs
                                    |> Result.map
                                        (List.Extra.gatherEqualsBy .package
                                            >> List.map
                                                ((\( x, xs ) -> ( x.package, x :: xs ))
                                                    >> Tuple.mapSecond
                                                        (List.map
                                                            (\obj ->
                                                                ( obj.id, obj )
                                                            )
                                                            >> Dict.fromList
                                                        )
                                                )
                                            >> Dict.fromList
                                        )
                        in
                        objRes
                            |> unpack
                                (\err ->
                                    ( model, Ports.log err )
                                )
                                (\objs ->
                                    let
                                        nu =
                                            mergeDicts model.objects objs
                                    in
                                    ( { model
                                        | objects = nu
                                        , addr = Just addr
                                      }
                                    , data.address
                                        |> unwrap Cmd.none
                                            (.objects
                                                >> .pageInfo
                                                >> (\page ->
                                                        if page.hasNextPage then
                                                            fetchObjects addr page.endCursor
                                                                |> Task.attempt (ObjsCb addr)

                                                        else
                                                            Cmd.none
                                                   )
                                            )
                                    )
                                )
                    )

        PackageCb res ->
            res
                |> unpack
                    (\_ ->
                        ( model
                        , Ports.log "package error"
                        )
                    )
                    (\data ->
                        let
                            package =
                                data.latestPackage
                                    |> Maybe.andThen .modules
                                    |> Maybe.map .module_
                        in
                        ( { model | package = package }, Cmd.none )
                    )

        FunctionExecute call ->
            ( model
            , Ports.dryRunTx call
            )


mergeDicts : Dict String (Dict String obj) -> Dict String (Dict String obj) -> Dict String (Dict String obj)
mergeDicts dict1 dict2 =
    Dict.merge
        -- Left only (key exists only in dict1)
        (\k v acc -> Dict.insert k v acc)
        -- Both (key exists in both dicts)
        (\k v1 v2 acc ->
            Dict.insert k (Dict.union v1 v2) acc
        )
        -- Right only (key exists only in dict2)
        (\k v acc -> Dict.insert k v acc)
        dict1
        dict2
        Dict.empty


parseObjs : Queries.FetchOwnedObjects.Address -> Result String (List Obj)
parseObjs addr =
    addr.objects.nodes
        |> List.map
            (\node ->
                let
                    objAddr =
                        case node.address of
                            Sui.SuiAddress a_ ->
                                a_
                in
                node.contents
                    |> unwrap
                        (Err "no contents")
                        (\contents ->
                            contents.type_.signature
                                |> Sui.moveTypeSignature.encode
                                |> Json.Decode.decodeValue
                                    (Json.Decode.at
                                        [ "datatype"
                                        , "package"
                                        ]
                                        Json.Decode.string
                                    )
                                |> Result.mapError
                                    Json.Decode.errorToString
                                |> Result.map
                                    (\pkg ->
                                        { id = objAddr
                                        , typename = contents.type_.repr
                                        , package = pkg
                                        , abilities =
                                            contents.type_.abilities
                                                |> Maybe.withDefault []
                                        }
                                    )
                        )
            )
        |> Result.Extra.combine


fetchObjects : String -> Maybe String -> Task.Task GraphQL.Engine.Error Queries.FetchOwnedObjects.Response
fetchObjects addr cursor =
    Sui.queryTask
        (Queries.FetchOwnedObjects.query
            { address = Sui.SuiAddress addr
            , count = 50
            , cursor =
                cursor
                    |> unwrap
                        Sui.null
                        Sui.present
            }
        )
        { headers = []
        , url = "https://sui-mainnet.mystenlabs.com/graphql"
        , timeout = Nothing
        }


fetchPackage : String -> Task.Task GraphQL.Engine.Error Queries.FetchPackage.Response
fetchPackage addr =
    Sui.queryTask
        (Queries.FetchPackage.query
            { address = Sui.SuiAddress addr
            }
        )
        { headers = []
        , url = "https://sui-testnet.mystenlabs.com/graphql"
        , timeout = Nothing
        }
