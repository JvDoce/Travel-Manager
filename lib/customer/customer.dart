///Customer data model
import 'package:floor/floor.dart';

@entity
class Customer {
  static int ID = 1;

  @primaryKey
  final int customer_id;
  final String firstName;
  final String lastName;
  final String address;
  final String birthday;

  Customer(this.customer_id, this.firstName, this.lastName, this.address,
      this.birthday) {
    if (customer_id > ID) {
      ID = customer_id;
    }
  }
}