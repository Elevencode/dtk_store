import 'package:dtk_store/model/order.dart';
import 'package:dtk_store/presenter/order/cubit/order_cubit.dart';
import 'package:dtk_store/presenter/order/modal_sheet/address_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/modal_sheet_cubit.dart';

class EditAddressModalBottomSheet extends StatefulWidget {
  const EditAddressModalBottomSheet(
      {Key? key, required this.order, required this.orderCubit})
      : super(key: key);
  final Order order;
  final OrderCubit orderCubit;

  @override
  State<EditAddressModalBottomSheet> createState() =>
      _EditAddressModalBottomSheetState();
}

class _EditAddressModalBottomSheetState
    extends State<EditAddressModalBottomSheet> {
  late final fullnameTextController =
      TextEditingController(text: widget.order.client.fullname);
  late final districtTextController =
      TextEditingController(text: widget.order.client.address!.district);
  late final cityTextController =
      TextEditingController(text: widget.order.client.address!.city);
  late final streetTextController =
      TextEditingController(text: widget.order.client.address!.street);
  late final countryTextController =
      TextEditingController(text: widget.order.client.address!.country);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ModalSheetCubit, ModalSheetState>(
      listener: (context, state) {
        if (state is ModalSheetSendDataSuccessState) {
          Navigator.pop(context);
          widget.orderCubit
              .getOrder(); //зачем вызывать getOrder, если мы передаем order?
        } else if (state is ModalSheetSendDataInProgressState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Processing Data')),
          );
        } else if (state is ModalSheetSendDataFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              AddressTextFormField(
                hint: widget.order.client.fullname,
                controller: fullnameTextController,
                label: 'Nombre',
              ),
              const SizedBox(height: 10.0),
              AddressTextFormField(
                  hint: widget.order.client.address!.district,
                  controller: districtTextController,
                  label: 'Distrito'),
              const SizedBox(height: 10.0),
              AddressTextFormField(
                hint: widget.order.client.address!.city,
                controller: cityTextController,
                label: 'Province',
              ),
              const SizedBox(height: 10.0),
              AddressTextFormField(
                hint: widget.order.client.address!.street,
                controller: streetTextController,
                label: 'Direccion',
              ),
              const SizedBox(height: 10.0),
              AddressTextFormField(
                hint: widget.order.client.address!.country,
                controller: countryTextController,
                label: 'Referencia',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<ModalSheetCubit>(context).sendData(
                        shortCode: widget.order.shortCode,
                        phone: widget.order.client.phone,
                        id: widget.order.client.address!.id,
                        district: widget.order.client.address!.district,
                        city: cityTextController.text,
                        country: countryTextController.text,
                        street: streetTextController.text,
                        client: widget.order.client,
                        fullname: fullnameTextController.text,
                      );
                    }
                  },
                  child: const Text(
                    'CONFIRMAR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 80),
                    primary: const Color(0XFF557EF1),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'CANCELAR',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width, 80),
                  primary: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
