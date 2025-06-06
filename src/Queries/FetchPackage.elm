module Queries.FetchPackage exposing
    ( Input
    , Response
    , query
    , LatestPackage, Modules, Module, Functions, LatestPackage_Modules_Module_Functions_Nodes, Return, Parameters, LatestPackage_Modules_Module_Functions_Nodes_TypeParameters, Enums, LatestPackage_Modules_Module_Enums_Nodes, Variants, Module_Fields, Module_Type, Module_TypeParameters, Structs, Module_Nodes, Fields, Type, TypeParameters, Friends, Nodes
    )

{-| This file is generated from graphql/queries.graphql using `elm-gql`

Please avoid modifying directly.

@docs Input

@docs Response

@docs query

@docs LatestPackage, Modules, Module, Functions, LatestPackage_Modules_Module_Functions_Nodes, Return, Parameters, LatestPackage_Modules_Module_Functions_Nodes_TypeParameters, Enums, LatestPackage_Modules_Module_Enums_Nodes, Variants, Module_Fields, Module_Type, Module_TypeParameters, Structs, Module_Nodes, Fields, Type, TypeParameters, Friends, Nodes

-}

import GraphQL.Decode
import GraphQL.Engine
import GraphQL.InputObject
import Json.Decode
import Json.Encode
import Sui
import Sui.Enum.MoveAbility
import Sui.Enum.MoveVisibility


type alias Input =
    { address : Sui.SuiAddress }


query : Input -> Sui.Query Response
query args =
    GraphQL.Engine.operation
        (Just "fetchPackage")
        (\version_ ->
            { args =
                GraphQL.InputObject.toFieldList
                    (GraphQL.InputObject.inputObject
                        "Input"
                        |> GraphQL.InputObject.addField
                            "address"
                            "SuiAddress!"
                            (Sui.suiAddress.encode args.address)
                    )
            , body = toPayload_ version_
            , fragments = toFragments_ version_
            }
        )
        decoder_



{- Return data -}


type alias Response =
    { latestPackage : Maybe LatestPackage }


type alias LatestPackage =
    { modules : Maybe Modules }


type alias Modules =
    { module_ : List Module }


type alias Module =
    { name : String
    , friends : Friends
    , structs : Maybe Structs
    , enums : Maybe Enums
    , functions : Maybe Functions
    }


type alias Functions =
    { nodes : List LatestPackage_Modules_Module_Functions_Nodes }


type alias LatestPackage_Modules_Module_Functions_Nodes =
    { name : String
    , visibility : Maybe Sui.Enum.MoveVisibility.MoveVisibility
    , isEntry : Maybe Bool
    , typeParameters :
        Maybe (List LatestPackage_Modules_Module_Functions_Nodes_TypeParameters)
    , parameters : Maybe (List Parameters)
    , return : Maybe (List Return)
    }


type alias Return =
    { repr : String }


type alias Parameters =
    { repr : String }


type alias LatestPackage_Modules_Module_Functions_Nodes_TypeParameters =
    { constraints : List Sui.Enum.MoveAbility.MoveAbility }


type alias Enums =
    { nodes : List LatestPackage_Modules_Module_Enums_Nodes }


type alias LatestPackage_Modules_Module_Enums_Nodes =
    { name : String
    , abilities : Maybe (List Sui.Enum.MoveAbility.MoveAbility)
    , typeParameters : Maybe (List Module_TypeParameters)
    , variants : Maybe (List Variants)
    }


type alias Variants =
    { name : String, fields : Maybe (List Module_Fields) }


type alias Module_Fields =
    { name : String, type_ : Maybe Module_Type }


type alias Module_Type =
    { repr : String }


type alias Module_TypeParameters =
    { isPhantom : Bool, constraints : List Sui.Enum.MoveAbility.MoveAbility }


type alias Structs =
    { nodes : List Module_Nodes }


type alias Module_Nodes =
    { name : String
    , abilities : Maybe (List Sui.Enum.MoveAbility.MoveAbility)
    , typeParameters : Maybe (List TypeParameters)
    , fields : Maybe (List Fields)
    }


type alias Fields =
    { name : String, type_ : Maybe Type }


type alias Type =
    { repr : String }


type alias TypeParameters =
    { isPhantom : Bool, constraints : List Sui.Enum.MoveAbility.MoveAbility }


type alias Friends =
    { nodes : List Nodes }


type alias Nodes =
    { name : String }


