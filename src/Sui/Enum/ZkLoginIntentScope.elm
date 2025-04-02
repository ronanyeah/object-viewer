module Sui.Enum.ZkLoginIntentScope exposing (ZkLoginIntentScope(..), all, decoder, encode)

{-|

This file wass generated using `elm-gql`

Please avoid modifying directly.


@docs ZkLoginIntentScope, all, decoder, encode


-}


import Json.Decode
import Json.Encode


type ZkLoginIntentScope
    = TRANSACTION_DATA
    | PERSONAL_MESSAGE


all : List ZkLoginIntentScope
all =
    [ TRANSACTION_DATA, PERSONAL_MESSAGE ]


decoder : Json.Decode.Decoder ZkLoginIntentScope
decoder =
    Json.Decode.andThen
        (\andThenUnpack ->
             case andThenUnpack of
                 "TRANSACTION_DATA" ->
                     Json.Decode.succeed TRANSACTION_DATA

                 "PERSONAL_MESSAGE" ->
                     Json.Decode.succeed PERSONAL_MESSAGE

                 _ ->
                     Json.Decode.fail "Invalid type"
        )
        Json.Decode.string


encode : ZkLoginIntentScope -> Json.Encode.Value
encode val =
    case val of
        TRANSACTION_DATA ->
            Json.Encode.string "TRANSACTION_DATA"

        PERSONAL_MESSAGE ->
            Json.Encode.string "PERSONAL_MESSAGE"