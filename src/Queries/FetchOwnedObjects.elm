module Queries.FetchOwnedObjects exposing
    ( Input
    , Response
    , query
    , Address, Objects, Nodes, Contents, Type, PageInfo
    )

{-| This file is generated from graphql/queries.graphql using `elm-gql`

Please avoid modifying directly.

@docs Input

@docs Response

@docs query

@docs Address, Objects, Nodes, Contents, Type, PageInfo

-}

import GraphQL.Decode
import GraphQL.Engine
import GraphQL.InputObject
import Json.Decode
import Json.Encode
import Sui
import Sui.Enum.MoveAbility


{-| This input has optional args, which are wrapped in `Sui.Option`.

First up, if it makes sense, you can make this argument required in your graphql query
by adding ! to that variable definition at the top of the query. This will make it easier to handle in Elm.

If the field is truly optional, here's how to wrap it.

    - Sui.present myValue -- this field should be myValue
    - Sui.absent -- do not include this field at all in the GraphQL
    - Sui.null -- include this field as a null value.  Not as common as .absent.

-}
type alias Input =
    { address : Sui.SuiAddress, count : Int, cursor : Sui.Option String }


query : Input -> Sui.Query Response
query args =
    GraphQL.Engine.operation
        (Just "fetchOwnedObjects")
        (\version_ ->
            { args =
                GraphQL.InputObject.toFieldList
                    (GraphQL.InputObject.inputObject
                        "Input"
                        |> GraphQL.InputObject.addOptionalField
                            "cursor"
                            "String"
                            args.cursor
                            Json.Encode.string
                        |> GraphQL.InputObject.addField
                            "count"
                            "Int!"
                            (Json.Encode.int
                                args.count
                            )
                        |> GraphQL.InputObject.addField
                            "address"
                            "SuiAddress!"
                            (Sui.suiAddress.encode
                                args.address
                            )
                    )
            , body = toPayload_ version_
            , fragments = toFragments_ version_
            }
        )
        decoder_



{- Return data -}


type alias Response =
    { address : Maybe Address }


type alias Address =
    { objects : Objects }


type alias Objects =
    { pageInfo : PageInfo, nodes : List Nodes }


type alias Nodes =
    { address : Sui.SuiAddress, contents : Maybe Contents }


type alias Contents =
    { type_ : Type }


type alias Type =
    { repr : String
    , abilities : Maybe (List Sui.Enum.MoveAbility.MoveAbility)
    , signature : Sui.MoveTypeSignature
    }


type alias PageInfo =
    { endCursor : Maybe String, hasNextPage : Bool }


decoder_ : Int -> Json.Decode.Decoder Response
decoder_ version_ =
    Json.Decode.succeed Response
        |> GraphQL.Decode.versionedField
            version_
            "address"
            (Json.Decode.nullable
                (Json.Decode.succeed
                    Address
                    |> GraphQL.Decode.field
                        "objects"
                        (Json.Decode.succeed
                            Objects
                            |> GraphQL.Decode.field
                                "pageInfo"
                                (Json.Decode.succeed
                                    PageInfo
                                    |> GraphQL.Decode.field
                                        "endCursor"
                                        (Json.Decode.nullable
                                            Json.Decode.string
                                        )
                                    |> GraphQL.Decode.field
                                        "hasNextPage"
                                        Json.Decode.bool
                                )
                            |> GraphQL.Decode.field
                                "nodes"
                                (Json.Decode.list
                                    (Json.Decode.succeed
                                        Nodes
                                        |> GraphQL.Decode.field
                                            "address"
                                            Sui.suiAddress.decoder
                                        |> GraphQL.Decode.field
                                            "contents"
                                            (Json.Decode.nullable
                                                (Json.Decode.succeed
                                                    Contents
                                                    |> GraphQL.Decode.field
                                                        "type"
                                                        (Json.Decode.succeed
                                                            Type
                                                            |> GraphQL.Decode.field
                                                                "repr"
                                                                Json.Decode.string
                                                            |> GraphQL.Decode.field
                                                                "abilities"
                                                                (Json.Decode.nullable
                                                                    (Json.Decode.list
                                                                        Sui.Enum.MoveAbility.decoder
                                                                    )
                                                                )
                                                            |> GraphQL.Decode.field
                                                                "signature"
                                                                Sui.moveTypeSignature.decoder
                                                        )
                                                )
                                            )
                                    )
                                )
                        )
                )
            )


toPayload_ : Int -> String
toPayload_ version_ =
    ((((((GraphQL.Engine.versionedAlias version_ "address" ++ " (address: ")
            ++ GraphQL.Engine.versionedName version_ "$address"
        )
            ++ ") {objects (first: "
       )
        ++ GraphQL.Engine.versionedName version_ "$count"
      )
        ++ ", after: "
     )
        ++ GraphQL.Engine.versionedName version_ "$cursor"
    )
        ++ """) {pageInfo {endCursor
hasNextPage }
nodes {address
contents {type {repr
abilities
signature } } } } }"""


toFragments_ : Int -> String
toFragments_ version_ =
    String.join """
""" []
