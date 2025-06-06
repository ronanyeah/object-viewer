module Sui.Enum.MoveVisibility exposing (MoveVisibility(..), all, decoder, encode)

{-| This file wass generated using `elm-gql`

Please avoid modifying directly.

@docs MoveVisibility, all, decoder, encode

-}

import Json.Decode
import Json.Encode


type MoveVisibility
    = PUBLIC
    | PRIVATE
    | FRIEND


all : List MoveVisibility
all =
    [ PUBLIC, PRIVATE, FRIEND ]


decoder : Json.Decode.Decoder MoveVisibility
decoder =
    Json.Decode.andThen
        (\andThenUnpack ->
            case andThenUnpack of
                "PUBLIC" ->
                    Json.Decode.succeed PUBLIC

                "PRIVATE" ->
                    Json.Decode.succeed PRIVATE

                "FRIEND" ->
                    Json.Decode.succeed FRIEND

                _ ->
                    Json.Decode.fail "Invalid type"
        )
        Json.Decode.string


encode : MoveVisibility -> Json.Encode.Value
encode val =
    case val of
        PUBLIC ->
            Json.Encode.string "PUBLIC"

        PRIVATE ->
            Json.Encode.string "PRIVATE"

        FRIEND ->
            Json.Encode.string "FRIEND"
