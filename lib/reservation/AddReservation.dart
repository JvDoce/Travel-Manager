import 'package:flutter/material.dart';
import 'package:travelmanager/main.dart';
import 'package:travelmanager/reservation/ReservationPage.dart';
import '../app_database.dart';
import '../reservation/reservation.dart';
import '../reservation/reservation_dao.dart';
import '../airplane/airplane.dart';
import '../airplane/airplane_dao.dart';
import '../customer/customer.dart';
import '../customer/customer_dao.dart';
import '../flights/flight.dart';
import '../flights/flights_dao.dart';
import 'BookList.dart';

class AddReservation extends StatefulWidget {
  @override
  _AddReservationState createState() => _AddReservationState();
}

class _AddReservationState extends State<AddReservation> {
  Customer? selectedCustomer;
  Flight? selectedFlight;
  Airplane? selectedAirplane;
  String? resDate;

  List<Customer> _customers = [];
  List<Flight> _flights = [];
  List<Airplane> _airplanes = [];
  List<Reservation> bookFlight = [];

  late CustomerDao _customerDao;
  late FlightDao _flightDao;
  late AirplaneDao _airplaneDao;
  late ReservationDao _reservationDao;

  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    var database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    _customerDao = database.customerDao;
    _flightDao = database.flightDao;
    _airplaneDao = database.airplaneDao;
    _reservationDao = database.reservationDao;

    _fetchData();
  }

  Future<void> _fetchData() async {
    final customers = await _customerDao.getAllCustomers();
    final flights = await _flightDao.findAllFlights();
    final airplanes = await _airplaneDao.getAllAirplanes();

    setState(() {
      _customers = customers;
      _flights = flights;
      _airplanes = airplanes;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    if ((width > height) && (width > 720)){
      return Scaffold(
        appBar: AppBar(
          title: Text('Add Reservation'),
        ),
        body: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: _buildDropdown<Customer>(
                              label: 'Select Customer',
                              value: selectedCustomer,
                              items: _customers,
                              onChanged: (Customer? newCustomer) {
                                setState(() {
                                  selectedCustomer = newCustomer;
                                });
                              },
                              itemText: (Customer customer) => '${customer.firstName} ${customer.lastName}',
                            )
                        ),
                        Expanded(child: _buildDropdown<Airplane>(
                          label: 'Select Airplane',
                          value: selectedAirplane,
                          items: _airplanes,
                          onChanged: (Airplane? newAirplane) {
                            setState(() {
                              selectedAirplane = newAirplane;
                            });
                          },
                          itemText: (Airplane airplane) => 'Airplane ${airplane.id}: ${airplane.type}',
                        )
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: _buildDropdown<Flight>(
                          label: 'Select Flight',
                          value: selectedFlight,
                          items: _flights,
                          onChanged: (Flight? newFlight) {
                            setState(() {
                              selectedFlight = newFlight;
                            });
                          },
                          itemText: (Flight flight) => 'Flight ${flight.flight_id}: ${flight.departureCity} to ${flight.destinationCity}',
                        )
                        ),
                        Expanded(child: DropdownButton<String>(
                          value: resDate,
                          hint: Text('Select Reservation Day'),
                          items: days.map((String day) {
                            return DropdownMenuItem<String>(
                              value: day,
                              child: Text(day),
                            );
                          }).toList(),
                          onChanged: (String? newDay) {
                            setState(() {
                              resDate = newDay;
                            });
                          },
                        )
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (selectedCustomer != null && selectedFlight != null && selectedAirplane != null && resDate != null) {
                              final reservation = Reservation(
                                Reservation.ID++,
                                selectedCustomer!.id as int,
                                selectedFlight!.flight_id,
                                resDate!,
                              );
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text('Notice'),
                                  content: Text('Confirm Flight Reservation'),
                                  actions: <Widget>[
                                    ElevatedButton(
                                        onPressed: (){
                                          _reservationDao.insertReservation(reservation);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => HomePage())
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Success: Flight Reserved')),
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
                            }
                          },
                          child: Text('Add Reservation'),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    ),
                  ],
                ),
              )
        );
    }else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Add Reservation'),
        ),
        body: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDropdown<Customer>(
                    label: 'Select Customer',
                    value: selectedCustomer,
                    items: _customers,
                    onChanged: (Customer? newCustomer) {
                      setState(() {
                        selectedCustomer = newCustomer;
                      });
                    },
                    itemText: (Customer customer) => '${customer.firstName} ${customer.lastName}',
                  ),
                  _buildDropdown<Flight>(
                    label: 'Select Flight',
                    value: selectedFlight,
                    items: _flights,
                    onChanged: (Flight? newFlight) {
                      setState(() {
                        selectedFlight = newFlight;
                      });
                    },
                    itemText: (Flight flight) => 'Flight ${flight.flight_id}: ${flight.departureCity} to ${flight.destinationCity}',
                  ),
                  _buildDropdown<Airplane>(
                    label: 'Select Airplane',
                    value: selectedAirplane,
                    items: _airplanes,
                    onChanged: (Airplane? newAirplane) {
                      setState(() {
                        selectedAirplane = newAirplane;
                      });
                    },
                    itemText: (Airplane airplane) => 'Airplane ${airplane.id}: ${airplane.type}',
                  ),
                  DropdownButton<String>(
                    value: resDate,
                    hint: Text('Select Reservation Day'),
                    items: days.map((String day) {
                      return DropdownMenuItem<String>(
                        value: day,
                        child: Text(day),
                      );
                    }).toList(),
                    onChanged: (String? newDay) {
                      setState(() {
                        resDate = newDay;
                      });
                    },
                  ),
                  Spacer(),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (selectedCustomer != null && selectedFlight != null && selectedAirplane != null && resDate != null) {
                            final reservation = Reservation(
                              Reservation.ID++,
                              selectedCustomer!.id as int,
                              selectedFlight!.flight_id,
                              resDate!,
                            );
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text('Notice'),
                                  content: Text('Confirm Flight Reservation'),
                                  actions: <Widget>[
                                    ElevatedButton(
                                        onPressed: (){
                                          _reservationDao.insertReservation(reservation);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => HomePage())
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Success: Flight Reserved')),
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
                          }
                        },
                        child: Text('Add Reservation'),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                  ),
                ],
              ),
            )
        );
    }

  }

  Widget _buildDropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required void Function(T?) onChanged,
    required String Function(T) itemText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        DropdownButton<T>(
          value: value,
          hint: Text(label),
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(itemText(item)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
