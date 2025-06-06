module Utils exposing (..)


filterSystemParams =
    List.filter
        (\val ->
            not (String.contains "0x0000000000000000000000000000000000000000000000000000000000000002::tx_context::TxContext" val.repr)
        )
