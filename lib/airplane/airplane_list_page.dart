import 'package:flutter/material.dart';
import 'airplane.dart';
import 'airplane_dao.dart';
import 'airplane_add_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'airplane_detail_page.dart'; // Ensure this import is included

class AirplaneListPage extends StatefulWidget {
  final AirplaneDao airplaneDao;
  final SharedPreferences sharedPreferences;

  const AirplaneListPage({
    required this.airplaneDao,
    required this.sharedPreferences,
    Key? key,
  }) : super(key: key);

  @override
  _AirplaneListPageState createState() => _AirplaneListPageState();
}

class _AirplaneListPageState extends State<AirplaneListPage> {
  late Future<List<Airplane>> airplaneFuture;

  Airplane? selectedAirplane;
  late Function(Airplane) selectedUpdate;
  late Function(Airplane) selectedDelete;
  late SharedPreferences selectedPrefs;

  @override
  void initState() {
    super.initState();
    airplaneFuture = widget.airplaneDao.getAllAirplanes();
  }

  void navigateToAddAirplanePage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AirplaneAddPage(
          onAdd: (airplane) {
            _addAirplane(airplane);
          },
          sharedPreferences: widget.sharedPreferences,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    if ((width > height) && (width > 720)){
      return Scaffold(
          appBar: AppBar(
            title: Text('Airplane List'),
          ),
          body: Row(
            children: [
              Expanded(
                flex: 1,
                  child: TabletListView()
              ),
              Expanded(
                  flex: 1,
                  child: selectedAirplane != null
                  ? TabletDetailView(selectedAirplane!,
                          selectedUpdate,
                          selectedDelete,
                          selectedPrefs
                  ) : Center( child: Text('Select an Airplane'),)
              ),
            ],
          ),
      );
    }else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Airplane List'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: navigateToAddAirplanePage,
          tooltip: 'Add Airplane',
          child: Icon(Icons.add),
        ),
        body: FutureBuilder<List<Airplane>>(
          future: airplaneFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No airplane found.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Airplane airplane = snapshot.data![index];
                  return ListTile(
                    title: Text('${airplane.type} ${airplane.passengers}'),
                    subtitle: Text('Max Speed: ${airplane.maxSpeed} km/h\nRange: ${airplane.range} km'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AirplaneDetailPage(
                            airplane: airplane,
                            onUpdate: onUpdateAirplane,
                            onDelete: onDeleteAirplane,
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
  }

  void _addAirplane(Airplane airplane) async {
    await widget.airplaneDao.insertAirplane(airplane);
    setState(() {
      airplaneFuture = widget.airplaneDao.getAllAirplanes();
    });
  }

  void onUpdateAirplane(Airplane airplane) async {
    await widget.airplaneDao.updateAirplane(airplane);
    setState(() {
      airplaneFuture = widget.airplaneDao.getAllAirplanes();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Airplane updated successfully')),
    );
  }

  void onDeleteAirplane(Airplane airplane) async {
    await widget.airplaneDao.deleteAirplane(airplane);
    setState(() {
      airplaneFuture = widget.airplaneDao.getAllAirplanes();
    });
    Navigator.of(context).pop(); // Pop the detail page after deletion
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Airplane deleted successfully')),
    );
  }

  Widget TabletListView() {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddAirplanePage,
        tooltip: 'Add Airplane',
        child: Icon(Icons.add),
        ),
      body: FutureBuilder<List<Airplane>>(
        future: airplaneFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No airplane found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Airplane airplane = snapshot.data![index];
                return ListTile(
                  title: Text('${airplane.type} ${airplane.passengers}'),
                  subtitle: Text('Max Speed: ${airplane.maxSpeed} km/h\nRange: ${airplane.range} km'),
                  onTap: () {
                    setState(() {
                      selectedAirplane = airplane;
                      selectedUpdate = onUpdateAirplane;
                      selectedDelete = onDeleteAirplane;
                      selectedPrefs = widget.sharedPreferences;
                    });
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
  Widget TabletDetailView(Airplane selectedAirplane, Function(Airplane) selectedUpdate, Function(Airplane) selectedDelete, SharedPreferences prefs) {
    return AirplaneDetailPage(airplane: selectedAirplane,
      onUpdate: selectedUpdate,
      onDelete: selectedDelete,
      sharedPreferences: prefs,
    );
  }

}
