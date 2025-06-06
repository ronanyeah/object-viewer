module Sui.Input.EventFilter exposing
    ( EventFilter, input, decoder
    , null
    , sender, transactionDigest, emittingModule, eventType
    )

{-|


## Creating an input

@docs EventFilter, input, decoder


## Null values

@docs null


## Optional fields

@docs sender, transactionDigest, emittingModule, eventType

-}

import Dict
import GraphQL.InputObject
import Json.Decode
import Json.Encode
import Sui
import Sui.Input


type alias EventFilter =
    Sui.Input.EventFilter


input : EventFilter
input =
    GraphQL.InputObject.inputObject "EventFilter"


sender : Sui.SuiAddress -> EventFilter -> EventFilter
sender newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "sender"
        "SuiAddress"
        (Sui.suiAddress.encode newArg_)
        inputObj_


transactionDigest : String -> EventFilter -> EventFilter
transactionDigest newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "transactionDigest"
        "String"
        (Json.Encode.string newArg_)
        inputObj_


emittingModule : String -> EventFilter -> EventFilter
emittingModule newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "emittingModule"
        "String"
        (Json.Encode.string newArg_)
        inputObj_


eventType : String -> EventFilter -> EventFilter
eventType newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "eventType"
        "String"
        (Json.Encode.string newArg_)
        inputObj_


null :
    { sender : EventFilter -> EventFilter
    , transactionDigest : EventFilter -> EventFilter
    , emittingModule : EventFilter -> EventFilter
    , eventType : EventFilter -> EventFilter
    }
null =
    { sender =
        \inputObj ->
            GraphQL.InputObject.addField
                "sender"
                "SuiAddress"
                Json.Encode.null
                inputObj
    , transactionDigest =
        \inputObj ->
            GraphQL.InputObject.addField
                "transactionDigest"
                "String"
                Json.Encode.null
                inputObj
    , emittingModule =
        \inputObj ->
            GraphQL.InputObject.addField
                "emittingModule"
                "String"
                Json.Encode.null
                inputObj
    , eventType =
        \inputObj ->
            GraphQL.InputObject.addField
                "eventType"
                "String"
                Json.Encode.null
                inputObj
    }


{-| This is a rarely needed function and it is unlikely that you will need this.

It may be useful in edge cases where you need to do mocking/simulation of your queries within your app (tests shouldn't need this).

-}
decoder : Json.Decode.Decoder EventFilter
decoder =
    Json.Decode.map
        (\mapUnpack ->
            GraphQL.InputObject.raw
                "EventFilter"
                (List.map
                    (\mapUnpack0 ->
                        ( mapUnpack0.name
                        , { gqlTypeName = mapUnpack0.type_
                          , value = Dict.get mapUnpack0.name mapUnpack
                          }
                        )
                    )
                    [ { name = "sender", type_ = "SuiAddress" }
                    , { name = "transactionDigest", type_ = "String" }
                    , { name = "emittingModule", type_ = "String" }
                    , { name = "eventType", type_ = "String" }
                    ]
                )
        )
        (Json.Decode.dict Json.Decode.value)
