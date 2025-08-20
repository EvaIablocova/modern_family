// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get roomId => throw _privateConstructorUsedError;
  String? get projectId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get dueAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  bool get important => throw _privateConstructorUsedError;
  TaskInterval get interval => throw _privateConstructorUsedError;
  List<String> get assigneeProfileIds => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  bool get rotated => throw _privateConstructorUsedError;

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    String? roomId,
    String? projectId,
    DateTime createdAt,
    DateTime? dueAt,
    DateTime? completedAt,
    bool important,
    TaskInterval interval,
    List<String> assigneeProfileIds,
    int points,
    bool rotated,
  });
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? roomId = freezed,
    Object? projectId = freezed,
    Object? createdAt = null,
    Object? dueAt = freezed,
    Object? completedAt = freezed,
    Object? important = null,
    Object? interval = null,
    Object? assigneeProfileIds = null,
    Object? points = null,
    Object? rotated = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            roomId: freezed == roomId
                ? _value.roomId
                : roomId // ignore: cast_nullable_to_non_nullable
                      as String?,
            projectId: freezed == projectId
                ? _value.projectId
                : projectId // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            dueAt: freezed == dueAt
                ? _value.dueAt
                : dueAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            important: null == important
                ? _value.important
                : important // ignore: cast_nullable_to_non_nullable
                      as bool,
            interval: null == interval
                ? _value.interval
                : interval // ignore: cast_nullable_to_non_nullable
                      as TaskInterval,
            assigneeProfileIds: null == assigneeProfileIds
                ? _value.assigneeProfileIds
                : assigneeProfileIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as int,
            rotated: null == rotated
                ? _value.rotated
                : rotated // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TaskImplCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$TaskImplCopyWith(
    _$TaskImpl value,
    $Res Function(_$TaskImpl) then,
  ) = __$$TaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    String? roomId,
    String? projectId,
    DateTime createdAt,
    DateTime? dueAt,
    DateTime? completedAt,
    bool important,
    TaskInterval interval,
    List<String> assigneeProfileIds,
    int points,
    bool rotated,
  });
}

/// @nodoc
class __$$TaskImplCopyWithImpl<$Res>
    extends _$TaskCopyWithImpl<$Res, _$TaskImpl>
    implements _$$TaskImplCopyWith<$Res> {
  __$$TaskImplCopyWithImpl(_$TaskImpl _value, $Res Function(_$TaskImpl) _then)
    : super(_value, _then);

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? roomId = freezed,
    Object? projectId = freezed,
    Object? createdAt = null,
    Object? dueAt = freezed,
    Object? completedAt = freezed,
    Object? important = null,
    Object? interval = null,
    Object? assigneeProfileIds = null,
    Object? points = null,
    Object? rotated = null,
  }) {
    return _then(
      _$TaskImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        roomId: freezed == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as String?,
        projectId: freezed == projectId
            ? _value.projectId
            : projectId // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        dueAt: freezed == dueAt
            ? _value.dueAt
            : dueAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        important: null == important
            ? _value.important
            : important // ignore: cast_nullable_to_non_nullable
                  as bool,
        interval: null == interval
            ? _value.interval
            : interval // ignore: cast_nullable_to_non_nullable
                  as TaskInterval,
        assigneeProfileIds: null == assigneeProfileIds
            ? _value._assigneeProfileIds
            : assigneeProfileIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        points: null == points
            ? _value.points
            : points // ignore: cast_nullable_to_non_nullable
                  as int,
        rotated: null == rotated
            ? _value.rotated
            : rotated // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskImpl implements _Task {
  const _$TaskImpl({
    required this.id,
    required this.title,
    this.description,
    this.roomId,
    this.projectId,
    required this.createdAt,
    this.dueAt,
    this.completedAt,
    this.important = false,
    this.interval = TaskInterval.none,
    final List<String> assigneeProfileIds = const [],
    this.points = 0,
    this.rotated = false,
  }) : _assigneeProfileIds = assigneeProfileIds;

  factory _$TaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String? roomId;
  @override
  final String? projectId;
  @override
  final DateTime createdAt;
  @override
  final DateTime? dueAt;
  @override
  final DateTime? completedAt;
  @override
  @JsonKey()
  final bool important;
  @override
  @JsonKey()
  final TaskInterval interval;
  final List<String> _assigneeProfileIds;
  @override
  @JsonKey()
  List<String> get assigneeProfileIds {
    if (_assigneeProfileIds is EqualUnmodifiableListView)
      return _assigneeProfileIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assigneeProfileIds);
  }

  @override
  @JsonKey()
  final int points;
  @override
  @JsonKey()
  final bool rotated;

  @override
  String toString() {
    return 'Task(id: $id, title: $title, description: $description, roomId: $roomId, projectId: $projectId, createdAt: $createdAt, dueAt: $dueAt, completedAt: $completedAt, important: $important, interval: $interval, assigneeProfileIds: $assigneeProfileIds, points: $points, rotated: $rotated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.dueAt, dueAt) || other.dueAt == dueAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.important, important) ||
                other.important == important) &&
            (identical(other.interval, interval) ||
                other.interval == interval) &&
            const DeepCollectionEquality().equals(
              other._assigneeProfileIds,
              _assigneeProfileIds,
            ) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.rotated, rotated) || other.rotated == rotated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    roomId,
    projectId,
    createdAt,
    dueAt,
    completedAt,
    important,
    interval,
    const DeepCollectionEquality().hash(_assigneeProfileIds),
    points,
    rotated,
  );

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      __$$TaskImplCopyWithImpl<_$TaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskImplToJson(this);
  }
}

abstract class _Task implements Task {
  const factory _Task({
    required final String id,
    required final String title,
    final String? description,
    final String? roomId,
    final String? projectId,
    required final DateTime createdAt,
    final DateTime? dueAt,
    final DateTime? completedAt,
    final bool important,
    final TaskInterval interval,
    final List<String> assigneeProfileIds,
    final int points,
    final bool rotated,
  }) = _$TaskImpl;

  factory _Task.fromJson(Map<String, dynamic> json) = _$TaskImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  String? get roomId;
  @override
  String? get projectId;
  @override
  DateTime get createdAt;
  @override
  DateTime? get dueAt;
  @override
  DateTime? get completedAt;
  @override
  bool get important;
  @override
  TaskInterval get interval;
  @override
  List<String> get assigneeProfileIds;
  @override
  int get points;
  @override
  bool get rotated;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
