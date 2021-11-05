part of 'map_widget_cubit.dart';

abstract class AdressState {}

class AdressInitial implements AdressState {}

class AdressLoading implements AdressState {}

class AdressLoadSuccess implements AdressState {}

class AdressLoadFailure implements AdressState {}
