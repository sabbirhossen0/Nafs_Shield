import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;

class KiblaCompass extends StatefulWidget {
  const KiblaCompass({super.key});

  @override
  State<KiblaCompass> createState() => _KiblaCompassState();
}

class _KiblaCompassState extends State<KiblaCompass> {
  bool _hasPermissions = false;
  double? _direction; // Store compass heading

  @override
  void initState() {
    super.initState();
    _fetchPermissionStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor("#254C27"),
        ),
        backgroundColor: HexColor("#254C27"),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Text("ক্কিবলা কম্পাস",style: TextStyle(
          color: Colors.white
        ),),
        centerTitle: true,
      ),
      body: _hasPermissions ? _buildCompass() : _buildPermissionSheet(),
    );
  }

  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        double? direction = snapshot.data?.heading;

        // **Fix: Handle unreliable sensor readings**
        if (direction == null || direction.isNaN) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning, size: 50, color: Colors.red),
                SizedBox(height: 10),
                Text(
                  "Compass sensor is unreliable. Please calibrate. problem",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Try moving your phone in a figure-eight motion.",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        _direction = direction; // Store heading value

        return Material(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${direction.ceil()}°",
                style: TextStyle(
                  fontSize: 25,
                  color: HexColor("#254C27"),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),
              Transform.rotate(
                angle: (direction * (math.pi / 180) * -1),
                child: Image.asset('assets/campass.png'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPermissionSheet() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {
            Permission.locationWhenInUse.request().then((status) {
              _fetchPermissionStatus();
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: HexColor("#fff"),
              ),
              child: Center(
                child: Text(
                  'Request Permission',
                  style: TextStyle(
                    color: HexColor("#254C27"),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        InkWell(
          onTap: () {
            openAppSettings();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: HexColor("#fff"),
              ),
              child: Center(
                child: Text(
                  'Open App Settings',
                  style: TextStyle(
                    color: HexColor("#254C27"),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _fetchPermissionStatus() async {
    PermissionStatus status = await Permission.locationWhenInUse.status;
    setState(() {
      _hasPermissions = status == PermissionStatus.granted;
    });
  }
}
