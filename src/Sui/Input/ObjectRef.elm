module Sui.Input.ObjectRef exposing (ObjectRef, decoder, input)

{-|
## Creating an input

@docs ObjectRef, input, decoder
-}


import Dict
import GraphQL.InputObject
import Json.Decode
import Json.Encode
import Sui
import Sui.Input


type alias ObjectRef =
    Sui.Input.ObjectRef


input :
    { address : Sui.SuiAddress, version : Sui.Uint53, digest : String }
    -> ObjectRef
input requiredArgs =
    GraphQL.InputObject.addField
        "digest"
        "String!"
        (Json.Encode.string requiredArgs.digest)
        (GraphQL.InputObject.addField
             "version"
             "UInt53!"
             (Sui.uint53.encode requiredArgs.version)
             (GraphQL.InputObject.addField
                  "address"
                  "SuiAddress!"
                  (Sui.suiAddress.encode requiredArgs.address)
                  (GraphQL.InputObject.inputObject "ObjectRef")
             )
        )


{-| This is a rarely needed function and it is unlikely that you will need this.

It may be useful in edge cases where you need to do mocking/simulation of your queries within your app (tests shouldn't need this).
-}
decoder : Json.Decode.Decoder ObjectRef
decoder =
    Json.Decode.map
        (\mapUnpack ->
             GraphQL.InputObject.raw
                 "ObjectRef"
                 (List.map
                      (\mapUnpack0 ->
                           ( mapUnpack0.name
                           , { gqlTypeName = mapUnpack0.type_
                             , value = Dict.get mapUnpack0.name mapUnpack
                             }
                           )
                      )
                      [ { name = "address", type_ = "SuiAddress!" }
                      , { name = "version", type_ = "UInt53!" }
                      , { name = "digest", type_ = "String!" }
                      ]
                 )
        )
        (Json.Decode.dict Json.Decode.value)