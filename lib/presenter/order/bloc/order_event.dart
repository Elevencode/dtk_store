part of 'order_bloc.dart';

@freezed
class OrderEvent with _$OrderEvent {
  const factory OrderEvent.started(String shortCode, String phone) = _Started;
  const factory OrderEvent.editAddressStarted({Address? address}) = _EditAddressStarted;
  const factory OrderEvent.savingAddressStarted({
    required String shortCode,
    required String phone,
    required Address newAddress,
  }) = _SavingAddressStarted;
  const factory OrderEvent.confirmStarted(Address address) = _ConfirmStarted;
}
