module Sui.Enum.StakeStatus exposing (StakeStatus(..), all, decoder, encode)

{-| This file wass generated using `elm-gql`

Please avoid modifying directly.

@docs StakeStatus, all, decoder, encode

-}

import Json.Decode
import Json.Encode


type StakeStatus
    = ACTIVE
    | PENDING
    | UNSTAKED


all : List StakeStatus
all =
    [ ACTIVE, PENDING, UNSTAKED ]


decoder : Json.Decode.Decoder StakeStatus
decoder =
    Json.Decode.andThen
        (\andThenUnpack ->
            case andThenUnpack of
                "ACTIVE" ->
                    Json.Decode.succeed ACTIVE

                "PENDING" ->
                    Json.Decode.succeed PENDING

                "UNSTAKED" ->
                    Json.Decode.succeed UNSTAKED

                _ ->
                    Json.Decode.fail "Invalid type"
        )
        Json.Decode.string


encode : StakeStatus -> Json.Encode.Value
encode val =
    case val of
        ACTIVE ->
            Json.Encode.string "ACTIVE"

        PENDING ->
            Json.Encode.string "PENDING"

        UNSTAKED ->
            Json.Encode.string "UNSTAKED"
