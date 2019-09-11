import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

void main(){

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage() 
    ),
  );

}


class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{

  Map data;
  List usersData;
  

   getUsers() async {

    http.Response	response = await http.get('http://10.0.2.2:4000/api/users');
    data = json.decode(response.body);
    
    usersData= data['users'];

    setState(() {
      
    });
  }

  void deleteUser(String apellido) async {

     

       await http.get('http://10.0.2.2:4000/api/users/delete/' + apellido);
         
     
       sleep(Duration(milliseconds:1000));
        getUsers();

  }

  void createUsers()  async{

    await http.get('http://10.0.2.2:4000/api/users/create');

    getUsers();

  }

  @override
  void initState(){

    super.initState();
    getUsers();

  }


  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de usuario'),
        backgroundColor: Colors.indigo[900],
        ),
        body: ListView.builder(
          itemCount: usersData == null ? 0: usersData.length,
          itemBuilder: (BuildContext context, int index){
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("$index", 
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500)
                        ),
                    ),
                    CircleAvatar(backgroundImage: NetworkImage(usersData[index]['avatar']),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0) ,
                      child: Text("${usersData[index]["firstName"]} ${usersData[index]["lastName"]}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700
                      ),),
                    ),
                    Padding(
                      
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        
                        icon: Icon(Icons.delete_forever),
                        
                        tooltip: 'Eliminar',
                        onPressed: (){
                          
                          deleteUser("${usersData[index]["lastName"]}");

                        },
                      
                      )
                        
                      
                    ),
                  ],
                ),
              ),
            );
            
            
          },
          
        ),
        
        floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: (){

                createUsers();

              },
            ),
    );
  }

}