import 'package:dtk_store/data/datasource/order_datasource.dart';
import 'package:dtk_store/injection.dart';
import 'package:dtk_store/model/address.dart';
import 'package:dtk_store/model/driver.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'map_widget_state.dart';

class AdressCubit extends Cubit<AdressState> {
  AdressCubit() : super(AdressInitial());

  OrderDataSource source = sl();

  void getDriver(String shortCode, String phone, DateTime time) async {
    emit(AdressLoading());
    try {
      final Driver? driver = await source.getDriver(shortCode, phone, time);
      if (driver != null) {
        //TODO создать новый стейт для загрузки драйвера
        emit(AdressLoadSuccess(driver: driver));
      } else {
        //Todo если водитель Null?
      }
    } catch (e) {
      emit(AdressLoadFailure());
    }
  }

  void updateAdress(Address address, String shortCode, String phone) async {
    emit(AdressLoading());
    try {
      await source.updateAddress(shortCode: shortCode, phone: phone, address: address);
      // shortCode: '137', phone: '+555555975', address: address);
      getDriver(shortCode, phone, DateTime.now());
    } catch (e) {
      emit(AdressLoadFailure());
    }
  }

  void updateCoords(coords, addressId, String shortCode, String phone) async {
    emit(AdressLoading());
    try {
      await source.updateCoords(
          lat: coords.latitude,
          lng: coords.longitude,
          addressId: addressId,
          shortCode: shortCode,
          phone: phone);
      getDriver(shortCode, phone, DateTime.now());
    } catch (e) {
      emit(AdressLoadFailure());
    }
  }
}
