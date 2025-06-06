module View exposing (view)

import Dict
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Helpers.View exposing (onKeydown, whenAttr)
import Html exposing (Html)
import Html.Attributes
import List.Extra
import Maybe.Extra exposing (unwrap)
import Queries.FetchPackage exposing (Enums, Functions, LatestPackage_Modules_Module_Enums_Nodes, LatestPackage_Modules_Module_Functions_Nodes, Module, Module_Nodes, Structs)
import Set
import Style exposing (..)
import Sui.Enum.MoveAbility as MA
import Types exposing (..)


view : Model -> Html Msg
view model =
    [ navBar model.view
    , case model.view of
        ViewWalletObjects ->
            viewWalletObjects model

        ViewPackageDefinitions ->
            viewPackageDefinitions model
    ]
        |> column []
        |> Element.layoutWith
            { options =
                [ Element.focusStyle
                    { borderColor = Nothing
                    , backgroundColor = Nothing
                    , shadow = Nothing
                    }
                ]
            }
            [ width fill
            , height fill
            , Background.color bgColor
            ]


viewWalletObjects : Model -> Element Msg
viewWalletObjects model =
    model.addr
        |> unwrap
            (Input.text
                [ onKeydown "Enter" AddrSubmit
                , Html.Attributes.autofocus True
                    |> htmlAttribute
                , width <| px 600
                , Font.size 15
                , centerX
                ]
                { label =
                    text "Provide wallet address:"
                        |> Input.labelAbove []
                , onChange = AddrChg
                , placeholder = Nothing
                , text = model.addrInput
                }
                |> el [ padding 20, centerX ]
            )
            (\addr ->
                [ [ text <| "Address: " ++ addr
                  , text "X"
                        |> btn (Just AddrClear) []
                  ]
                    |> row
                        [ spacing 10
                        , Font.size 17
                        ]
                , text ("Objects from " ++ String.fromInt (Dict.size model.objects) ++ " packages")
                    |> el [ centerX, centerY ]
                , model.objects
                    |> Dict.toList
                    |> List.map
                        (\( package, packageObjects ) ->
                            let
                                groupedObjects =
                                    packageObjects
                                        |> Dict.values
                                        |> List.Extra.gatherEqualsBy .typename
                                        |> List.map
                                            (\( x, xs ) ->
                                                ( x.typename, x :: xs )
                                            )

                                allObjects =
                                    groupedObjects
                                        |> List.map
                                            (Tuple.second >> List.length)
                                        |> List.sum
                            in
                            [ text package
                                |> linkOut
                                    ("https://suivision.xyz/package/" ++ package)
                                    [ Font.underline ]
                            , [ text
                                    ("Types: "
                                        ++ String.fromInt
                                            (List.length groupedObjects)
                                    )
                              , text
                                    ("Objects: "
                                        ++ String.fromInt allObjects
                                    )
                              , text "Expand"
                                    |> btn (Just <| TogglePackage package)
                                        [ Font.underline
                                        ]
                              ]
                                |> row [ spaceEvenly, width fill ]
                            , if Set.member package model.visiblePackages then
                                groupedObjects
                                    |> List.map
                                        (\( typename, objects ) ->
                                            [ formatTypename package typename
                                                |> text
                                                |> el [ Font.size 16 ]
                                            , objects
                                                |> List.map viewObj
                                                |> wrappedRow
                                                    [ spacing 10
                                                    , width <| px 700
                                                    ]
                                            ]
                                                |> column [ spacing 5 ]
                                        )
                                    |> column [ spacing 20 ]

                              else
                                groupedObjects
                                    |> List.map
                                        (\( typename, _ ) ->
                                            [ formatTypename package typename
                                                |> text
                                                |> el [ Font.size 16 ]
                                            ]
                                                |> column [ spacing 5 ]
                                        )
                                    |> column
                                        [ spacing 20
                                        ]
                            ]
                                |> column
                                    [ spacing 20
                                    , Background.color (rgba 255 255 255 0.4)
                                    , padding 20
                                    , Border.rounded 20
                                    , Border.width 1
                                    , width fill
                                    ]
                        )
                    |> column [ spacing 15, scrollbarY, height (fill |> minimum 0) ]
                ]
                    |> column
                        [ height fill
                        , spacing 30
                        , centerX
                        , padding 20
                        ]
            )


viewObj : Obj -> Element msg
viewObj obj =
    [ text (String.left 5 obj.id)
        |> linkOut
            ("https://suivision.xyz/object/" ++ obj.id)
            [ Font.underline ]
    , obj.abilities
        |> List.map
            (\ab ->
                (case ab of
                    MA.KEY ->
                        ( "🔑", "Key" )

                    MA.COPY ->
                        ( "📋", "Copy" )

                    MA.DROP ->
                        ( "🗑️", "Drop" )

                    MA.STORE ->
                        ( "📦", "Store" )
                )
                    |> (\( icn, name ) ->
                            text icn
                                |> el
                                    [ Font.size 15
                                    , Html.Attributes.title name
                                        |> htmlAttribute
                                    ]
                       )
            )
        |> row [ alignBottom, alignRight ]
    ]
        |> column
            [ height <| px 100
            , width <| px 100
            , Border.width 2
            , spacing 10
            , padding 5
            , Border.rounded 8
            , Background.color white
            , Html.Attributes.title obj.typename
                |> htmlAttribute
            ]


