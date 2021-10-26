import 'package:bloc/bloc.dart';
import 'package:dtk_store/data/repository/order_repository.dart';
import 'package:dtk_store/injection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'address_event.dart';
part 'address_state.dart';
part 'address_bloc.freezed.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(_LoadInProgress());

  late OrderRepository orderRepository = sl();

  @override
  Stream<AddressState> mapEventToState(AddressEvent event) async* {
    yield* event.map(
      onConfirmButtonClicked: (e) async* {
        yield const _LoadInProgress();
        // var failureOrSuccess = await orderRepository.updateAddress(shortCode: event.shortCode, phone: phone, address: address)
        }
    );
  }
}
