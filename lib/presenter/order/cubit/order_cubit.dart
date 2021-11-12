import 'package:bloc/bloc.dart';

import '../../../injection.dart';
import '../../../data/repository/order_repository.dart';
import 'package:dtk_store/model/order.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitialState());
  final OrderRepository repository = sl();

  late String localShortCode;
  late String localPhone;

  void initOrderCubit(String shortCode, String phone) {
    localShortCode = shortCode;
    localPhone = phone;
  }

  void getOrder() async {
    late Order order;
    emit(OrderLoadingState());
    try {
      final result = await repository.getOrder(localShortCode, localPhone);
      order = result;
      if (order.client.address.lat == null &&
          order.client.address.lng == null) {
        emit(OrderLoadSuccessState(order: order, isConfirmed: false));
      } else {
        emit(OrderLoadSuccessState(order: order, isConfirmed: true));
      }
    } catch (e) {
      emit(OrderLoadFailedState(e.toString()));
    }
  }

  void updateOrder(Order order) async {
    emit(OrderLoadingState());
    try {
      await repository.updateOrderTime(
          shortCode: localShortCode,
          phone: localPhone,
          plannedDate: order.plannedDate!,
          duration: order.plannedDateDuration!);
      emit(OrderLoadSuccessState(order: order, isConfirmed: true));
    } catch (e) {
      emit(OrderLoadFailedState(e.toString()));
    }
  }
}
