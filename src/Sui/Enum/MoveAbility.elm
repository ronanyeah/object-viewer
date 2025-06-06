module Sui.Enum.MoveAbility exposing (MoveAbility(..), all, decoder, encode)

{-| This file wass generated using `elm-gql`

Please avoid modifying directly.

@docs MoveAbility, all, decoder, encode

-}

import Json.Decode
import Json.Encode


type MoveAbility
    = COPY
    | DROP
    | KEY
    | STORE


all : List MoveAbility
all =
    [ COPY, DROP, KEY, STORE ]


decoder : Json.Decode.Decoder MoveAbility
decoder =
    Json.Decode.andThen
        (\andThenUnpack ->
            case andThenUnpack of
                "COPY" ->
                    Json.Decode.succeed COPY

                "DROP" ->
                    Json.Decode.succeed DROP

                "KEY" ->
                    Json.Decode.succeed KEY

                "STORE" ->
                    Json.Decode.succeed STORE

                _ ->
                    Json.Decode.fail "Invalid type"
        )
        Json.Decode.string


encode : MoveAbility -> Json.Encode.Value
encode val =
    case val of
        COPY ->
            Json.Encode.string "COPY"

        DROP ->
            Json.Encode.string "DROP"

        KEY ->
            Json.Encode.string "KEY"

        STORE ->
            Json.Encode.string "STORE"
