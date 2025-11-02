part of 'create_or_update_print_cubit.dart';

final class CreateOrUpdatePrintState extends Equatable {
  const CreateOrUpdatePrintState() : this._();

  const CreateOrUpdatePrintState._({
    this.status = FormzSubmissionStatus.initial,
    this.id = 0,
    this.name = const RequiredField.pure(),
    this.customerId = '',
    this.details = '',
    this.colorsHex = const [],
    this.lastUsageAt = '',
    this.framesIds = const [],
    this.printNameInUse = false,
    this.errorCode = 0,
  });

  final FormzSubmissionStatus status;
  final int id;
  final RequiredField name;
  final String customerId;
  final String details;
  final List<String> colorsHex;
  final String lastUsageAt;
  final bool printNameInUse;
  final List<int> framesIds;
  final int errorCode;

  const CreateOrUpdatePrintState.initial() : this._();

  CreateOrUpdatePrintState withName(String name) {
    return CreateOrUpdatePrintState._(
      name: RequiredField.dirty(name),
      customerId: customerId,
      details: details,
      id: id,
      colorsHex: colorsHex,
      lastUsageAt: lastUsageAt,
      framesIds: framesIds,
    );
  }

  CreateOrUpdatePrintState withCustomerId(String customerId) {
    return CreateOrUpdatePrintState._(
      customerId: customerId,
      name: name,
      id: id,
      details: details,
      colorsHex: colorsHex,
      lastUsageAt: lastUsageAt,
      framesIds: framesIds,
    );
  }

  CreateOrUpdatePrintState withDetails(String details) {
    return CreateOrUpdatePrintState._(
      details: details,
      name: name,
      id: id,
      customerId: customerId,
      colorsHex: colorsHex,
      lastUsageAt: lastUsageAt,
      framesIds: framesIds,
    );
  }

  CreateOrUpdatePrintState withColorHex(String colorHex) {
    final updatedColors = List<String>.from(colorsHex)..add(colorHex);
    return CreateOrUpdatePrintState._(
      colorsHex: updatedColors,
      name: name,
      id: id,
      customerId: customerId,
      details: details,
      lastUsageAt: lastUsageAt,
      framesIds: framesIds,
    );
  }

  CreateOrUpdatePrintState withoutColorHex(String colorHex) {
    final updatedColors = List<String>.from(colorsHex)..remove(colorHex);
    return CreateOrUpdatePrintState._(
      colorsHex: updatedColors,
      name: name,
      id: id,
      customerId: customerId,
      details: details,
      lastUsageAt: lastUsageAt,
      framesIds: framesIds,
    );
  }

  CreateOrUpdatePrintState withFrameId(int frameId) {
    final updatedFrames = List<int>.from(framesIds)..add(frameId);
    return CreateOrUpdatePrintState._(
      framesIds: updatedFrames,
      name: name,
      id: id,
      customerId: customerId,
      details: details,
      colorsHex: colorsHex,
      lastUsageAt: lastUsageAt,
    );
  }

  CreateOrUpdatePrintState withoutFrameId(int frameId) {
    final updatedFrames = List<int>.from(framesIds)..remove(frameId);
    return CreateOrUpdatePrintState._(
      framesIds: updatedFrames,
      name: name,
      id: id,
      customerId: customerId,
      details: details,
      colorsHex: colorsHex,
      lastUsageAt: lastUsageAt,
    );
  }

  CreateOrUpdatePrintState withSubmissionInProgress() {
    return CreateOrUpdatePrintState._(
      status: FormzSubmissionStatus.inProgress,
      name: name,
      id: id,
      customerId: customerId,
      details: details,
      colorsHex: colorsHex,
      lastUsageAt: lastUsageAt,
      framesIds: framesIds,
    );
  }

  CreateOrUpdatePrintState withLastUsageDate(DateTime dateTime) {
    return CreateOrUpdatePrintState._(
      lastUsageAt: dateTime.toIso8601String(),
      name: name,
      id: id,
      customerId: customerId,
      details: details,
      colorsHex: colorsHex,
      framesIds: framesIds,
    );
  }

  CreateOrUpdatePrintState fromModel(PrintModel printModel) {
    return CreateOrUpdatePrintState._(
      id: printModel.id,
      name: RequiredField.dirty(printModel.name),
      customerId: printModel.customerId,
      details: printModel.details,
      colorsHex: printModel.colorsHex,
      lastUsageAt: lastUsageAt,
      framesIds: framesIds,
    );
  }

  CreateOrUpdatePrintState withSubmissionSuccess() {
    return CreateOrUpdatePrintState._(status: FormzSubmissionStatus.success);
  }

  CreateOrUpdatePrintState withSubmissionFailure({int? errorCode}) {
    return CreateOrUpdatePrintState._(
      name: name,
      id: id,
      customerId: customerId,
      details: details,
      status: FormzSubmissionStatus.failure,
      colorsHex: colorsHex,
      lastUsageAt: lastUsageAt,
      framesIds: framesIds,
      printNameInUse: errorCode != null && errorCode == 400003,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  bool get isValid => Formz.validate([name]);

  @override
  List<Object> get props => [
    status,
    id,
    name,
    errorCode,
    customerId,
    details,
    colorsHex,
    printNameInUse,
    framesIds,
    lastUsageAt,
  ];
}
