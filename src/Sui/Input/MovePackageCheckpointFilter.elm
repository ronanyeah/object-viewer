module Sui.Input.MovePackageCheckpointFilter exposing
    ( MovePackageCheckpointFilter
    , afterCheckpoint
    , beforeCheckpoint
    , decoder
    , input
    , null
    )

{-|
## Creating an input

@docs MovePackageCheckpointFilter, input, decoder

## Null values

@docs null

## Optional fields

@docs afterCheckpoint, beforeCheckpoint
-}


import Dict
import GraphQL.InputObject
import Json.Decode
import Json.Encode
import Sui
import Sui.Input


type alias MovePackageCheckpointFilter =
    Sui.Input.MovePackageCheckpointFilter


input : MovePackageCheckpointFilter
input =
    GraphQL.InputObject.inputObject "MovePackageCheckpointFilter"


afterCheckpoint :
    Sui.Uint53 -> MovePackageCheckpointFilter -> MovePackageCheckpointFilter
afterCheckpoint newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "afterCheckpoint"
        "UInt53"
        (Sui.uint53.encode newArg_)
        inputObj_


beforeCheckpoint :
    Sui.Uint53 -> MovePackageCheckpointFilter -> MovePackageCheckpointFilter
beforeCheckpoint newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "beforeCheckpoint"
        "UInt53"
        (Sui.uint53.encode newArg_)
        inputObj_


null :
    { afterCheckpoint :
        MovePackageCheckpointFilter -> MovePackageCheckpointFilter
    , beforeCheckpoint :
        MovePackageCheckpointFilter -> MovePackageCheckpointFilter
    }
null =
    { afterCheckpoint =
        \inputObj ->
            GraphQL.InputObject.addField
                "afterCheckpoint"
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
    }


{-| This is a rarely needed function and it is unlikely that you will need this.

It may be useful in edge cases where you need to do mocking/simulation of your queries within your app (tests shouldn't need this).
-}
decoder : Json.Decode.Decoder MovePackageCheckpointFilter
decoder =
    Json.Decode.map
        (\mapUnpack ->
             GraphQL.InputObject.raw
                 "MovePackageCheckpointFilter"
                 (List.map
                      (\mapUnpack0 ->
                           ( mapUnpack0.name
                           , { gqlTypeName = mapUnpack0.type_
                             , value = Dict.get mapUnpack0.name mapUnpack
                             }
                           )
                      )
                      [ { name = "afterCheckpoint", type_ = "UInt53" }
                      , { name = "beforeCheckpoint", type_ = "UInt53" }
                      ]
                 )
        )
        (Json.Decode.dict Json.Decode.value)