module Types exposing (..)

import Dict exposing (Dict)
import GraphQL.Engine
import Queries.FetchOwnedObjects
import Set exposing (Set)
import Sui.Enum.MoveAbility


type alias Model =
    { addrInput : String
    , addr : Maybe String
    , objects : Dict String (Dict String Obj)
    , visiblePackages : Set String
    }


type alias Flags =
    {}


type Msg
    = AddrChg String
    | TogglePackage String
    | AddrSubmit
    | AddrClear
    | ObjsCb
        String
        (Result
            GraphQL.Engine.Error
            Queries.FetchOwnedObjects.Response
        )


type alias Obj =
    { id : String
    , typename : String
    , package : String
    , abilities : List Sui.Enum.MoveAbility.MoveAbility
    }
