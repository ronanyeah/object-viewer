module Sui.Enum.Feature exposing (Feature(..), all, decoder, encode)

{-|

This file wass generated using `elm-gql`

Please avoid modifying directly.


@docs Feature, all, decoder, encode


-}


import Json.Decode
import Json.Encode


type Feature
    = ANALYTICS
    | COINS
    | DYNAMIC_FIELDS
    | NAME_SERVICE
    | SUBSCRIPTIONS
    | SYSTEM_STATE
    | MOVE_REGISTRY


all : List Feature
all =
    [ ANALYTICS
    , COINS
    , DYNAMIC_FIELDS
    , NAME_SERVICE
    , SUBSCRIPTIONS
    , SYSTEM_STATE
    , MOVE_REGISTRY
    ]


decoder : Json.Decode.Decoder Feature
decoder =
    Json.Decode.andThen
        (\andThenUnpack ->
             case andThenUnpack of
                 "ANALYTICS" ->
                     Json.Decode.succeed ANALYTICS

                 "COINS" ->
                     Json.Decode.succeed COINS

                 "DYNAMIC_FIELDS" ->
                     Json.Decode.succeed DYNAMIC_FIELDS

                 "NAME_SERVICE" ->
                     Json.Decode.succeed NAME_SERVICE

                 "SUBSCRIPTIONS" ->
                     Json.Decode.succeed SUBSCRIPTIONS

                 "SYSTEM_STATE" ->
                     Json.Decode.succeed SYSTEM_STATE

                 "MOVE_REGISTRY" ->
                     Json.Decode.succeed MOVE_REGISTRY

                 _ ->
                     Json.Decode.fail "Invalid type"
        )
        Json.Decode.string


encode : Feature -> Json.Encode.Value
encode val =
    case val of
        ANALYTICS ->
            Json.Encode.string "ANALYTICS"

        COINS ->
            Json.Encode.string "COINS"

        DYNAMIC_FIELDS ->
            Json.Encode.string "DYNAMIC_FIELDS"

        NAME_SERVICE ->
            Json.Encode.string "NAME_SERVICE"

        SUBSCRIPTIONS ->
            Json.Encode.string "SUBSCRIPTIONS"

        SYSTEM_STATE ->
            Json.Encode.string "SYSTEM_STATE"

        MOVE_REGISTRY ->
            Json.Encode.string "MOVE_REGISTRY"