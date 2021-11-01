import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../injection.dart';
import '/../data/repository/order_repository.dart';
import 'package:dtk_store/model/order.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitialState());
  final OrderRepository repository = sl();

  void getOrder() async {
    late Order order;
    emit(OrderLoadingState());
    try {
      final result = await repository.getOrder('137', '+555555975');
      order = result;
      emit(OrderLoadSuccessState(order: order));
    } catch (e) {
      emit(OrderLoadFailedState(e.toString()));
    }
  }
}
