module Sui.Input exposing
    ( CheckpointId
    , CheckpointId_
    , DynamicFieldName
    , DynamicFieldName_
    , EventFilter
    , EventFilter_
    , MovePackageCheckpointFilter
    , MovePackageCheckpointFilter_
    , MovePackageVersionFilter
    , MovePackageVersionFilter_
    , ObjectFilter
    , ObjectFilter_
    , ObjectKey
    , ObjectKey_
    , ObjectRef
    , ObjectRef_
    , TransactionBlockFilter
    , TransactionBlockFilter_
    , TransactionMetadata
    , TransactionMetadata_
    )

{-|
@docs CheckpointId, CheckpointId_, DynamicFieldName, DynamicFieldName_, EventFilter, EventFilter_, MovePackageCheckpointFilter, MovePackageCheckpointFilter_, MovePackageVersionFilter, MovePackageVersionFilter_, ObjectFilter, ObjectFilter_, ObjectKey, ObjectKey_, ObjectRef, ObjectRef_, TransactionBlockFilter, TransactionBlockFilter_, TransactionMetadata, TransactionMetadata_
-}


import GraphQL.InputObject


type alias CheckpointId =
    GraphQL.InputObject.InputObject CheckpointId_


type CheckpointId_
    = CheckpointId_


type alias DynamicFieldName =
    GraphQL.InputObject.InputObject DynamicFieldName_


type DynamicFieldName_
    = DynamicFieldName_


type alias EventFilter =
    GraphQL.InputObject.InputObject EventFilter_


type EventFilter_
    = EventFilter_


type alias MovePackageCheckpointFilter =
    GraphQL.InputObject.InputObject MovePackageCheckpointFilter_


type MovePackageCheckpointFilter_
    = MovePackageCheckpointFilter_


type alias MovePackageVersionFilter =
    GraphQL.InputObject.InputObject MovePackageVersionFilter_


type MovePackageVersionFilter_
    = MovePackageVersionFilter_


type alias ObjectFilter =
    GraphQL.InputObject.InputObject ObjectFilter_


type ObjectFilter_
    = ObjectFilter_


type alias ObjectKey =
    GraphQL.InputObject.InputObject ObjectKey_


type ObjectKey_
    = ObjectKey_


type alias ObjectRef =
    GraphQL.InputObject.InputObject ObjectRef_


type ObjectRef_
    = ObjectRef_


type alias TransactionBlockFilter =
    GraphQL.InputObject.InputObject TransactionBlockFilter_


type TransactionBlockFilter_
    = TransactionBlockFilter_


type alias TransactionMetadata =
    GraphQL.InputObject.InputObject TransactionMetadata_


type TransactionMetadata_
    = TransactionMetadata_