part of 'address_bloc.dart';

@freezed
class AddressEvent with _$AddressEvent {
  const factory AddressEvent.onConfirmButtonClicked(LatLng coords) = _OnConfirmButtonClicked;
}