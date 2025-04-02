module Sui.Input.ObjectFilter exposing
    ( ObjectFilter
    , decoder
    , input
    , null
    , objectIds
    , owner
    , type_
    )

{-|
## Creating an input

@docs ObjectFilter, input, decoder

## Null values

@docs null

## Optional fields

@docs type_, owner, objectIds
-}


import Dict
import GraphQL.InputObject
import Json.Decode
import Json.Encode
import Sui
import Sui.Input


type alias ObjectFilter =
    Sui.Input.ObjectFilter


input : ObjectFilter
input =
    GraphQL.InputObject.inputObject "ObjectFilter"


type_ : String -> ObjectFilter -> ObjectFilter
type_ newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "type"
        "String"
        (Json.Encode.string newArg_)
        inputObj_


owner : Sui.SuiAddress -> ObjectFilter -> ObjectFilter
owner newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "owner"
        "SuiAddress"
        (Sui.suiAddress.encode newArg_)
        inputObj_


objectIds : List Sui.SuiAddress -> ObjectFilter -> ObjectFilter
objectIds newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "objectIds"
        "[SuiAddress!]"
        (Json.Encode.list Sui.suiAddress.encode newArg_)
        inputObj_


null :
    { type_ : ObjectFilter -> ObjectFilter
    , owner : ObjectFilter -> ObjectFilter
    , objectIds : ObjectFilter -> ObjectFilter
    }
null =
    { type_ =
        \inputObj ->
            GraphQL.InputObject.addField
                "type"
                "String"
                Json.Encode.null
                inputObj
    , owner =
        \inputObj ->
            GraphQL.InputObject.addField
                "owner"
                "SuiAddress"
                Json.Encode.null
                inputObj
    , objectIds =
        \inputObj ->
            GraphQL.InputObject.addField
                "objectIds"
                "[SuiAddress!]"
                Json.Encode.null
                inputObj
    }


{-| This is a rarely needed function and it is unlikely that you will need this.

It may be useful in edge cases where you need to do mocking/simulation of your queries within your app (tests shouldn't need this).
-}
decoder : Json.Decode.Decoder ObjectFilter
decoder =
    Json.Decode.map
        (\mapUnpack ->
             GraphQL.InputObject.raw
                 "ObjectFilter"
                 (List.map
                      (\mapUnpack0 ->
                           ( mapUnpack0.name
                           , { gqlTypeName = mapUnpack0.type_
                             , value = Dict.get mapUnpack0.name mapUnpack
                             }
                           )
                      )
                      [ { name = "type", type_ = "String" }
                      , { name = "owner", type_ = "SuiAddress" }
                      , { name = "objectIds", type_ = "[SuiAddress!]" }
                      ]
                 )
        )
        (Json.Decode.dict Json.Decode.value)