part of 'modal_sheet_cubit.dart';

abstract class ModalSheetState {}

class ModalSheetInitialState extends ModalSheetState {}

class ModalSheetSendDataInProgressState extends ModalSheetState {}

class ModalSheetSendDataSuccessState extends ModalSheetState {}

class ModalSheetSendDataFailedState extends ModalSheetState {
  ModalSheetSendDataFailedState(this.error);
  final String error;
}
