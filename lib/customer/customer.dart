import 'package:floor/floor.dart';

@Entity(tableName: 'Customer')
class Customer {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String firstName;
  final String lastName;
  final String address;
  final String birthday;

  Customer(this.id, this.firstName, this.lastName, this.address, this.birthday);

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      map['id'],
      map['firstName'],
      map['lastName'],
      map['address'],
      map['birthday'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'birthday': birthday,
    };
  }
}