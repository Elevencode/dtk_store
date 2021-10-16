part of 'order_bloc.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState.loadSuccess(Order order) = _LoadSuccess;
  const factory OrderState.loadInProgress() = _LoadInProgress;
  const factory OrderState.editIntial(Address? newAddress) = _EditInitial;
  const factory OrderState.loadFailure(String errorText) = _LoadFailure;

}
