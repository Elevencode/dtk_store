import 'package:bloc/bloc.dart';
import 'package:dtk_store/data/repository/order_repository.dart';
import 'package:dtk_store/model/address.dart';

import '../../../../injection.dart';

part 'modal_sheet_state.dart';

class ModalSheetCubit extends Cubit<ModalSheetState> {
  ModalSheetCubit() : super(ModalSheetInitialState());
  final OrderRepository repository = sl();

  void sendData({required int id, required String city, required String street, required String country, required String district, required String phone, required String shortCode}) async {
    emit(ModalSheetSendDataInProgressState());
    final Address address = Address(id: id, city: city, street: street, country: country, district: district);
    try {
      final result = await repository.updateAddress(address: address, phone: phone, shortCode: shortCode);
      emit(ModalSheetSendDataSuccessState());
    } catch (e) {
      emit(ModalSheetSendDataFailedState(e.toString()));

    }
 
  }
}
