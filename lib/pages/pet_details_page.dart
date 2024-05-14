import 'package:flutter/material.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/models/user.dart';
import 'package:projeto/pages/add_missing_post_page.dart';
import 'package:projeto/repositories/pet_repository.dart';
import 'package:projeto/repositories/user_repository.dart';
import 'package:provider/provider.dart';

class PetDetailsPage extends StatefulWidget {
  String petId;
  PetDetailsPage({super.key, required this.petId});

  @override
  State<PetDetailsPage> createState() => _PetDetailsPageState();
}

class _PetDetailsPageState extends State<PetDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var pet = Provider.of<PetRepository>(context).getPetById(widget.petId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: const Text('Detalhes do Pet'),
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
                  if (pet.image != null)
                    Container(
                      width: 125.0,
                      height: 125.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            pet.image as String,
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(pet.name as String, // user name
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
                    const Icon(
                      Icons.pets,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        petTypeToString(pet.type),
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
                    const Icon(
                      Icons.category,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        pet.breed as String,
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
                // user address
                Row(
                  children: [
                    const Icon(
                      Icons.cake,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        pet.age == null
                            ? 'Idade desconhecida'
                            : pet.age == 0
                                ? 'Filhote'
                                : '${pet.age} anos',
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
                    const Icon(
                      Icons.palette,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        pet.color as String,
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
                // user address
                Row(
                  children: [
                    const Icon(
                      Icons.search,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        pet.status == Status.lost
                            ? 'Perdido'
                            : 'Unido ao seu dono',
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
                    const Icon(
                      Icons.person,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        pet.userId == null
                            ? 'Desconhecido'
                            : context
                                .read<UserRepository>()
                                .getUserById(pet.userId as String)
                                .name,
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
