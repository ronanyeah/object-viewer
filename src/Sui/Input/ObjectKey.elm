module Sui.Input.ObjectKey exposing (ObjectKey, input, decoder)

{-|


## Creating an input

@docs ObjectKey, input, decoder

-}

import Dict
import GraphQL.InputObject
import Json.Decode
import Json.Encode
import Sui
import Sui.Input


type alias ObjectKey =
    Sui.Input.ObjectKey


input : { objectId : Sui.SuiAddress, version : Sui.Uint53 } -> ObjectKey
input requiredArgs =
    GraphQL.InputObject.addField
        "version"
        "UInt53!"
        (Sui.uint53.encode requiredArgs.version)
        (GraphQL.InputObject.addField
            "objectId"
            "SuiAddress!"
            (Sui.suiAddress.encode requiredArgs.objectId)
            (GraphQL.InputObject.inputObject "ObjectKey")
        )


{-| This is a rarely needed function and it is unlikely that you will need this.

It may be useful in edge cases where you need to do mocking/simulation of your queries within your app (tests shouldn't need this).

-}
decoder : Json.Decode.Decoder ObjectKey
decoder =
    Json.Decode.map
        (\mapUnpack ->
            GraphQL.InputObject.raw
                "ObjectKey"
                (List.map
                    (\mapUnpack0 ->
                        ( mapUnpack0.name
                        , { gqlTypeName = mapUnpack0.type_
                          , value = Dict.get mapUnpack0.name mapUnpack
                          }
                        )
                    )
                    [ { name = "objectId", type_ = "SuiAddress!" }
                    , { name = "version", type_ = "UInt53!" }
                    ]
                )
        )
        (Json.Decode.dict Json.Decode.value)
