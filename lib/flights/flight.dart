class Flight {
  final int? id;
  final String departureCity;
  final String destinationCity;
  final String departureTime;
  final String arrivalTime;

  Flight({
    this.id,
    required this.departureCity,
    required this.destinationCity,
    required this.departureTime,
    required this.arrivalTime,
  });

  // Convert a Flight into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'departureCity': departureCity,
      'destinationCity': destinationCity,
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
    };
  }

  // Convert a Map into a Flight.
  factory Flight.fromMap(Map<String, dynamic> map) {
    return Flight(
      id: map['id'],
      departureCity: map['departureCity'],
      destinationCity: map['destinationCity'],
      departureTime: map['departureTime'],
      arrivalTime: map['arrivalTime'],
    );
  }

  // Convert a Flight into a JSON object.
  Map<String, dynamic> toJson() => toMap();

  // Convert a JSON object into a Flight.
  factory Flight.fromJson(Map<String, dynamic> json) => Flight.fromMap(json);
}