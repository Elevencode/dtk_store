part of 'map_widget_cubit.dart';

abstract class AdressState {}

class AdressInitial implements AdressState {}

class AdressLoading implements AdressState {}

class AdressLoadSuccess implements AdressState {
  AdressLoadSuccess({this.driver});
  final Driver? driver;
}

class AdressLoadFailure implements AdressState {}
