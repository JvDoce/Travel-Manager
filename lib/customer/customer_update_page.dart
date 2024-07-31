import 'package:flutter/material.dart';
import 'customer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateCustomerPage extends StatefulWidget {
  final Customer customer;
  final Function(Customer) onUpdate;
  final SharedPreferences sharedPreferences;

  const UpdateCustomerPage({
    required this.customer,
    required this.onUpdate,
    required this.sharedPreferences,
    Key? key,
  }) : super(key: key);

  @override
  _UpdateCustomerPageState createState() => _UpdateCustomerPageState();
}

class _UpdateCustomerPageState extends State<UpdateCustomerPage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _addressController;
  late TextEditingController _birthdayController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.customer.firstName);
    _lastNameController = TextEditingController(text: widget.customer.lastName);
    _addressController = TextEditingController(text: widget.customer.address);
    _birthdayController = TextEditingController(text: widget.customer.birthday);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Customer'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _birthdayController,
              decoration: InputDecoration(labelText: 'Birthday'),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    Customer updatedCustomer = Customer(
                      widget.customer.id,
                      _firstNameController.text,
                      _lastNameController.text,
                      _addressController.text,
                      _birthdayController.text,
                    );
                    await widget.onUpdate(updatedCustomer);
                    Navigator.of(context).popUntil((route) => route.isFirst); // Pop until the first route (CustomerListPage)
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}