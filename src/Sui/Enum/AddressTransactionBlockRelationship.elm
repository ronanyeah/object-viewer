module Sui.Enum.AddressTransactionBlockRelationship exposing (AddressTransactionBlockRelationship(..), all, decoder, encode)

{-|

This file wass generated using `elm-gql`

Please avoid modifying directly.


@docs AddressTransactionBlockRelationship, all, decoder, encode


-}


import Json.Decode
import Json.Encode


type AddressTransactionBlockRelationship
    = SENT
    | AFFECTED


all : List AddressTransactionBlockRelationship
all =
    [ SENT, AFFECTED ]


decoder : Json.Decode.Decoder AddressTransactionBlockRelationship
decoder =
    Json.Decode.andThen
        (\andThenUnpack ->
             case andThenUnpack of
                 "SENT" ->
                     Json.Decode.succeed SENT

                 "AFFECTED" ->
                     Json.Decode.succeed AFFECTED

                 _ ->
                     Json.Decode.fail "Invalid type"
        )
        Json.Decode.string


encode : AddressTransactionBlockRelationship -> Json.Encode.Value
encode val =
    case val of
        SENT ->
            Json.Encode.string "SENT"

        AFFECTED ->
            Json.Encode.string "AFFECTED"