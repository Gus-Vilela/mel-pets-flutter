import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/models/missing_post.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/repositories/pet_repository.dart';
import 'package:projeto/services/auth.service.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

List<String> getPetTypeStrings() {
  return PetType.values.map((type) => type.toString().split('.').last).toList();
}

PetType stringToPetType(String type) {
  return PetType.values.firstWhere((e) => e.toString().split('.').last == type,
      orElse: () => PetType.outros);
}

String petTypeToString(PetType type) {
  return type.toString().split('.').last;
}

List<String> _petTypes = getPetTypeStrings();

class AddMissingPostPetPage extends StatefulWidget {
  final Future<void> Function(Map<String, dynamic>) onNextStep;
  final MissingPost? initialData;
  const AddMissingPostPetPage(
      {super.key, required this.onNextStep, this.initialData});

  @override
  State<AddMissingPostPetPage> createState() => _AddMissingPostPageState();
}

class _AddMissingPostPageState extends State<AddMissingPostPetPage> {
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _value1 = TextEditingController();
  final _value2 = TextEditingController();
  final _value3 = TextEditingController();
  final _value4 = TextEditingController();
  final _dateController = TextEditingController();
  List<Pet> pets = [];
  Pet? selectedPet;
  late PetRepository petRepository;

  @override
  void initState() {
    super.initState();
    petRepository = context.read<PetRepository>();
    pets = petRepository.allPets
        .where((pet) =>
            pet.userId == context.read<AuthService>().user!.uid &&
            pet.status != Status.lost)
        .map((pet) => pet)
        .toList();
    if (widget.initialData != null) {
      Pet? pet = petRepository.getPetById(widget.initialData!.petId);
      if (pet != null) {
        pets.add(pet);
        selectedPet = pet;
      }
    }
  }

  onSubmit() async {
    if (selectedPet != null) {
      selectedPet?.status = Status.lost;
      await petRepository.updatePet(selectedPet!);
      return await widget.onNextStep({
        'pet': selectedPet,
        'isNewPet': false,
      });
    }

    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        'pet': // pet
            Pet(
          id: const Uuid().v4(),
          name: _value1.text,
          type: stringToPetType(_value2.text),
          breed: _value3.text,
          color: _value4.text,
          userId: context.read<AuthService>().user!.uid,
          status: Status.lost,
          dateOfBirth: DateFormat('yyyy-MM-dd').parse(_dateController.text),
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
            if (pets.isNotEmpty)
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
                        value: selectedPet,
                        onChanged: (Pet? newValue) {
                          setState(() {
                            selectedPet = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                          errorStyle: const TextStyle(color: Colors.red),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red[400]!)),
                        ),
                        items: // list of pets
                            <DropdownMenuItem<Pet>>[
                          DropdownMenuItem<Pet>(
                            value: null,
                            child: Text(
                              selectedPet == null
                                  ? 'Selecione um dos seus pets'
                                  : 'Adicione um novo pet',
                              style: TextStyle(
                                  color: Colors.red[400],
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          ...pets.map((pet) {
                            return DropdownMenuItem<Pet>(
                              value: pet,
                              child: DefaultTextStyle(
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                                child: Text(pet.name as String),
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  )),
            if (selectedPet == null)
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
                    TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      onTap: () async {
                        await _selectDate();
                      },
                      decoration: InputDecoration(
                        labelText: 'Selecione a data de nascimento',
                        labelStyle: const TextStyle(
                            color: Colors.black87, fontSize: 18),
                        errorStyle: const TextStyle(color: Colors.red),
                        // selected style
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red[400]!),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            await _selectDate();
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira uma data';
                        }
                        // validate date
                        if (DateFormat('yyyy-MM-dd')
                            .parse(value)
                            .isAfter(DateTime.now())) {
                          return 'Data inválida';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onSubmit();
        },
        child: context.watch<PetRepository>().isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : const Icon(Icons.navigate_next),
      ),
    );
  }
}
