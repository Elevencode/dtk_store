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
    emit(OrderLoadingState());
    try {
      final result = await repository.getOrder(localShortCode, localPhone);
      var order = result;
      if (order.client.address!.lat == null && order.client.address!.lng == null) {
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
        duration: order.plannedDateDuration!,
      );
      emit(
        OrderLoadSuccessState(order: order, isConfirmed: true),
      );
    } catch (e) {
      emit(OrderLoadFailedState(e.toString()));
    }
  }

  void createNotification({
    required String shortCode,
    required String phone,
    required Order order,
    required bool isConfirmed,
  }) async {
    emit(
      OrderLoadSuccessState(
        order: order,
        isConfirmed: isConfirmed,
        isAirstrikeLoading: true,
      ),
    );
    try {
      await repository.createNotificationOperator(
        shortCode: shortCode,
        phone: phone,
      );

      emit(AirstrikeSendSuccessState());
    } catch (e) {
      emit(AirstrikeSendFailureState());
    }
    emit(
      OrderLoadSuccessState(
        order: order,
        isConfirmed: isConfirmed,
        isAirstrikeLoading: false,
      ),
    );
  }
}
