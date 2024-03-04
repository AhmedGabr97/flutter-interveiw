// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {
  List<dynamic> Tasks = [];

  @override
  void initState() {
    super.initState();
    FetchData();
  }


  Future<void> FetchData() async{
    Uri uri = Uri.parse("http://192.168.1.6:3000/tasks");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      setState(() {
        Tasks = jsonDecode(response.body);
      });
    } else{
      throw Exception("Cannot load tasks");
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter interview',
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff322F8F),
          onPressed: (){
            _showAddTaskModal(context);
          } , 
          child: const Icon(Icons.add , color: Colors.white,),),
        backgroundColor: const Color(0xff322F8F),
        appBar: AppBar(
          backgroundColor: const Color(0xff322F8F),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.notifications) , color: Colors.white,)
          ],
        ),
        drawer: const Drawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 40),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("Hello , " , style: TextStyle(color: Colors.white , fontSize: 28),),
                SizedBox(height: 10,),
                Text("Abdallah Eissa" , style: TextStyle(color: Colors.white , fontSize: 28))
              ]),
            ),

            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 50),
               width: double.infinity,
               decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50))
               ),
               child: ListView.builder( 
                itemCount: Tasks.length,
               itemBuilder:(context ,index) {
               
                return Container(
                  margin: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 221, 219, 219),
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: ListTile(
                    title: Text( "task 1", style: const TextStyle(fontWeight: FontWeight.bold , color: Color(0xff322F8F)),),
                    subtitle: const Text("Lorem Ipsum has been the industrys standard dummy text ever"),
                    trailing: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: null, icon: Icon(Icons.edit , color: Color(0xff322F8F))),
                        SizedBox(width: 5,),
                        IconButton(onPressed: null, icon: Icon(Icons.delete , color: Color.fromARGB(255, 228, 90, 80),),),
                      ],
                    ),
                  ),
                );
               } ),

            ))
          ],
        ),
      )
    );
  }

  void _showAddTaskModal(BuildContext context){
    showDialog(context: context, builder: (BuildContext context) {
      return  Dialog(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("New Task" ,style: TextStyle(fontSize: 22 , color: Color(0xff322F8F)),),
                const SizedBox(height: 20,),
                const TextField(
                  decoration: InputDecoration(
                    labelText: "enter your task name ",
                    border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 15,),
                const TextField(
                  decoration: InputDecoration(
                    labelText: "enter your task description ",
                    border: OutlineInputBorder()
                  ),
                ) ,
                const SizedBox(height: 15,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff322F8F),
                    minimumSize: const Size(double.infinity, 50)
                  ),
                  onPressed: () {
                    
                  }, 
                  child: const Text("Add" , style: TextStyle(color: Colors.white),))
              ],
            ),
          ),
        ),
      );
    });
  }
}

