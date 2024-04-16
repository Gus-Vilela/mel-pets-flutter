import 'package:flutter/material.dart';
import 'package:projeto/repositories/user_repository.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: const Text('Mel Pets'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: Center(
             
              child: Column(
               
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  if (CurrentUser.currentUser.image != null)
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        CurrentUser.currentUser.image as String,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        CurrentUser.currentUser.name, 
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
            ),
          ),
         
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.red[300] as Color,
                width: 2,
              ),
            ),
            child: Column(
              children: [
               
                Row(
                  children: [
                    const Icon(Icons.email),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        CurrentUser.currentUser.email,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    const Icon(Icons.phone),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        CurrentUser.currentUser.phone as String,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
         
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.red[300] as Color,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                
                Row(
                  children: [
                    const Icon(Icons.location_on),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        CurrentUser.currentUser.address as String,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
               
                Row(
                  children: [
                    const Icon(Icons.location_city),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        CurrentUser.currentUser.city as String,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
