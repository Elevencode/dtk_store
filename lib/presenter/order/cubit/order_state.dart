part of 'order_cubit.dart';

abstract class OrderState {}

class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderLoadSuccessState extends OrderState {
  OrderLoadSuccessState({required this.order, required this.isConfirmed});
  final Order order;
  final bool isConfirmed;
}

class AirstrikeSendSuccessState extends OrderState {}

class AirstrikeSendFailureState extends OrderState {}

class OrderLoadFailedState extends OrderState {
  OrderLoadFailedState(this.error);
  final String error;
}
