import 'package:dtk_store/model/client.dart';
import 'package:dtk_store/model/order_position.dart';
// import 'package:dtkdriver/model/client.dart';
// import 'package:dtkdriver/model/order_photo.dart';
// import 'package:dtkdriver/model/order_position.dart';
// import 'package:dtkdriver/model/shipment.dart';
// import 'package:dtkdriver/model/status.dart';
// import 'package:dtkdriver/model/warehouse.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:intl/intl.dart':

// import 'driver.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
abstract class Order implements _$Order {
  const Order._();

  factory Order({
    required int id, //
    // required Status status, //
    DateTime? plannedDate, //
    // required DateTime createdAt,
    // @JsonKey(defaultValue: false) bool? important, //
    int? plannedDateDuration, //
    // DateTime? deliveredDate,
    // String? umbrellaID,
    String? shortCode,
    // String? statusName,
    // String? reasonRefusal,
    // String? driverID,
    int? totalCents,
    int? shipmentId,
    // @JsonKey(name: 'order_photos') List<OrderPhoto>? photos,
    List<OrderPosition>? positions,
    Client? client,
    // Warehouse? warehouse,
    // Driver? driver,
    // Shipment? shipment, //
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  // String get orderNumberString => '${shortCode ?? "#$id"} ${client?.address?.district ?? ''}';

  /// Get only when [plannedDate] is not null
  // String get plannedTimeRange => (plannedDateDuration ?? 0) == 0
  //     ? DateFormat('HH:mm', 'es').format(plannedDate.toLocal())
  //     : "${DateFormat('HH:mm', 'es').format(plannedDate.toLocal())} - ${DateFormat('HH:mm', 'es').format(plannedDate.add(Duration(minutes: plannedDateDuration!)).toLocal())}";
}
