import 'package:flutter/material.dart';
import 'package:projeto/pages/add_missing_post_page.dart';
import 'package:projeto/pages/add_pet_page.dart';
import 'package:projeto/pages/pet_details_page.dart';
import 'package:projeto/repositories/pet_repository.dart';
import 'package:projeto/repositories/user_repository.dart';
import 'package:provider/provider.dart';

class myPetsPage extends StatefulWidget {
  const myPetsPage({super.key});

  @override
  State<myPetsPage> createState() => _myPetsPageState();
}

class _myPetsPageState extends State<myPetsPage> {
  onShowDetails(String petId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PetDetailsPage(petId: petId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: const Row(
          children: [
            Text('Seus Pets'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        // list of missing posts
        child:
            Consumer<PetRepository>(builder: (context, petRepository, child) {
          var userPets = petRepository.pets
              .where((pet) => pet.owner?.id == CurrentUser.currentUser.id)
              .toList();

          return ListView.builder(
            itemCount: userPets.length,
            itemBuilder: (context, pet) {
              return Card(
                shadowColor: Colors.red,
                color: Colors.red[100],
                child: ListTile(
                  title: Text(
                    userPets[pet].name as String,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(petTypeToString(userPets[pet].type)),
                      Text(
                        userPets[pet].breed as String,
                      ),
                    ],
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: userPets[pet].image != null
                        ? Image.asset(
                            userPets[pet].image as String,
                            width: 70,
                            height: 70,
                          )
                        : const SizedBox(
                            width: 70,
                            height: 70,
                            child: Icon(Icons.pets, size: 50),
                          ),
                  ),
                  onTap: () => onShowDetails(userPets[pet].id), // Add this line
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddPetPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
