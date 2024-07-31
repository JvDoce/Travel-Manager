import 'package:flutter/material.dart';
import 'customer.dart';
import 'customer_dao.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'customer_add_page.dart';
import 'customer_detail_page.dart'; // Assuming you have a CustomerDetailPage

class CustomerListPage extends StatefulWidget {
  final CustomerDao customerDao;
  final SharedPreferences sharedPreferences;

  const CustomerListPage({
    required this.customerDao,
    required this.sharedPreferences,
    Key? key,
  }) : super(key: key);

  @override
  _CustomerListPageState createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CustomerDetailPage(
                          customer: customer,
                          onUpdate: (updatedCustomer) {
                            _updateCustomer(updatedCustomer);
                          },
                          onDelete: (customerToDelete) {
                            _deleteCustomer(customerToDelete);
                          },
                          sharedPreferences: widget.sharedPreferences,
                        ),
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

  Future<void> _addCustomer(Customer customer) async {
    await widget.customerDao.insertCustomer(customer);
    setState(() {
      customersFuture = widget.customerDao.getAllCustomers();
    });
  }

  Future<void> _updateCustomer(Customer customer) async {
    await widget.customerDao.updateCustomer(customer);
    setState(() {
      customersFuture = widget.customerDao.getAllCustomers();
    });
  }

  Future<void> _deleteCustomer(Customer customer) async {
    await widget.customerDao.deleteCustomer(customer);
    setState(() {
      customersFuture = widget.customerDao.getAllCustomers();
    });
  }
}