viewPackageDefinitions : Model -> Element Msg
viewPackageDefinitions model =
    [ Input.text
        [ onKeydown "Enter" (FetchPackage model.addrInput)
        , Html.Attributes.autofocus True
            |> htmlAttribute
        , width <| px 600
        , Font.size 15
        , centerX
        ]
        { label =
            text "Provide package address:"
                |> Input.labelAbove []
        , onChange = AddrChg
        , placeholder = Nothing
        , text = model.addrInput
        }
        |> el [ padding 20, centerX ]
    , case model.package of
        Nothing ->
            text "Enter a package address to view definitions"
                |> el [ centerX, centerY ]

        Just modules ->
            modules
                |> List.map viewModule
                |> column [ spacing 20, scrollbarY, height (fill |> minimum 0) ]
    ]
        |> column
            [ height fill
            , spacing 30
            , centerX
            , padding 20
            ]


linkOut : String -> List (Attribute msg) -> Element msg -> Element msg
linkOut url attrs elem =
    newTabLink
        (hover :: attrs)
        { url = url
        , label = elem
        }


btn : Maybe msg -> List (Attribute msg) -> Element msg -> Element msg
btn msg attrs elem =
    Input.button
        ((hover |> whenAttr (msg /= Nothing)) :: attrs)
        { onPress = msg
        , label = elem
        }


formatTypename : String -> String -> String
formatTypename package =
    String.replace (package ++ "::") ""
        >> String.replace "<" "<\n"
        >> String.replace ">" "\n>"


navBar : View -> Element Msg
navBar currentView =
    [ navButton "Wallet Objects" ViewWalletObjects currentView
    , navButton "Package Definitions" ViewPackageDefinitions currentView
    ]
        |> row
            [ spacing 20
            , padding 15
            , Background.color (rgba 0 0 0 0.1)
            , width fill
            ]


navButton : String -> View -> View -> Element Msg
navButton label targetView currentView =
    let
        isActive =
            targetView == currentView

        attrs =
            if isActive then
                [ Background.color (rgba 0 0 0 0.2)
                , Font.bold
                ]

            else
                [ hover ]
    in
    text label
        |> btn (Just (SetView targetView))
            (attrs ++ [ padding 10, Border.rounded 5 ])


viewModule : Module -> Element Msg
viewModule mod =
    [ text mod.name
        |> el [ Font.bold, Font.size 20 ]
    , viewModuleContent mod
    ]
        |> column
            [ spacing 15
            , Background.color (rgba 255 255 255 0.4)
            , padding 20
            , Border.rounded 20
            , Border.width 1
            , width fill
            ]


viewModuleContent : Module -> Element Msg
viewModuleContent mod =
    [ viewStructs mod.structs
    , viewEnums mod.enums
    , viewFunctions mod.functions
    ]
        |> List.filterMap identity
        |> column [ spacing 15 ]


viewStructs : Maybe Structs -> Maybe (Element Msg)
viewStructs maybeStructs =
    maybeStructs
        |> Maybe.map
            (\structs ->
                [ text "Structs"
                    |> el [ Font.bold, Font.size 16 ]
                , structs.nodes
                    |> List.map viewStruct
                    |> column [ spacing 10 ]
                ]
                    |> column [ spacing 10 ]
            )


viewStruct : Module_Nodes -> Element Msg
viewStruct struct =
    [ text struct.name
        |> el [ Font.semiBold ]
    , struct.fields
        |> Maybe.map (List.map (.name >> text) >> column [ spacing 5 ])
        |> Maybe.withDefault none
    ]
        |> column [ spacing 5, paddingXY 10 0 ]


viewEnums : Maybe Enums -> Maybe (Element Msg)
viewEnums maybeEnums =
    maybeEnums
        |> Maybe.map
            (\enums ->
                [ text "Enums"
                    |> el [ Font.bold, Font.size 16 ]
                , enums.nodes
                    |> List.map viewEnum
                    |> column [ spacing 10 ]
                ]
                    |> column [ spacing 10 ]
            )


viewEnum : LatestPackage_Modules_Module_Enums_Nodes -> Element Msg
viewEnum enum =
    [ text enum.name
        |> el [ Font.semiBold ]
    , enum.variants
        |> Maybe.map (List.map (.name >> text) >> column [ spacing 5 ])
        |> Maybe.withDefault none
    ]
        |> column [ spacing 5, paddingXY 10 0 ]


viewFunctions : Maybe Functions -> Maybe (Element Msg)
viewFunctions maybeFunctions =
    maybeFunctions
        |> Maybe.map
            (\functions ->
                [ text "Functions"
                    |> el [ Font.bold, Font.size 16 ]
                , functions.nodes
                    |> List.map viewFunction
                    |> column [ spacing 10 ]
                ]
                    |> column [ spacing 10 ]
            )


viewFunction : LatestPackage_Modules_Module_Functions_Nodes -> Element Msg
viewFunction function =
    [ text function.name
        |> el [ Font.semiBold ]
    , [ function.parameters
            |> Maybe.map (List.map (.repr >> text) >> row [ spacing 5 ])
            |> Maybe.withDefault none
      , text " -> "
      , function.return
            |> Maybe.map (List.map (.repr >> text) >> row [ spacing 5 ])
            |> Maybe.withDefault none
      ]
        |> row [ spacing 5 ]
    ]
        |> column [ spacing 5, paddingXY 10 0 ]
