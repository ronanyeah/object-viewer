module Sui.Enum.ObjectKind exposing (ObjectKind(..), all, decoder, encode)

{-|

This file wass generated using `elm-gql`

Please avoid modifying directly.


@docs ObjectKind, all, decoder, encode


-}


import Json.Decode
import Json.Encode


type ObjectKind
    = NOT_INDEXED
    | INDEXED


all : List ObjectKind
all =
    [ NOT_INDEXED, INDEXED ]


decoder : Json.Decode.Decoder ObjectKind
decoder =
    Json.Decode.andThen
        (\andThenUnpack ->
             case andThenUnpack of
                 "NOT_INDEXED" ->
                     Json.Decode.succeed NOT_INDEXED

                 "INDEXED" ->
                     Json.Decode.succeed INDEXED

                 _ ->
                     Json.Decode.fail "Invalid type"
        )
        Json.Decode.string


encode : ObjectKind -> Json.Encode.Value
encode val =
    case val of
        NOT_INDEXED ->
            Json.Encode.string "NOT_INDEXED"

        INDEXED ->
            Json.Encode.string "INDEXED"