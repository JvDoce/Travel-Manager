import 'package:flutter/material.dart';
import 'package:travelmanager/reservation/AddReservation.dart';
// import 'package:floor/floor.dart';
import '../app_database.dart';
import '../customer/customer.dart';
import '../customer/customer_dao.dart';

class CustomerListPage extends StatefulWidget {
  @override
  _CustomerListPageState createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  late AppDatabase _database;
  late CustomerDao _customerDao;
  List<Customer> _customers = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    setState(() {
      _database = database;
      _customerDao = _database.customerDao;
      _fetchCustomers();
    });
  }

  Future<void> _fetchCustomers() async {
    final customers = await _customerDao.getAllCustomers();
    setState(() {
      _customers = customers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer List'),
      ),
      body: _buildCustomerList(),
    );
  }

  Widget _buildCustomerList() {
    return ListView.builder(
      itemCount: _customers.length,
      itemBuilder: (context, index) {
        final customer = _customers[index];
        return GestureDetector(
          onTap: (){
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
              title: Text('Notice'),
              content: Text('Confirm Selected Customer'),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddReservation(customer: customer)),
                      );
                    },
                    child: Text('Confirm')
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              ],
            ),
            );
          },
          child: ListTile(
            title: Text('${customer.firstName} ${customer.lastName}'),
          ),
        );
      },
    );
  }
}
