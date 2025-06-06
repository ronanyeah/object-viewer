module Types exposing (..)

import Dict exposing (Dict)
import GraphQL.Engine
import Ports
import Queries.FetchOwnedObjects
import Queries.FetchPackage exposing (Module)
import Set exposing (Set)
import Sui.Enum.MoveAbility


type alias Model =
    { addrInput : String
    , addr : Maybe String
    , objects : Dict String (Dict String Obj)
    , visiblePackages : Set String
    , package : Maybe (List Module)
    , view : View
    }


type alias Flags =
    {}


type Msg
    = AddrChg String
    | TogglePackage String
    | AddrSubmit
    | AddrClear
    | FunctionExecute Ports.FunctionCall
    | ObjsCb
        String
        (Result
            GraphQL.Engine.Error
            Queries.FetchOwnedObjects.Response
        )
    | PackageCb
        (Result
            GraphQL.Engine.Error
            Queries.FetchPackage.Response
        )


type View
    = ViewWalletObjects
    | ViewPackageDefinitions


type alias Obj =
    { id : String
    , typename : String
    , package : String
    , abilities : List Sui.Enum.MoveAbility.MoveAbility
    }
