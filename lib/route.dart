import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:nafsshield/view/home.dart';



class route extends StatefulWidget {
  const route({super.key});

  @override
  State<route> createState() => _routeState();
}

class _routeState extends State<route> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    // Set status bar color to match AppBar
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.green, // Same as AppBar
        statusBarIconBrightness: Brightness.light, // White icons
      ),
    );
    return SafeArea(child: Column(
      children: [
        // Custom AppBar with TabBar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("")),
            color: Colors.green,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              // App Title
              Text(
                "Nafs Shield",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),

              // Custom TabBar
              TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                labelColor: Colors.green,
                unselectedLabelColor: Colors.white,
                tabs: const [
                  Tab(icon: Icon(Icons.home), text: "Home"),

                  Tab(icon: Icon(Icons.leaderboard), text: "Leaderboard"),
                  Tab(icon: Icon(Icons.settings), text: "Settings"),
                ],
              ),
            ],
          ),
        ),

        // TabBar Views
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Center(child: Text("Quiz Page", style: TextStyle(fontSize: 18))),
              Home(),
              Center(child: Text("Leaderboard Page", style: TextStyle(fontSize: 18))),
              Center(child: Text("Settings Page", style: TextStyle(fontSize: 18))),
            ],
          ),
        ),
      ],
    ));
  }
}
