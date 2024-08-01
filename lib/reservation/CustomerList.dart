import 'package:flutter/material.dart';
import 'package:travelmanager/customer/customer.dart';
import 'package:travelmanager/customer/customer_dao.dart';
import 'package:travelmanager/app_database.dart';

class CustomerList extends StatefulWidget {
  @override
  _CustomerList createState() => _CustomerList();
}

class _CustomerList extends State<CustomerList>{

  List<Customer> customer = [];
  late CustomerDao customerDao;

  @override
  void initState() {
    super.initState();

    $FloorAppDatabase.databaseBuilder("customerDB").build().then((database){
      customerDao = database.customerDao;
      customerDao.getAllCustomers().then((ListOfCustomer){
        setState(() {
          customer.clear();
          customer.addAll(ListOfCustomer);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Customer List'),
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (customer.isEmpty)
        const Text('There are no booked flight')
    else
            Expanded(
              child: ListView.builder(
                  itemCount: customer.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {

                      },
                      child: SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Reservation: $index'),
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ),
        ],
      ),
    );
  }
  
}