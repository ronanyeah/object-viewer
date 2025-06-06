module Types exposing (..)

import Dict exposing (Dict)
import GraphQL.Engine
import Ports
import Queries.FetchOwnedObjects
import Queries.FetchPackage exposing (LatestPackage_Modules_Module_Functions_Nodes, Module)
import Set exposing (Set)
import Sui.Enum.MoveAbility


type alias Model =
    { addrInput : String
    , addr : Maybe String
    , objects : Dict String (Dict String Obj)
    , visiblePackages : Set String
    , package : Maybe ( String, List Module )
    , selectedFunction : Maybe SelectedFunction
    , functionInputs : Dict String String
    , view : View
    , network : Network
    }


type alias SelectedFunction =
    { packageId : String
    , moduleName : String
    , function : LatestPackage_Modules_Module_Functions_Nodes
    }


type alias Flags =
    {}


type Msg
    = AddrChg String
    | TogglePackage String
    | AddrSubmit
    | AddrClear
    | SetView View
    | FetchPackage String
    | SelectFunction SelectedFunction
    | FunctionInputChange String String
    | FunctionExecute Ports.FunctionCall
    | SetNetwork Network
    | ObjsCb
        String
        (Result
            GraphQL.Engine.Error
            Queries.FetchOwnedObjects.Response
        )
    | PackageCb
        String
        (Result
            GraphQL.Engine.Error
            Queries.FetchPackage.Response
        )


type View
    = ViewWalletObjects
    | ViewPackageDefinitions
    | ViewFunction


type Network
    = Mainnet
    | Testnet


type alias Obj =
    { id : String
    , typename : String
    , package : String
    , abilities : List Sui.Enum.MoveAbility.MoveAbility
    }
