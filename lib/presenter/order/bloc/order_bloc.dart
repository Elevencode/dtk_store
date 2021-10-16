import 'package:bloc/bloc.dart';
import 'package:dtk_store/data/repository/order_repository.dart';
import 'package:dtk_store/model/address.dart';
import 'package:dtk_store/model/order.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const _LoadInProgress());

  final OrderRepository orderRepository = sl();

  Stream<OrderState> mapEventToState(
    OrderEvent event
  ) async* {
    yield* event.map(
      started: (event) async* {
        yield _LoadInProgress();
        try {
          final order = await orderRepository.getOrder(event.shortCode);
          yield _LoadSuccess(order);
        } catch (e) {
            yield _LoadFailure("$e");
        }
      }, 
      editAddressStarted: (event) async* {
        yield _LoadInProgress();
        try {
          //TODO как адрес новый сюда засунуть?
        //  final Address? newAddress;
          yield _EditInitial(event.address);
        } catch (e) {
          yield _LoadFailure('$e');
        }

      }, 
      savingAddressStarted: (event) async* {
        yield _LoadInProgress();
        try {
          final address = orderRepository.updateAddress(event.newAddress);
        } catch (e) {
          yield _LoadFailure('$e');
        }

      },
      confirmStarted: (event) async* {

      },
      );
  }






}
