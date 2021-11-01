import 'package:dtk_store/data/datasource/order_datasource.dart';
import 'package:dtk_store/injection.dart';
import 'package:dtk_store/model/address.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'adress_state.dart';

class AdressCubit extends Cubit<AdressState> {
  AdressCubit() : super(AdressInitial());

  OrderDataSource source = sl();

  void updateAdress(Address address) {
    emit(AdressLoading());
    try {
      source.updateAddress(
          shortCode: '137', phone: '+555555975', address: address);
      emit(AdressLoadSuccess());
    } catch (e) {
      emit(AdressLoadFailure());
    }
  }
}
