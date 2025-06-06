module View exposing (view)

import Dict
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Helpers.View exposing (onKeydown, whenAttr, whenJust)
import Html exposing (Html)
import Html.Attributes
import List.Extra
import Maybe.Extra exposing (unwrap)
import Ports
import Queries.FetchPackage exposing (Enums, Functions, LatestPackage_Modules_Module_Enums_Nodes, LatestPackage_Modules_Module_Functions_Nodes, Module, Module_Nodes, Structs)
import Set
import Style exposing (..)
import Sui.Enum.MoveAbility as MA
import Types exposing (..)


view : Model -> Html Msg
view model =
    [ navBar model.view model.network
        |> el [ centerX ]
    , case model.view of
        ViewWalletObjects ->
            viewWalletObjects model

        ViewPackageDefinitions ->
            viewPackageDefinitions model

        ViewFunction ->
            viewFunctionPage model
    ]
        |> column [ width fill, height fill ]
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
            , Font.color black
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
                |> el [ centerX ]

        Just ( packageId, modules ) ->
            modules
                |> List.map (viewModule packageId)
                |> column
                    [ spacing 20
                    , width fill
                    , scrollbarY
                    , height (fill |> minimum 0)
                    ]
    ]
        |> column
            [ height fill
            , spacing 30
            , centerX
            , padding 20
            , width fill
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


navBar : View -> Network -> Element Msg
navBar currentView currentNetwork =
    [ [ navButton "Wallet Objects" ViewWalletObjects currentView
      , navButton "Package Definitions" ViewPackageDefinitions currentView
      , navButton "Function" ViewFunction currentView
      ]
        |> row [ spacing 20 ]
    , networkToggle currentNetwork
    ]
        |> row
            [ spacing 40
            , padding 15
            , Background.color (rgba 0 0 0 0.1)
            , width fill
            ]


networkToggle : Network -> Element Msg
networkToggle currentNetwork =
    Input.radio
        [ spacing 15 ]
        { onChange = SetNetwork
        , selected = Just currentNetwork
        , label = Input.labelAbove [] (text "Network")
        , options =
            [ Input.option Mainnet (text "Mainnet")
            , Input.option Testnet (text "Testnet")
            ]
        }


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


viewModule : String -> Module -> Element Msg
viewModule packageId mod =
    [ text mod.name
        |> el [ Font.bold, Font.size 20 ]
    , [ viewStructs mod.structs
      , viewEnums mod.enums
      , viewFunctions packageId mod.name mod.functions
      ]
        |> List.filterMap identity
        |> column [ spacing 15, width fill ]
    ]
        |> column
            [ spacing 15
            , Background.color (rgba 255 255 255 0.4)
            , padding 20
            , Border.rounded 20
            , Border.width 1
            , width fill
            ]


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


viewFunctions : String -> String -> Maybe Functions -> Maybe (Element Msg)
viewFunctions packageId moduleName maybeFunctions =
    maybeFunctions
        |> Maybe.map
            (\functions ->
                [ text "Functions"
                    |> el [ Font.bold, Font.size 16 ]
                , functions.nodes
                    |> List.map (viewFunction packageId moduleName)
                    |> column
                        [ spacing 10
                        , width fill
                        , scrollbarX
                        , paddingXY 0 20
                        ]
                ]
                    |> column [ spacing 10, width fill ]
            )


viewFunction : String -> String -> LatestPackage_Modules_Module_Functions_Nodes -> Element Msg
viewFunction packageId moduleName function =
    [ text function.name
        |> btn
            (Just
                (SelectFunction
                    { packageId = packageId
                    , moduleName = moduleName
                    , function = function
                    }
                )
            )
            [ Font.semiBold, Font.underline, hover ]
    , [ function.parameters
            |> Maybe.map (List.map .repr)
            |> whenJust
                (\xs ->
                    if List.isEmpty xs then
                        text "()"

                    else
                        xs
                            |> List.map
                                (truncateTypeSig packageId)
                            |> formatTuple
                            |> text
                )
      , function.return
            |> Maybe.andThen emptyListGuard
            |> Maybe.map
                (List.map
                    (.repr
                        >> truncateTypeSig packageId
                    )
                    >> formatTuple
                    >> text
                )
            |> whenJust
                (\xs ->
                    [ text " -> ", xs ]
                        |> row [ spacing 5 ]
                )
      ]
        |> row [ spacing 5 ]
    ]
        |> column [ spacing 5, paddingXY 10 0 ]


formatTuple : List String -> String
formatTuple xs =
    xs
        |> String.join ", "
        |> (\val -> "(" ++ val ++ ")")


emptyListGuard xs =
    if List.isEmpty xs then
        Nothing

    else
        Just xs


truncateTypeSig packageId =
    String.replace "0x0000000000000000000000000000000000000000000000000000000000000002::" ""
        >> String.replace "0x0000000000000000000000000000000000000000000000000000000000000001::" ""
        >> String.replace (packageId ++ "::") ""


viewFunctionPage : Model -> Element Msg
viewFunctionPage model =
    case model.selectedFunction of
        Nothing ->
            text "No function selected"
                |> el [ centerX, centerY ]

        Just selectedFunc ->
            [ [ text "Back to Package"
                    |> btn (Just (SetView ViewPackageDefinitions))
                        [ Font.underline, hover ]
              ]
                |> row [ spacing 10 ]
            , [ text (selectedFunc.packageId ++ "::" ++ selectedFunc.moduleName ++ "::" ++ selectedFunc.function.name)
                    |> el [ Font.bold, Font.size 24 ]
              ]
                |> column [ spacing 15 ]
            , viewFunctionInputs selectedFunc model.functionInputs
            , [ text "Execute Function"
                    |> btn (Just (FunctionExecute (buildFunctionCall selectedFunc model.functionInputs)))
                        [ Background.color (rgb 0.2 0.6 0.9)
                        , Font.color white
                        , padding 10
                        , Border.rounded 5
                        , hover
                        ]
              ]
                |> row [ spacing 10 ]
            ]
                |> column
                    [ spacing 30
                    , centerX
                    , padding 20
                    , width fill
                    ]


viewFunctionInputs : SelectedFunction -> Dict.Dict String String -> Element Msg
viewFunctionInputs selectedFunc inputs =
    case selectedFunc.function.parameters of
        Nothing ->
            text "This function has no parameters"
                |> el [ centerX ]

        Just params ->
            if List.isEmpty params then
                text "This function has no parameters"
                    |> el [ centerX ]

            else
                [ text "Function Parameters"
                    |> el [ Font.bold, Font.size 18 ]
                , params
                    |> List.indexedMap (viewParameterInput selectedFunc.packageId inputs)
                    |> column [ spacing 15, width fill ]
                ]
                    |> column [ spacing 15, width fill ]


viewParameterInput : String -> Dict.Dict String String -> Int -> { repr : String } -> Element Msg
viewParameterInput packageId inputs index param =
    let
        paramName =
            "param_" ++ String.fromInt index

        currentValue =
            Dict.get paramName inputs |> Maybe.withDefault ""

        cleanTypeName =
            truncateTypeSig packageId param.repr
    in
    [ text ("Parameter " ++ String.fromInt (index + 1) ++ ": " ++ cleanTypeName)
        |> el [ Font.semiBold ]
    , Input.text
        [ width (px 400)
        , Font.size 14
        ]
        { onChange = FunctionInputChange paramName
        , text = currentValue
        , placeholder = Just (Input.placeholder [] (text ("Enter " ++ cleanTypeName)))
        , label = Input.labelHidden ("Parameter " ++ String.fromInt (index + 1))
        }
    ]
        |> column [ spacing 5 ]


buildFunctionCall : SelectedFunction -> Dict.Dict String String -> Ports.FunctionCall
buildFunctionCall selectedFunc inputs =
    { functionPath = selectedFunc.packageId ++ "::" ++ selectedFunc.moduleName ++ "::" ++ selectedFunc.function.name
    , arguments =
        selectedFunc.function.parameters
            |> Maybe.withDefault []
            |> List.indexedMap
                (\index param ->
                    let
                        paramName =
                            "param_" ++ String.fromInt index

                        value =
                            Dict.get paramName inputs |> Maybe.withDefault ""
                    in
                    ( value, param.repr )
                )
    }
