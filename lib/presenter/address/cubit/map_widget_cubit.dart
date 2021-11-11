import 'package:dtk_store/data/datasource/order_datasource.dart';
import 'package:dtk_store/injection.dart';
import 'package:dtk_store/model/address.dart';
import 'package:dtk_store/model/driver.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'map_widget_state.dart';

class AdressCubit extends Cubit<AdressState> {
  AdressCubit() : super(AdressInitial());

  OrderDataSource source = sl();

  void updateAdress(Address address, String shortCode, String phone) {
    emit(AdressLoading());
    try {
      source.updateAddress(
          shortCode: shortCode, phone: phone, address: address);
      // shortCode: '137', phone: '+555555975', address: address);
      emit(AdressLoadSuccess());
    } catch (e) {
      emit(AdressLoadFailure());
    }
  }

  void updateCoords(coords, addressId, String shortCode, String phone) {
    emit(AdressLoading());
    try {
      source.updateCoords(
          lat: coords.latitude,
          lng: coords.longitude,
          addressId: addressId,
          shortCode: shortCode,
          phone: phone);
      emit(AdressLoadSuccess());
    } catch (e) {
      emit(AdressLoadFailure());
    }
  }

  void getDriver(String shortCode, String phone, DateTime time) async {
    late Driver driver;
    emit(AdressLoading());
    try {
      final result = await source.getDriver(shortCode, phone, time);
      driver = result!;
      emit(AdressLoadSuccess(driver: driver));
    } catch (e) {
      emit(AdressLoadFailure());
    }
  }
}
