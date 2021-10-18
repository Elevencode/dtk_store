import 'package:dtk_store/model/address.dart';
import 'package:dtk_store/model/client.dart';
import 'package:dtk_store/model/order.dart';
import 'package:graphql/client.dart';
import 'package:dtk_store/core/utils/gql/add_nested_typename_visitor.dart'
    as ctv;

import '../../injection.dart';

abstract class OrderDataSource {
  Future<Order> getOrder(String shortCode);
  Future<Client> updateClient(int id);
  // Future<Coordinates> createOrUpdateCoordinates(Address address);
  Future<Address> updateAddress(Address address);
}

class OrderDataSourceImpl implements OrderDataSource {
  OrderDataSourceImpl();

  // GraphQLClient get client => sl<GraphQLClient>();

  // @override
  // Future<Coordinates> createOrUpdateCoordinates(Address address) {
  //     // TODO: implement createOrUpdateCoordinates
  //     throw UnimplementedError();
  //   }

  @override
  Future<Order> getOrder(String shortcode) async {
    const query = r'''
          query GetOrder($shortCode: String!) {
      order(where: {shortCode: {_eq: $shortCode}}) {
        driverID
        client {
          address {
            city
            comments
            district
            country
            street
            state
            id
          }
          districtId
          fullname
          phone
        }
        positions {
          quantity
          totalPrice
          price
          product {
            name
            id
          }
        }
        shortCode
        totalCents
      }
    }
    ''';

    final result = await client
        .query(
          QueryOptions(
            document: ctv.gql(query),
            variables: {
              'shortCode': 'AUF-001-144',
            },
          ),
        )
        .catchError((e) => throw e);

    if (result.hasException) {
      throw result.exception!;
    }

    return Order.fromJson(result.data!['order_by_pk']);
  }

  @override
  Future<Address> updateAddress(Address address) async {
    const mutation = r'''
          mutation UpdateAddress($object: address_set_input!, $id: Int!) {
      update_address_by_pk(pk_columns: {id: $id}, _set: $object) {
        street
        state
        lng
        id
        lat
        country
        comments
        city
      }
    }
    ''';

    final result = await client
        .mutate(
          MutationOptions(
            document: ctv.gql(mutation),
            variables: {
              'id': address.id,
            },
          ),
        )
        .catchError((e) => throw e);

    if (result.hasException) {
      throw result.exception!;
    }
    return Address.fromJson(result.data!['address_by_pk']);
  }

  //TODO: Зачем мы вообще апдейтим клиента? Нужно ли апдейтить его в бд или только в проекте уже?
  @override
  Future<Client> updateClient(int id) async {
    const mutation = r'''
        mutation UpdateClient($id: Int!, $_set: client_set_input!) {
        update_client_by_pk(pk_columns: {id: $id}, _set: $_set) {
          addressPlainText
          districtId
          fullname
          id
          phone
          district {
            name
            postalCode
            city
          }
        }
      }
    ''';

    final result = await client
        .mutate(
          MutationOptions(
            document: ctv.gql(mutation),
            variables: {
              'id': id,
            },
          ),
        )
        .catchError((e) => throw e);

    if (result.hasException) {
      throw result.exception!;
    }
    return Client.fromJson(result.data!['client_by_pk']);
  }
}
