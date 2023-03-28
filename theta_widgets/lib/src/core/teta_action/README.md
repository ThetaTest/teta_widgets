# How to create a new TetaAction

In this document, you will learn how to create a new action for Teta.

## 1. Declare the action inside `types.dart`

Go to `core/teta_action/action_types/types.dart` and add a new action to the `TetaActionType` enum.

For example:

```
// ... other actions
airtableUpdate('Update'), // <- new action
```

## 2. Add your action to an action group

At the end of the `types.dart` file, the are actions grouped by type. Add your action to the corresponding group, or create a new group if it doesn't exist.

For example, this is the group for `audioPlayer` actions:

```
static List<String> get audioPlayerActions => _actionNamesOf([
      audioPlayerLoopOne,
      audioPlayerLoopAll,
      audioPlayerLoopOff,
      audioPlayerPause,
      audioPlayerPlay,
      audioPlayerNextTrack,
      audioPlayerPreviousTrack,
      audioPlayerReload,
    ]);
```

## 3. Register the new ActionGroup, IF YOU CREATED A NEW ONE

Go to `core/teta_action/action_types/groups.dart` and add a new instance of `_TetaActionGroup` to the `all` getter inside the `TetaActionGroups` abstract class.

For example, this is the group for `audioPlayer` actions:

```
static List<_TetaActionGroup> get _all => [
        // ... other groups
        _TetaActionGroup('AudioPlayer', TetaActionType.audioPlayerActions),
        // ... other groups
      ];
```

## 4. Create the action files (`action.dart` and `params.dart`)

1. Create a new folder inside `elements/actions` with the name of the action group (eg. `airtable`, `camera`...).
2. Inside this folder, create one folder for each new action (eg. `create`, `update`, `delete`...).
3. Inside each action folder, create two files: `action.dart` and `params.dart`.

## 5. Define the action parameters

Follow the naming convention: `TA{ActionGroup}{ActionName}Params`.

### 1. Create a class inside `params.dart` that extends `TetaActionParams` and define the parameters of the action.

For example:

```

class TACameraSwitchCameraParams extends TetaActionParams {
  const TACameraSwitchCameraParams({
    required this.nameOfPage,
    required this.paramsToSend,
  });

  // ...

  final String? nameOfPage;
  final Map<String, dynamic>? paramsToSend;

  // ...
}

```

### 2. Override the `toJson()` method to serialize the parameters.

For example:

```
@override
Map<String, dynamic> toJson() => <String, dynamic>{
      'pN': nameOfPage,
      'pTS': paramsToSend,
    };
```

### 3. Define the `fromJson()` named constructor to deserialize the parameters.

For example:

```
TACameraSwitchCameraParams.fromJson(final Map<String, dynamic> json)
    : nameOfPage = json['pN'] as String,
      paramsToSend = json['pTS'] as Map<String, dynamic>?;
```

### 4. Define the `.empty()` constructor.

This is used to create an empty instance of the parameters, to avoid having to pass `null` to the constructor.

For example:

```
TACameraSwitchCameraParams.empty()
    : nameOfPage = null,
      paramsToSend = null;
```

### 5. Define the `copyWith()` method.

For example:

```
TACameraSwitchCameraParams copyWith({
  final String? nameOfPage,
  final Map<String, dynamic>? paramsToSend,
}) =>
    TACameraSwitchCameraParams(
      nameOfPage: nameOfPage ?? this.nameOfPage,
      paramsToSend: paramsToSend ?? this.paramsToSend,
    );
```

## 6. Create the action

Follow the naming convention: `TA{ActionGroup}{ActionName}`.

### 1. Create a class inside `action.dart` that extends `TetaAction`.

Note that when declaring a new action, the constructor and the `fromJson()` are always the same, except for the `params` field inside the `fromJson()` constructor,
which varies depending on the action parameters.

For example:

```
class TAAirtableDelete extends TetaAction {
  TAAirtableDelete({
    required super.params,
    required super.loop,
    required super.condition,
    required super.delay,
    super.id,
  });

  TAAirtableDelete.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAAirtableDeleteParams.fromJson(
            json['params'] as Map<String, dynamic>,
          ),
          loop: json['loop'] != null
              ? TetaActionLoop.fromJson(json['loop'] as Map<String, dynamic>)
              : null,
          condition: json['condition'] != null
              ? TetaActionCondition.fromJson(
                  json['condition'] as Map<String, dynamic>,
                )
              : null,
          delay: json['delay'] as int? ?? 0,
        );

  // ...
}
```

### 2. Override the `params` getter.

This is necessary to cast the `params` field to the correct type, to avoid having to cast it every time we need to access the parameters.
For example inside the `execute()` method.

For example:

```
@override
TAAirtableDeleteParams get params => super.params as TAAirtableDeleteParams;
```

### 3. Override the `type` getter.

This is necessary to identify the action type.

For example:

```
@override
TetaActionType get type => TetaActionType.airtableDelete;
```

### 4. Override the `execute()` and the `getActionCode()` methods.

The `execute()` method is where the action logic is defined.

The `getActionCode()` method is used to export the action to a code string.

Important: the `getActionCode()` is NEVER called directly, but it is called by the `toCode()` method of the `TetaAction` class, which is already implemented inside the `TetaAction` class, so you don't need to do nothing more.
