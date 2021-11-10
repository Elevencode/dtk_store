part of 'order_cubit.dart';

abstract class OrderState {}

class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderLoadSuccessState extends OrderState {
  OrderLoadSuccessState({required this.order});
  final Order order;
}

class OrderConfirmedSuccessState extends OrderState {
  OrderConfirmedSuccessState({required this.order});
  final Order order;
}

class OrderLoadFailedState extends OrderState {
  OrderLoadFailedState(this.error);
  final String error;
}
