part of 'map_widget_cubit.dart';

abstract class AddressState {}

class AddressInitial implements AddressState {}

class AddressLoading implements AddressState {}

class AddressLoadSuccess implements AddressState {
  AddressLoadSuccess({required this.driver});
  final Driver driver;
}

class AddressLoadFailure implements AddressState {}
