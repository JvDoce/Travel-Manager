import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelmanager/reservation/AddReservation.dart';

import '../customer/customer.dart';
import '../customer/customer_add_page.dart';
import '../customer/customer_dao.dart';


class CustomerList extends StatefulWidget {
  final CustomerDao customerDao;
  final SharedPreferences sharedPreferences;

  const CustomerList({
    required this.customerDao,
    required this.sharedPreferences,
    Key? key,
  }) : super(key: key);

  @override
  _CustomerListPageState createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerList> {
  late Future<List<Customer>> customersFuture;

  @override
  void initState() {
    super.initState();
    customersFuture = widget.customerDao.getAllCustomers();
  }

  void navigateToAddCustomerPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddCustomerPage(
          onAdd: (customer) {
            _addCustomer(customer);
          },
          sharedPreferences: widget.sharedPreferences,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddCustomerPage,
        tooltip: 'Add Customer',
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Customer>>(
        future: customersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No customers found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Customer customer = snapshot.data![index];
                return ListTile(
                  title: Text('${customer.firstName} ${customer.lastName}'),
                  onTap: () {
                    customer.id;
                    Text('${customer.firstName} ${customer.lastName}');
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddReservation(),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  void _addCustomer(Customer customer) async {
    await widget.customerDao.insertCustomer(customer);
    setState(() {
      customersFuture = widget.customerDao.getAllCustomers();
    });
  }

  void onUpdateCustomer(Customer customer) async {
    await widget.customerDao.updateCustomer(customer);
    setState(() {
      customersFuture = widget.customerDao.getAllCustomers();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Customer updated successfully')),
    );
  }

  void onDeleteCustomer(Customer customer) async {
    await widget.customerDao.deleteCustomer(customer);
    setState(() {
      customersFuture = widget.customerDao.getAllCustomers();
    });
    Navigator.of(context).pop(); // Pop the detail page after deletion
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Customer deleted successfully')),
    );
  }
}