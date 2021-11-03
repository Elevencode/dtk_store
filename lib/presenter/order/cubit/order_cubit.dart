import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../injection.dart';
import '/../data/repository/order_repository.dart';
import 'package:dtk_store/model/order.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitialState());
  final OrderRepository repository = sl();

  late String localShortCode;
  late String localPhone;

  void getOrder(String shortCode, String phone) async {
    localShortCode = shortCode;
    localPhone = phone;

    late Order order;
    emit(OrderLoadingState());
    try {
      final result = await repository.getOrder(shortCode, phone);
      order = result;
      emit(OrderLoadSuccessState(order: order));
    } catch (e) {
      emit(OrderLoadFailedState(e.toString()));
    }
  }
}
