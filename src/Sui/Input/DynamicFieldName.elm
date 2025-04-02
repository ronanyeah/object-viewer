module Sui.Input.DynamicFieldName exposing (DynamicFieldName, decoder, input)

{-|
## Creating an input

@docs DynamicFieldName, input, decoder
-}


import Dict
import GraphQL.InputObject
import Json.Decode
import Json.Encode
import Sui
import Sui.Input


type alias DynamicFieldName =
    Sui.Input.DynamicFieldName


input : { type_ : String, bcs : Sui.Base64 } -> DynamicFieldName
input requiredArgs =
    GraphQL.InputObject.addField
        "bcs"
        "Base64!"
        (Sui.base64.encode requiredArgs.bcs)
        (GraphQL.InputObject.addField
             "type"
             "String!"
             (Json.Encode.string requiredArgs.type_)
             (GraphQL.InputObject.inputObject "DynamicFieldName")
        )


{-| This is a rarely needed function and it is unlikely that you will need this.

It may be useful in edge cases where you need to do mocking/simulation of your queries within your app (tests shouldn't need this).
-}
decoder : Json.Decode.Decoder DynamicFieldName
decoder =
    Json.Decode.map
        (\mapUnpack ->
             GraphQL.InputObject.raw
                 "DynamicFieldName"
                 (List.map
                      (\mapUnpack0 ->
                           ( mapUnpack0.name
                           , { gqlTypeName = mapUnpack0.type_
                             , value = Dict.get mapUnpack0.name mapUnpack
                             }
                           )
                      )
                      [ { name = "type", type_ = "String!" }
                      , { name = "bcs", type_ = "Base64!" }
                      ]
                 )
        )
        (Json.Decode.dict Json.Decode.value)