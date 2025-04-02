module Sui.Input.CheckpointId exposing
    ( CheckpointId
    , decoder
    , digest
    , input
    , null
    , sequenceNumber
    )

{-|
## Creating an input

@docs CheckpointId, input, decoder

## Null values

@docs null

## Optional fields

@docs digest, sequenceNumber
-}


import Dict
import GraphQL.InputObject
import Json.Decode
import Json.Encode
import Sui
import Sui.Input


type alias CheckpointId =
    Sui.Input.CheckpointId


input : CheckpointId
input =
    GraphQL.InputObject.inputObject "CheckpointId"


digest : String -> CheckpointId -> CheckpointId
digest newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "digest"
        "String"
        (Json.Encode.string newArg_)
        inputObj_


sequenceNumber : Sui.Uint53 -> CheckpointId -> CheckpointId
sequenceNumber newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "sequenceNumber"
        "UInt53"
        (Sui.uint53.encode newArg_)
        inputObj_


null :
    { digest : CheckpointId -> CheckpointId
    , sequenceNumber : CheckpointId -> CheckpointId
    }
null =
    { digest =
        \inputObj ->
            GraphQL.InputObject.addField
                "digest"
                "String"
                Json.Encode.null
                inputObj
    , sequenceNumber =
        \inputObj ->
            GraphQL.InputObject.addField
                "sequenceNumber"
                "UInt53"
                Json.Encode.null
                inputObj
    }


{-| This is a rarely needed function and it is unlikely that you will need this.

It may be useful in edge cases where you need to do mocking/simulation of your queries within your app (tests shouldn't need this).
-}
decoder : Json.Decode.Decoder CheckpointId
decoder =
    Json.Decode.map
        (\mapUnpack ->
             GraphQL.InputObject.raw
                 "CheckpointId"
                 (List.map
                      (\mapUnpack0 ->
                           ( mapUnpack0.name
                           , { gqlTypeName = mapUnpack0.type_
                             , value = Dict.get mapUnpack0.name mapUnpack
                             }
                           )
                      )
                      [ { name = "digest", type_ = "String" }
                      , { name = "sequenceNumber", type_ = "UInt53" }
                      ]
                 )
        )
        (Json.Decode.dict Json.Decode.value)