module Sui.Input.TransactionBlockFilter exposing
    ( TransactionBlockFilter
    , affectedAddress
    , affectedObject
    , afterCheckpoint
    , atCheckpoint
    , beforeCheckpoint
    , changedObject
    , decoder
    , function
    , input
    , inputObject
    , kind
    , null
    , sentAddress
    , transactionIds
    )

{-|
## Creating an input

@docs TransactionBlockFilter, input, decoder

## Null values

@docs null

## Optional fields

@docs function, kind, afterCheckpoint, atCheckpoint, beforeCheckpoint, affectedAddress, affectedObject, sentAddress, inputObject, changedObject, transactionIds
-}


import Dict
import GraphQL.InputObject
import Json.Decode
import Json.Encode
import Sui
import Sui.Enum.TransactionBlockKindInput
import Sui.Input


type alias TransactionBlockFilter =
    Sui.Input.TransactionBlockFilter


input : TransactionBlockFilter
input =
    GraphQL.InputObject.inputObject "TransactionBlockFilter"


function : String -> TransactionBlockFilter -> TransactionBlockFilter
function newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "function"
        "String"
        (Json.Encode.string newArg_)
        inputObj_


kind :
    Sui.Enum.TransactionBlockKindInput.TransactionBlockKindInput
    -> TransactionBlockFilter
    -> TransactionBlockFilter
kind newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "kind"
        "TransactionBlockKindInput"
        (Sui.Enum.TransactionBlockKindInput.encode newArg_)
        inputObj_


afterCheckpoint : Sui.Uint53 -> TransactionBlockFilter -> TransactionBlockFilter
afterCheckpoint newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "afterCheckpoint"
        "UInt53"
        (Sui.uint53.encode newArg_)
        inputObj_


atCheckpoint : Sui.Uint53 -> TransactionBlockFilter -> TransactionBlockFilter
atCheckpoint newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "atCheckpoint"
        "UInt53"
        (Sui.uint53.encode newArg_)
        inputObj_


beforeCheckpoint :
    Sui.Uint53 -> TransactionBlockFilter -> TransactionBlockFilter
beforeCheckpoint newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "beforeCheckpoint"
        "UInt53"
        (Sui.uint53.encode newArg_)
        inputObj_


affectedAddress :
    Sui.SuiAddress -> TransactionBlockFilter -> TransactionBlockFilter
affectedAddress newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "affectedAddress"
        "SuiAddress"
        (Sui.suiAddress.encode newArg_)
        inputObj_


affectedObject :
    Sui.SuiAddress -> TransactionBlockFilter -> TransactionBlockFilter
affectedObject newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "affectedObject"
        "SuiAddress"
        (Sui.suiAddress.encode newArg_)
        inputObj_


sentAddress : Sui.SuiAddress -> TransactionBlockFilter -> TransactionBlockFilter
sentAddress newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "sentAddress"
        "SuiAddress"
        (Sui.suiAddress.encode newArg_)
        inputObj_


inputObject : Sui.SuiAddress -> TransactionBlockFilter -> TransactionBlockFilter
inputObject newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "inputObject"
        "SuiAddress"
        (Sui.suiAddress.encode newArg_)
        inputObj_


changedObject :
    Sui.SuiAddress -> TransactionBlockFilter -> TransactionBlockFilter
changedObject newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "changedObject"
        "SuiAddress"
        (Sui.suiAddress.encode newArg_)
        inputObj_


transactionIds : List String -> TransactionBlockFilter -> TransactionBlockFilter
transactionIds newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "transactionIds"
        "[String!]"
        (Json.Encode.list Json.Encode.string newArg_)
        inputObj_


