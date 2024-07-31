import 'package:flutter/material.dart';
import 'customer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCustomerPage extends StatefulWidget {
  final Function(Customer) onAdd;
  final SharedPreferences sharedPreferences;

  const AddCustomerPage({
    required this.onAdd,
    required this.sharedPreferences,
    Key? key,
  }) : super(key: key);

  @override
  _AddCustomerPageState createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _addressController;
  late TextEditingController _birthdayController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _addressController = TextEditingController();
    _birthdayController = TextEditingController();
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
        title: Text('Add Customer'),
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
                  onPressed: () {
                    Customer newCustomer = Customer(
                      null, // Passing null for id since it will be auto-generated
                      _firstNameController.text,
                      _lastNameController.text,
                      _addressController.text,
                      _birthdayController.text,
                    );
                    widget.onAdd(newCustomer);
                    Navigator.of(context).pop();
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}