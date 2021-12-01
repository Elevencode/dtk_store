import 'package:bloc/bloc.dart';
import 'package:dtk_store/data/repository/order_repository.dart';
import 'package:dtk_store/model/address.dart';
import 'package:dtk_store/model/client.dart';
import 'package:flutter/material.dart';

import '../../../../injection.dart';

part 'modal_sheet_state.dart';

class ModalSheetCubit extends Cubit<ModalSheetState> {
  ModalSheetCubit() : super(ModalSheetInitialState());
  final OrderRepository repository = sl();

  void sendData({required int id, required String city, required String street, required String country, required String district, required String phone, required String shortCode, required Client client, required String fullname}) async {
    emit(ModalSheetSendDataInProgressState());
    final Address address = Address(id: id, city: city, street: street, country: country, district: district);
    final Client newClient = Client(phone: client.phone, fullname: fullname, id: client.id);
    try {
      final result = await repository.updateAddress(address: address, phone: phone, shortCode: shortCode);
      final resultClient = await repository.updateClient(shortCode: shortCode, phone: phone, client: newClient);
      emit(ModalSheetSendDataSuccessState());
    } catch (e) {
      emit(ModalSheetSendDataFailedState(e.toString()));

    }
 
  }
}
