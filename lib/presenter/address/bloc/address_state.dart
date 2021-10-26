part of 'address_bloc.dart';

@freezed
class AddressState with _$AddressState {
  const factory AddressState.loadInProgress() = _LoadInProgress;
  const factory AddressState.loadSuccess(LatLng? coords) = _LoadSuccess;
  const factory AddressState.loadFailure() = _LoadFailure;
}
