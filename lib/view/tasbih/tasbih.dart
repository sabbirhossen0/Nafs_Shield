import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nafsshield/view/tasbih/controllar.dart';

class Tasbih extends StatefulWidget {
  const Tasbih({super.key});

  @override
  State<Tasbih> createState() => _TasbihState();
}

class _TasbihState extends State<Tasbih> {

  final CounterController counterController = Get.put(CounterController());


  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/tasbih.jpg"), // For local images
          fit: BoxFit.cover, // Adjusts the image to cover the entire container
        ),
      ),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
    // crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // SizedBox(
      //   height: 300,
      // ),
      Obx(() => Text(
        "Count: ${counterController.count}",
        style: const TextStyle(fontSize: 32),
      )),

      SizedBox(height: 30,),

      ElevatedButton(onPressed: (){
        counterController.increment();
      }, child: Text("Increment")),
      ElevatedButton(onPressed: (){
        counterController.decrement();
      }, child: Text("Decrement")),
      ElevatedButton(onPressed: (){
counterController.reset();
      }, child: Text("Reset")),


      Container(
          height: 70,
          margin: EdgeInsets.all(10),
          width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: const Color(0x80000000),
                blurRadius: 12.0,
                offset: Offset(0.0, 5.0),
              ),
            ],
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 229, 255, 0),
                Color.fromARGB(255, 238, 1, 222)
              ],
            )
        ),
          child: Center(
            child: Text(
              "Submit 📩",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,)
              ,)
            ,)
      )



    ],
    ),)
    );
  }
}
