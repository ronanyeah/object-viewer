module Sui.Enum.DomainFormat exposing (DomainFormat(..), all, decoder, encode)

{-|

This file wass generated using `elm-gql`

Please avoid modifying directly.


@docs DomainFormat, all, decoder, encode


-}


import Json.Decode
import Json.Encode


type DomainFormat
    = AT
    | DOT


all : List DomainFormat
all =
    [ AT, DOT ]


decoder : Json.Decode.Decoder DomainFormat
decoder =
    Json.Decode.andThen
        (\andThenUnpack ->
             case andThenUnpack of
                 "AT" ->
                     Json.Decode.succeed AT

                 "DOT" ->
                     Json.Decode.succeed DOT

                 _ ->
                     Json.Decode.fail "Invalid type"
        )
        Json.Decode.string


encode : DomainFormat -> Json.Encode.Value
encode val =
    case val of
        AT ->
            Json.Encode.string "AT"

        DOT ->
            Json.Encode.string "DOT"