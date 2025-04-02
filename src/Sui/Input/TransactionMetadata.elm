module Sui.Input.TransactionMetadata exposing
    ( TransactionMetadata
    , decoder
    , gasBudget
    , gasObjects
    , gasPrice
    , gasSponsor
    , input
    , null
    , sender
    )

{-|
## Creating an input

@docs TransactionMetadata, input, decoder

## Null values

@docs null

## Optional fields

@docs sender, gasPrice, gasObjects, gasBudget, gasSponsor
-}


import Dict
import GraphQL.InputObject
import Json.Decode
import Json.Encode
import Sui
import Sui.Input


type alias TransactionMetadata =
    Sui.Input.TransactionMetadata


input : TransactionMetadata
input =
    GraphQL.InputObject.inputObject "TransactionMetadata"


sender : Sui.SuiAddress -> TransactionMetadata -> TransactionMetadata
sender newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "sender"
        "SuiAddress"
        (Sui.suiAddress.encode newArg_)
        inputObj_


gasPrice : Sui.Uint53 -> TransactionMetadata -> TransactionMetadata
gasPrice newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "gasPrice"
        "UInt53"
        (Sui.uint53.encode newArg_)
        inputObj_


gasObjects :
    List Sui.Input.ObjectRef -> TransactionMetadata -> TransactionMetadata
gasObjects newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "gasObjects"
        "[ObjectRef!]"
        (Json.Encode.list GraphQL.InputObject.encode newArg_)
        inputObj_


gasBudget : Sui.Uint53 -> TransactionMetadata -> TransactionMetadata
gasBudget newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "gasBudget"
        "UInt53"
        (Sui.uint53.encode newArg_)
        inputObj_


gasSponsor : Sui.SuiAddress -> TransactionMetadata -> TransactionMetadata
gasSponsor newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "gasSponsor"
        "SuiAddress"
        (Sui.suiAddress.encode newArg_)
        inputObj_


null :
    { sender : TransactionMetadata -> TransactionMetadata
    , gasPrice : TransactionMetadata -> TransactionMetadata
    , gasObjects : TransactionMetadata -> TransactionMetadata
    , gasBudget : TransactionMetadata -> TransactionMetadata
    , gasSponsor : TransactionMetadata -> TransactionMetadata
    }
null =
    { sender =
        \inputObj ->
            GraphQL.InputObject.addField
                "sender"
                "SuiAddress"
                Json.Encode.null
                inputObj
    , gasPrice =
        \inputObj ->
            GraphQL.InputObject.addField
                "gasPrice"
                "UInt53"
                Json.Encode.null
                inputObj
    , gasObjects =
        \inputObj ->
            GraphQL.InputObject.addField
                "gasObjects"
                "[ObjectRef!]"
                Json.Encode.null
                inputObj
    , gasBudget =
        \inputObj ->
            GraphQL.InputObject.addField
                "gasBudget"
                "UInt53"
                Json.Encode.null
                inputObj
    , gasSponsor =
        \inputObj ->
            GraphQL.InputObject.addField
                "gasSponsor"
                "SuiAddress"
                Json.Encode.null
                inputObj
    }


{-| This is a rarely needed function and it is unlikely that you will need this.

It may be useful in edge cases where you need to do mocking/simulation of your queries within your app (tests shouldn't need this).
-}
decoder : Json.Decode.Decoder TransactionMetadata
decoder =
    Json.Decode.map
        (\mapUnpack ->
             GraphQL.InputObject.raw
                 "TransactionMetadata"
                 (List.map
                      (\mapUnpack0 ->
                           ( mapUnpack0.name
                           , { gqlTypeName = mapUnpack0.type_
                             , value = Dict.get mapUnpack0.name mapUnpack
                             }
                           )
                      )
                      [ { name = "sender", type_ = "SuiAddress" }
                      , { name = "gasPrice", type_ = "UInt53" }
                      , { name = "gasObjects", type_ = "[ObjectRef!]" }
                      , { name = "gasBudget", type_ = "UInt53" }
                      , { name = "gasSponsor", type_ = "SuiAddress" }
                      ]
                 )
        )
        (Json.Decode.dict Json.Decode.value)