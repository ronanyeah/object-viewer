module Sui.Enum.TransactionBlockKindInput exposing (TransactionBlockKindInput(..), all, decoder, encode)

{-|

This file wass generated using `elm-gql`

Please avoid modifying directly.


@docs TransactionBlockKindInput, all, decoder, encode


-}


import Json.Decode
import Json.Encode


type TransactionBlockKindInput
    = SYSTEM_TX
    | PROGRAMMABLE_TX


all : List TransactionBlockKindInput
all =
    [ SYSTEM_TX, PROGRAMMABLE_TX ]


decoder : Json.Decode.Decoder TransactionBlockKindInput
decoder =
    Json.Decode.andThen
        (\andThenUnpack ->
             case andThenUnpack of
                 "SYSTEM_TX" ->
                     Json.Decode.succeed SYSTEM_TX

                 "PROGRAMMABLE_TX" ->
                     Json.Decode.succeed PROGRAMMABLE_TX

                 _ ->
                     Json.Decode.fail "Invalid type"
        )
        Json.Decode.string


encode : TransactionBlockKindInput -> Json.Encode.Value
encode val =
    case val of
        SYSTEM_TX ->
            Json.Encode.string "SYSTEM_TX"

        PROGRAMMABLE_TX ->
            Json.Encode.string "PROGRAMMABLE_TX"