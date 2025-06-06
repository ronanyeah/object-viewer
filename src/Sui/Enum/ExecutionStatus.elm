module Sui.Enum.ExecutionStatus exposing (ExecutionStatus(..), all, decoder, encode)

{-| This file wass generated using `elm-gql`

Please avoid modifying directly.

@docs ExecutionStatus, all, decoder, encode

-}

import Json.Decode
import Json.Encode


type ExecutionStatus
    = SUCCESS
    | FAILURE


all : List ExecutionStatus
all =
    [ SUCCESS, FAILURE ]


decoder : Json.Decode.Decoder ExecutionStatus
decoder =
    Json.Decode.andThen
        (\andThenUnpack ->
            case andThenUnpack of
                "SUCCESS" ->
                    Json.Decode.succeed SUCCESS

                "FAILURE" ->
                    Json.Decode.succeed FAILURE

                _ ->
                    Json.Decode.fail "Invalid type"
        )
        Json.Decode.string


encode : ExecutionStatus -> Json.Encode.Value
encode val =
    case val of
        SUCCESS ->
            Json.Encode.string "SUCCESS"

        FAILURE ->
            Json.Encode.string "FAILURE"
