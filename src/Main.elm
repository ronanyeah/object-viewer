module Main exposing (main)

import Browser
import Dict
import Set
import Types exposing (..)
import Update exposing (update)
import View exposing (view)


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { objects = Dict.empty
      , addr = Nothing
      , addrInput = ""
      , visiblePackages = Set.empty
      , view = ViewWalletObjects
      , package = Nothing
      , selectedFunction = Nothing
      , functionInputs = Dict.empty
      , network = Mainnet
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
