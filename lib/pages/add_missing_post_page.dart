import 'package:flutter/material.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/repositories/pet_repository.dart';
import 'package:projeto/repositories/user_repository.dart';

List<String> getPetTypeStrings() {
  return PetType.values.map((type) => type.toString().split('.').last).toList();
}

PetType stringToPetType(String type) {
  return PetType.values.firstWhere((e) => e.toString().split('.').last == type,
      orElse: () => PetType.other);
}

String petTypeToString(PetType type) {
  return type.toString().split('.').last;
}

List<String> _petTypes = getPetTypeStrings();

class AddMissingPostPetPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onNextStep;
  const AddMissingPostPetPage({super.key, required this.onNextStep});

  @override
  State<AddMissingPostPetPage> createState() => _AddMissingPostPageState();
}

class _AddMissingPostPageState extends State<AddMissingPostPetPage> {
  final _formKey = GlobalKey<FormState>();
  final _value1 = TextEditingController();
  final _value2 = TextEditingController();
  final _value3 = TextEditingController();
  final _value4 = TextEditingController();
  Pet? _selectedPet;
  final PetRepository petRepository = PetRepository();

  onSubmit() {
    if (_selectedPet != null) {
      return widget.onNextStep({
        'pet': _selectedPet,
        'isNewPet': false,
      });
    }

    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        'pet': // pet
            Pet(
          name: _value1.text,
          type: stringToPetType(_value2.text),
          breed: _value3.text,
          color: _value4.text,
          owner: CurrentUser.currentUser,
          status: Status.lost,
        ),
        'isNewPet': true,
      };

      widget.onNextStep(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Column(
                  children: [
                    const Text(
                      'Seus pets',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    DropdownButtonFormField<Pet>(
                      padding: // padding top
                          const EdgeInsets.only(top: 22),
                      value: _selectedPet,
                      items: [
                        DropdownMenuItem(
                            value: null,
                            child: Text('Selecione um do seus pets',
                                style: TextStyle(
                                    color: Colors.red[400],
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal))),
                        ...petRepository.allPets
                            .where((pet) =>
                                pet.owner?.email ==
                                CurrentUser.currentUser!.email)
                            .map((pet) => DropdownMenuItem(
                                  value: pet,
                                  child: Text(pet.name as String),
                                ))
                      ],
                      onChanged: (Pet? newValue) {
                        setState(() {
                          _selectedPet = newValue;
                        });
                      },
                      hint: Text('Selecione um do seus pets',
                          style: TextStyle(
                              color: Colors.red[400],
                              fontSize: 18,
                              fontWeight: FontWeight.normal)),
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                        errorStyle: const TextStyle(color: Colors.red),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red[400]!)),
                      ),
                    ),
                  ],
                )),
            if (_selectedPet == null)
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Novo pet',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      controller: _value1,
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 18),
                      decoration: InputDecoration(
                        labelText: 'Nome do pet',
                        labelStyle: const TextStyle(
                            color: Colors.black87, fontSize: 18),
                        errorStyle: const TextStyle(color: Colors.red),
                        // selected style
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red[400]!),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome do pet';
                        }
                        return null;
                      },
                    ),
                    // create a dropdown for pet type
                    DropdownButtonFormField(
                      hint: Text('Tipo do pet',
                          style: TextStyle(
                              color: Colors.red[400],
                              fontSize: 18,
                              fontWeight: FontWeight.normal)),
                      value: _value2.text.isEmpty ? null : _value2.text,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                        errorStyle: const TextStyle(color: Colors.red),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red[400]!)),
                      ),
                      padding: // padding top
                          const EdgeInsets.only(top: 22.0, bottom: 14.0),
                      items: _petTypes
                          .map((petType) => DropdownMenuItem(
                                value: petType,
                                child: DefaultTextStyle(
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  child: Text(
                                    petType
                                            .toString()
                                            .substring(0, 1)
                                            .toUpperCase() +
                                        petType
                                            .toString()
                                            .substring(1)
                                            .toLowerCase(),
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _value2.text = newValue.toString();
                        });
                      },
                    ),
                    TextFormField(
                      controller: _value3,
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 18),
                      decoration: InputDecoration(
                        labelText: 'Raça',
                        labelStyle: const TextStyle(
                            color: Colors.black87, fontSize: 18),

                        errorStyle: const TextStyle(color: Colors.red),
                        // selected style
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red[400]!),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a raça';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _value4,
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 20),
                      decoration: InputDecoration(
                        labelText: 'Cor',
                        labelStyle: const TextStyle(
                            color: Colors.black87, fontSize: 18),
                        errorStyle: const TextStyle(color: Colors.red),
                        // selected style
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red[400]!),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a cor';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            // Container(
            //   alignment: Alignment.center,
            //   padding: const EdgeInsets.only(top: 24.0),
            //   child: ElevatedButton(
            //     style: ButtonStyle(
            //       backgroundColor: MaterialStateProperty.all(Colors.red[100]),
            //     ),
            //     onPressed: () {
            //       onSubmit();
            //     },
            //     child: const Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Icon(Icons.add, color: Colors.black87),
            //         Padding(
            //             padding: EdgeInsets.all(8.0),
            //             child: Text('Adicionar postagem',
            //                 style: TextStyle(
            //                     color: Colors.black87, fontSize: 18))),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onSubmit();
        },
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
