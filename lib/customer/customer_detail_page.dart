import 'package:flutter/material.dart';
import 'customer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'customer_update_page.dart'; // Import the UpdateCustomerPage

class CustomerDetailPage extends StatelessWidget {
  final Customer customer;
  final Function(Customer) onUpdate;
  final Function(Customer) onDelete;
  final SharedPreferences sharedPreferences;

  const CustomerDetailPage({
    required this.customer,
    required this.onUpdate,
    required this.onDelete,
    required this.sharedPreferences,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Details'),
        actions: [
          Tooltip(
            message: 'Update',
            child: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UpdateCustomerPage(
                      customer: customer,
                      onUpdate: onUpdate,
                      sharedPreferences: sharedPreferences,
                    ),
                  ),
                );
              },
            ),
          ),
          Tooltip(
            message: 'Delete',
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                onDelete(customer);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailItem('First Name', customer.firstName),
            _buildDetailItem('Last Name', customer.lastName),
            _buildDetailItem('Address', customer.address),
            _buildDetailItem('Birthday', customer.birthday),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          Divider(color: Colors.grey[400]),
        ],
      ),
    );
  }
}