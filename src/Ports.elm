port module Ports exposing (..)

-- OUT


type alias FunctionCall =
    { functionPath : String
    , arguments : List ( String, String )
    }


port log : String -> Cmd msg


port dryRunTx : FunctionCall -> Cmd msg
