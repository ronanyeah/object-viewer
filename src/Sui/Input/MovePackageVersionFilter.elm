module Sui.Input.MovePackageVersionFilter exposing
    ( MovePackageVersionFilter
    , afterVersion
    , beforeVersion
    , decoder
    , input
    , null
    )

{-|
## Creating an input

@docs MovePackageVersionFilter, input, decoder

## Null values

@docs null

## Optional fields

@docs afterVersion, beforeVersion
-}


import Dict
import GraphQL.InputObject
import Json.Decode
import Json.Encode
import Sui
import Sui.Input


type alias MovePackageVersionFilter =
    Sui.Input.MovePackageVersionFilter


input : MovePackageVersionFilter
input =
    GraphQL.InputObject.inputObject "MovePackageVersionFilter"


afterVersion :
    Sui.Uint53 -> MovePackageVersionFilter -> MovePackageVersionFilter
afterVersion newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "afterVersion"
        "UInt53"
        (Sui.uint53.encode newArg_)
        inputObj_


beforeVersion :
    Sui.Uint53 -> MovePackageVersionFilter -> MovePackageVersionFilter
beforeVersion newArg_ inputObj_ =
    GraphQL.InputObject.addField
        "beforeVersion"
        "UInt53"
        (Sui.uint53.encode newArg_)
        inputObj_


null :
    { afterVersion : MovePackageVersionFilter -> MovePackageVersionFilter
    , beforeVersion : MovePackageVersionFilter -> MovePackageVersionFilter
    }
null =
    { afterVersion =
        \inputObj ->
            GraphQL.InputObject.addField
                "afterVersion"
                "UInt53"
                Json.Encode.null
                inputObj
    , beforeVersion =
        \inputObj ->
            GraphQL.InputObject.addField
                "beforeVersion"
                "UInt53"
                Json.Encode.null
                inputObj
    }


{-| This is a rarely needed function and it is unlikely that you will need this.

It may be useful in edge cases where you need to do mocking/simulation of your queries within your app (tests shouldn't need this).
-}
decoder : Json.Decode.Decoder MovePackageVersionFilter
decoder =
    Json.Decode.map
        (\mapUnpack ->
             GraphQL.InputObject.raw
                 "MovePackageVersionFilter"
                 (List.map
                      (\mapUnpack0 ->
                           ( mapUnpack0.name
                           , { gqlTypeName = mapUnpack0.type_
                             , value = Dict.get mapUnpack0.name mapUnpack
                             }
                           )
                      )
                      [ { name = "afterVersion", type_ = "UInt53" }
                      , { name = "beforeVersion", type_ = "UInt53" }
                      ]
                 )
        )
        (Json.Decode.dict Json.Decode.value)