decoder_ : Int -> Json.Decode.Decoder Response
decoder_ version_ =
    Json.Decode.succeed Response
        |> GraphQL.Decode.versionedField
            version_
            "latestPackage"
            (Json.Decode.nullable
                (Json.Decode.succeed
                    LatestPackage
                    |> GraphQL.Decode.field
                        "modules"
                        (Json.Decode.nullable
                            (Json.Decode.succeed
                                Modules
                                |> GraphQL.Decode.field
                                    "module"
                                    (Json.Decode.list
                                        (Json.Decode.succeed
                                            Module
                                            |> GraphQL.Decode.field
                                                "name"
                                                Json.Decode.string
                                            |> GraphQL.Decode.field
                                                "friends"
                                                (Json.Decode.succeed
                                                    Friends
                                                    |> GraphQL.Decode.field
                                                        "nodes"
                                                        (Json.Decode.list
                                                            (Json.Decode.succeed
                                                                Nodes
                                                                |> GraphQL.Decode.field
                                                                    "name"
                                                                    Json.Decode.string
                                                            )
                                                        )
                                                )
                                            |> GraphQL.Decode.field
                                                "structs"
                                                (Json.Decode.nullable
                                                    (Json.Decode.succeed
                                                        Structs
                                                        |> GraphQL.Decode.field
                                                            "nodes"
                                                            (Json.Decode.list
                                                                (Json.Decode.succeed
                                                                    Module_Nodes
                                                                    |> GraphQL.Decode.field
                                                                        "name"
                                                                        Json.Decode.string
                                                                    |> GraphQL.Decode.field
                                                                        "abilities"
                                                                        (Json.Decode.nullable
                                                                            (Json.Decode.list
                                                                                Sui.Enum.MoveAbility.decoder
                                                                            )
                                                                        )
                                                                    |> GraphQL.Decode.field
                                                                        "typeParameters"
                                                                        (Json.Decode.nullable
                                                                            (Json.Decode.list
                                                                                (Json.Decode.succeed
                                                                                    TypeParameters
                                                                                    |> GraphQL.Decode.field
                                                                                        "isPhantom"
                                                                                        Json.Decode.bool
                                                                                    |> GraphQL.Decode.field
                                                                                        "constraints"
                                                                                        (Json.Decode.list
                                                                                            Sui.Enum.MoveAbility.decoder
                                                                                        )
                                                                                )
                                                                            )
                                                                        )
                                                                    |> GraphQL.Decode.field
                                                                        "fields"
                                                                        (Json.Decode.nullable
                                                                            (Json.Decode.list
                                                                                (Json.Decode.succeed
                                                                                    Fields
                                                                                    |> GraphQL.Decode.field
                                                                                        "name"
                                                                                        Json.Decode.string
                                                                                    |> GraphQL.Decode.field
                                                                                        "type"
                                                                                        (Json.Decode.nullable
                                                                                            (Json.Decode.succeed
                                                                                                Type
                                                                                                |> GraphQL.Decode.field
                                                                                                    "repr"
                                                                                                    Json.Decode.string
                                                                                            )
                                                                                        )
                                                                                )
                                                                            )
                                                                        )
                                                                )
                                                            )
                                                    )
                                                )
                                            |> GraphQL.Decode.field
                                                "enums"
                                                (Json.Decode.nullable
                                                    (Json.Decode.succeed
                                                        Enums
                                                        |> GraphQL.Decode.field
                                                            "nodes"
                                                            (Json.Decode.list
                                                                (Json.Decode.succeed
                                                                    LatestPackage_Modules_Module_Enums_Nodes
                                                                    |> GraphQL.Decode.field
                                                                        "name"
                                                                        Json.Decode.string
                                                                    |> GraphQL.Decode.field
                                                                        "abilities"
                                                                        (Json.Decode.nullable
                                                                            (Json.Decode.list
                                                                                Sui.Enum.MoveAbility.decoder
                                                                            )
                                                                        )
                                                                    |> GraphQL.Decode.field
                                                                        "typeParameters"
                                                                        (Json.Decode.nullable
                                                                            (Json.Decode.list
                                                                                (Json.Decode.succeed
                                                                                    Module_TypeParameters
                                                                                    |> GraphQL.Decode.field
                                                                                        "isPhantom"
                                                                                        Json.Decode.bool
                                                                                    |> GraphQL.Decode.field
                                                                                        "constraints"
                                                                                        (Json.Decode.list
                                                                                            Sui.Enum.MoveAbility.decoder
                                                                                        )
                                                                                )
                                                                            )
                                                                        )
                                                                    |> GraphQL.Decode.field
                                                                        "variants"
                                                                        (Json.Decode.nullable
                                                                            (Json.Decode.list
                                                                                (Json.Decode.succeed
                                                                                    Variants
                                                                                    |> GraphQL.Decode.field
                                                                                        "name"
                                                                                        Json.Decode.string
                                                                                    |> GraphQL.Decode.field
                                                                                        "fields"
                                                                                        (Json.Decode.nullable
                                                                                            (Json.Decode.list
                                                                                                (Json.Decode.succeed
                                                                                                    Module_Fields
                                                                                                    |> GraphQL.Decode.field
                                                                                                        "name"
                                                                                                        Json.Decode.string
                                                                                                    |> GraphQL.Decode.field
                                                                                                        "type"
                                                                                                        (Json.Decode.nullable
                                                                                                            (Json.Decode.succeed
                                                                                                                Module_Type
                                                                                                                |> GraphQL.Decode.field
                                                                                                                    "repr"
                                                                                                                    Json.Decode.string
                                                                                                            )
                                                                                                        )
                                                                                                )
                                                                                            )
                                                                                        )
                                                                                )
                                                                            )
                                                                        )
                                                                )
                                                            )
                                                    )
                                                )
                                            |> GraphQL.Decode.field
                                                "functions"
                                                (Json.Decode.nullable
                                                    (Json.Decode.succeed
                                                        Functions
                                                        |> GraphQL.Decode.field
                                                            "nodes"
                                                            (Json.Decode.list
                                                                (Json.Decode.succeed
                                                                    LatestPackage_Modules_Module_Functions_Nodes
                                                                    |> GraphQL.Decode.field
                                                                        "name"
                                                                        Json.Decode.string
                                                                    |> GraphQL.Decode.field
                                                                        "visibility"
                                                                        (Json.Decode.nullable
                                                                            Sui.Enum.MoveVisibility.decoder
                                                                        )
                                                                    |> GraphQL.Decode.field
                                                                        "isEntry"
                                                                        (Json.Decode.nullable
                                                                            Json.Decode.bool
                                                                        )
                                                                    |> GraphQL.Decode.field
                                                                        "typeParameters"
                                                                        (Json.Decode.nullable
                                                                            (Json.Decode.list
                                                                                (Json.Decode.succeed
                                                                                    LatestPackage_Modules_Module_Functions_Nodes_TypeParameters
                                                                                    |> GraphQL.Decode.field
                                                                                        "constraints"
                                                                                        (Json.Decode.list
                                                                                            Sui.Enum.MoveAbility.decoder
                                                                                        )
                                                                                )
                                                                            )
                                                                        )
                                                                    |> GraphQL.Decode.field
                                                                        "parameters"
                                                                        (Json.Decode.nullable
                                                                            (Json.Decode.list
                                                                                (Json.Decode.succeed
                                                                                    Parameters
                                                                                    |> GraphQL.Decode.field
                                                                                        "repr"
                                                                                        Json.Decode.string
                                                                                )
                                                                            )
                                                                        )
                                                                    |> GraphQL.Decode.field
                                                                        "return"
                                                                        (Json.Decode.nullable
                                                                            (Json.Decode.list
                                                                                (Json.Decode.succeed
                                                                                    Return
                                                                                    |> GraphQL.Decode.field
                                                                                        "repr"
                                                                                        Json.Decode.string
                                                                                )
                                                                            )
                                                                        )
                                                                )
                                                            )
                                                    )
                                                )
                                        )
                                    )
                            )
                        )
                )
            )


toPayload_ : Int -> String
toPayload_ version_ =
    ((GraphQL.Engine.versionedAlias version_ "latestPackage" ++ " (address: ")
        ++ GraphQL.Engine.versionedName version_ "$address"
    )
        ++ """) {modules {module: nodes {name
friends {nodes {name } }
structs {nodes {name
abilities
typeParameters {isPhantom
constraints }
fields {name
type {repr } } } }
enums {nodes {name
abilities
typeParameters {isPhantom
constraints }
variants {name
fields {name
type {repr } } } } }
functions {nodes {name
visibility
isEntry
typeParameters {constraints }
parameters {repr }
return {repr } } } } } }"""


toFragments_ : Int -> String
toFragments_ version_ =
    String.join """
""" []