null :
    { function : TransactionBlockFilter -> TransactionBlockFilter
    , kind : TransactionBlockFilter -> TransactionBlockFilter
    , afterCheckpoint : TransactionBlockFilter -> TransactionBlockFilter
    , atCheckpoint : TransactionBlockFilter -> TransactionBlockFilter
    , beforeCheckpoint : TransactionBlockFilter -> TransactionBlockFilter
    , affectedAddress : TransactionBlockFilter -> TransactionBlockFilter
    , affectedObject : TransactionBlockFilter -> TransactionBlockFilter
    , sentAddress : TransactionBlockFilter -> TransactionBlockFilter
    , inputObject : TransactionBlockFilter -> TransactionBlockFilter
    , changedObject : TransactionBlockFilter -> TransactionBlockFilter
    , transactionIds : TransactionBlockFilter -> TransactionBlockFilter
    }
null =
    { function =
        \inputObj ->
            GraphQL.InputObject.addField
                "function"
                "String"
                Json.Encode.null
                inputObj
    , kind =
        \inputObj ->
            GraphQL.InputObject.addField
                "kind"
                "TransactionBlockKindInput"
                Json.Encode.null
                inputObj
    , afterCheckpoint =
        \inputObj ->
            GraphQL.InputObject.addField
                "afterCheckpoint"
                "UInt53"
                Json.Encode.null
                inputObj
    , atCheckpoint =
        \inputObj ->
            GraphQL.InputObject.addField
                "atCheckpoint"
                "UInt53"
                Json.Encode.null
                inputObj
    , beforeCheckpoint =
        \inputObj ->
            GraphQL.InputObject.addField
                "beforeCheckpoint"
                "UInt53"
                Json.Encode.null
                inputObj
    , affectedAddress =
        \inputObj ->
            GraphQL.InputObject.addField
                "affectedAddress"
                "SuiAddress"
                Json.Encode.null
                inputObj
    , affectedObject =
        \inputObj ->
            GraphQL.InputObject.addField
                "affectedObject"
                "SuiAddress"
                Json.Encode.null
                inputObj
    , sentAddress =
        \inputObj ->
            GraphQL.InputObject.addField
                "sentAddress"
                "SuiAddress"
                Json.Encode.null
                inputObj
    , inputObject =
        \inputObj ->
            GraphQL.InputObject.addField
                "inputObject"
                "SuiAddress"
                Json.Encode.null
                inputObj
    , changedObject =
        \inputObj ->
            GraphQL.InputObject.addField
                "changedObject"
                "SuiAddress"
                Json.Encode.null
                inputObj
    , transactionIds =
        \inputObj ->
            GraphQL.InputObject.addField
                "transactionIds"
                "[String!]"
                Json.Encode.null
                inputObj
    }


{-| This is a rarely needed function and it is unlikely that you will need this.

It may be useful in edge cases where you need to do mocking/simulation of your queries within your app (tests shouldn't need this).
-}
decoder : Json.Decode.Decoder TransactionBlockFilter
decoder =
    Json.Decode.map
        (\mapUnpack ->
             GraphQL.InputObject.raw
                 "TransactionBlockFilter"
                 (List.map
                      (\mapUnpack0 ->
                           ( mapUnpack0.name
                           , { gqlTypeName = mapUnpack0.type_
                             , value = Dict.get mapUnpack0.name mapUnpack
                             }
                           )
                      )
                      [ { name = "function", type_ = "String" }
                      , { name = "kind", type_ = "TransactionBlockKindInput" }
                      , { name = "afterCheckpoint", type_ = "UInt53" }
                      , { name = "atCheckpoint", type_ = "UInt53" }
                      , { name = "beforeCheckpoint", type_ = "UInt53" }
                      , { name = "affectedAddress", type_ = "SuiAddress" }
                      , { name = "affectedObject", type_ = "SuiAddress" }
                      , { name = "sentAddress", type_ = "SuiAddress" }
                      , { name = "inputObject", type_ = "SuiAddress" }
                      , { name = "changedObject", type_ = "SuiAddress" }
                      , { name = "transactionIds", type_ = "[String!]" }
                      ]
                 )
        )
        (Json.Decode.dict Json.Decode.value)