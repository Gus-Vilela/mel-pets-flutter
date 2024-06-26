import 'package:flutter/material.dart';
import 'package:projeto/pages/my_pets_page.dart';
import 'package:projeto/repositories/user_repository.dart';
import 'package:provider/provider.dart';

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
        body:
            Consumer<UserRepository>(builder: (context, userRepository, child) {
          return userRepository.currentUser == null || userRepository.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            userRepository.currentUser!.image != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage(
                                      userRepository.currentUser!.image
                                          as String,
                                    ),
                                  )
                                : const CircleAvatar(
                                    radius: 50,
                                    child: Icon(Icons.person),
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                  userRepository.currentUser!.name, // user name
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
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
                                  userRepository.currentUser!.email,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // user phone
                          Row(
                            children: [
                              const Icon(Icons.phone),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  userRepository.currentUser!.phone ??
                                      'Não informado',
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.red[300] as Color,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          // user address
                          Row(
                            children: [
                              const Icon(Icons.location_on),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  userRepository.currentUser!.address ??
                                      'Não informado',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // user city
                          Row(
                            children: [
                              const Icon(Icons.location_city),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  userRepository.currentUser!.city ??
                                      'Não informado',
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
                );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const myPetsPage(),
              ),
            );
          },
          child: const Icon(Icons.pets),
        ));
  }
}
