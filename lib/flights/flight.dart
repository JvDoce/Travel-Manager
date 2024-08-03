// A class that represents a flight with relevant details.
class Flight {

  // The unique identifier for the flight. It can be null when creating a new flight.
  final int? id;

  // The city from which the flight departs.
  final String departureCity;

  // The city to which the flight is destined.
  final String destinationCity;

  // The departure time of the flight.
  final String departureTime;

  // The arrival time of the flight.
  final String arrivalTime;

  /* Constructor for creating a new Flight object.
   * The [departureCity], [destinationCity], [departureTime], and [arrivalTime] parameters are required.
   * The [id] parameter is optional and can be null.
   */
  Flight({
    this.id,
    required this.departureCity,
    required this.destinationCity,
    required this.departureTime,
    required this.arrivalTime,
  });

  /* Converts a Flight object into a Map.
   * This can be useful for storing flight details in a database or sending them over a network.
   */
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'departureCity': departureCity,
      'destinationCity': destinationCity,
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
    };
  }

  /* Creates a Flight object from a Map.
   * This factory constructor can be used to create a Flight instance from a Map,
   * such as one obtained from a database query or a JSON response.
   */
  factory Flight.fromMap(Map<String, dynamic> map) {
    return Flight(
      id: map['id'],
      departureCity: map['departureCity'],
      destinationCity: map['destinationCity'],
      departureTime: map['departureTime'],
      arrivalTime: map['arrivalTime'],
    );
  }

  /* Converts a Flight object into a JSON object.
   * This is useful for serializing a Flight instance to JSON format,
   * for example, when sending flight details over a network.
   */
  Map<String, dynamic> toJson() => toMap();

  /* Creates a Flight object from a JSON object.
   * This factory constructor allows creating a Flight instance from a JSON object,
   * such as one received from a network response.
   */
  factory Flight.fromJson(Map<String, dynamic> json) => Flight.fromMap(json);
}