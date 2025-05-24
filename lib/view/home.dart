import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nafsshield/view/Quran/HomePage/home_page.dart';
import 'package:nafsshield/view/audioquran.dart';
import 'package:nafsshield/view/tasbih/tasbih.dart';
import 'package:nafsshield/view/compass.dart';

import 'package:nafsshield/view/audio_quran/audio_home.dart';
import 'package:nafsshield/view/Self-exam/Self-exam.dart';

import 'package:nafsshield/view/ShifaMind/shifamind.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final List<String> topic = [
    'Quran',
    'Hadith',
    'Audio Quran',
    'Qibla compass',
    'Azan Alarm',
    'Calender',
    'Tasbih',
    'Self-exam',
    'ShifaMind'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            //maxCrossAxisExtent: 150, // Maximum width of each item
            crossAxisSpacing: 20,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.all(10),
            children: List.generate(topic.length, (index) {
              return InkWell(
                onTap: () {
                  switch (topic[index]){
                    case 'Quran':
                      // Get.to(const HomePage(), arguments: 'Quran');
                      Get.to(HomePage());
                      break;
                    case 'Audio Quran':
                    // Get.to(const HomePage(), arguments: 'Quran');
                      Get.to(AudioHome());
                      break;
                    case 'Tasbih':
                    // Get.to(const HomePage(), arguments: 'Quran');
                      Get.to(Tasbih());
                      break;

                    case 'Qibla compass':
                    // Get.to(const HomePage(), arguments: 'Quran');
                      Get.to(KiblaCompass());
                      break;
                    case 'Self-exam':
                    // Get.to(const HomePage(), arguments: 'Quran');
                      Get.to(selfexam());
                      break;
                    case 'ShifaMind':
                    // Get.to(const HomePage(), arguments: 'Quran');
                      Get.to(GeminiResponsePage());
                      break;

                  }
                },

                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.greenAccent.shade700, Colors.greenAccent.shade400, Colors.greenAccent.shade200],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(4, 4), // Soft shadow on the bottom right
                      ),
                    ],
                  ),

                  child: Center(
                    child: Text(
                      topic[index],
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
