part of 'create_or_update_frame_cubit.dart';

final class CreateOrUpdateFrameState extends Equatable {
  const CreateOrUpdateFrameState() : this._();

  const CreateOrUpdateFrameState._({
    this.status = FormzSubmissionStatus.initial,
    this.id = 0,
    this.identifier = const RequiredField.pure(),
    this.material = FrameMaterial.wood,
    this.lines = '',
    this.size = '',
    this.printsIds = const [],
    this.lastUsageAt = '',
    this.frameIdentifierInUse = false,
    this.errorCode = 0,
  });

  final FormzSubmissionStatus status;
  final int id;
  final RequiredField identifier;
  final FrameMaterial material;
  final String lines;
  final String size;
  final List<int> printsIds;
  final String lastUsageAt;
  final bool frameIdentifierInUse;
  final int errorCode;

  const CreateOrUpdateFrameState.initial() : this._();

  CreateOrUpdateFrameState withIdentifier(String identifier) {
    return CreateOrUpdateFrameState._(
      identifier: RequiredField.dirty(identifier),
      material: material,
      lines: lines,
      id: id,
      size: size,
      printsIds: printsIds,
      lastUsageAt: lastUsageAt,
    );
  }

  CreateOrUpdateFrameState withMaterial(FrameMaterial material) {
    return CreateOrUpdateFrameState._(
      material: material,
      identifier: identifier,
      id: id,
      lines: lines,
      printsIds: printsIds,
      size: size,
      lastUsageAt: lastUsageAt,
    );
  }

  CreateOrUpdateFrameState withLines(String lines) {
    return CreateOrUpdateFrameState._(
      lines: lines,
      identifier: identifier,
      id: id,
      material: material,
      size: size,
      printsIds: printsIds,
      lastUsageAt: lastUsageAt,
    );
  }

  CreateOrUpdateFrameState withSize(String size) {
    return CreateOrUpdateFrameState._(
      size: size,
      identifier: identifier,
      id: id,
      material: material,
      lines: lines,
      printsIds: printsIds,
      lastUsageAt: lastUsageAt,
    );
  }

  CreateOrUpdateFrameState withPrintsIds(List<int> printsIds) {
    return CreateOrUpdateFrameState._(
      printsIds: printsIds,
      identifier: identifier,
      id: id,
      material: material,
      lines: lines,
      size: size,
      lastUsageAt: lastUsageAt,
    );
  }

  CreateOrUpdateFrameState withSubmissionInProgress() {
    return CreateOrUpdateFrameState._(
      status: FormzSubmissionStatus.inProgress,
      identifier: identifier,
      id: id,
      material: material,
      lines: lines,
      size: size,
      printsIds: printsIds,
      lastUsageAt: lastUsageAt,
    );
  }

  CreateOrUpdateFrameState withLastUsageDate(DateTime dateTime) {
    return CreateOrUpdateFrameState._(
      lastUsageAt: dateTime.toIso8601String(),
      identifier: identifier,
      id: id,
      material: material,
      lines: lines,
      size: size,
      printsIds: printsIds,
    );
  }

  CreateOrUpdateFrameState fromModel(FrameModel frameModel) {
    return CreateOrUpdateFrameState._(
      id: frameModel.id,
      identifier: RequiredField.dirty(frameModel.identifier),
      material: FrameMaterial.fromString(frameModel.material),
      lines: frameModel.lines,
      size: frameModel.size,
      printsIds: frameModel.prints.map((e) => e.id).toList(),
      lastUsageAt: lastUsageAt,
    );
  }

  CreateOrUpdateFrameState withSubmissionSuccess() {
    return CreateOrUpdateFrameState._(status: FormzSubmissionStatus.success);
  }

  CreateOrUpdateFrameState withSubmissionFailure({int? errorCode}) {
    return CreateOrUpdateFrameState._(
      identifier: identifier,
      id: id,
      material: material,
      lines: lines,
      status: FormzSubmissionStatus.failure,
      size: size,
      printsIds: printsIds,
      lastUsageAt: lastUsageAt,
      frameIdentifierInUse: errorCode != null && errorCode == 400002,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  bool get isValid => Formz.validate([identifier]);

  @override
  List<Object> get props => [
    status,
    id,
    identifier,
    errorCode,
    material,
    lines,
    size,
    printsIds,
    frameIdentifierInUse,
    lastUsageAt,
  ];
}
