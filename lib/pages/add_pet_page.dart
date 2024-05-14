import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/pages/add_missing_post_page.dart';
import 'package:projeto/repositories/pet_repository.dart';
import 'package:projeto/repositories/user_repository.dart';
import 'package:projeto/services/auth.service.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({super.key});

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

List<String> _petTypes = getPetTypeStrings();

class _AddPetPageState extends State<AddPetPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: const Text('Mel Pets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
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
                style: const TextStyle(color: Colors.black87, fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'Nome do pet',
                  labelStyle:
                      const TextStyle(color: Colors.black87, fontSize: 18),
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
                              petType.toString().substring(0, 1).toUpperCase() +
                                  petType.toString().substring(1).toLowerCase(),
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
                style: const TextStyle(color: Colors.black87, fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'Raça',
                  labelStyle:
                      const TextStyle(color: Colors.black87, fontSize: 18),

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
                style: const TextStyle(color: Colors.black87, fontSize: 20),
                decoration: InputDecoration(
                  labelText: 'Cor',
                  labelStyle:
                      const TextStyle(color: Colors.black87, fontSize: 18),
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
                  labelText: 'Selecione uma data',
                  labelStyle:
                      const TextStyle(color: Colors.black87, fontSize: 18),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var pet = Pet(
                id: Uuid().v4(),
                name: _value1.text,
                type: stringToPetType(_value2.text),
                breed: _value3.text,
                color: _value4.text,
                status: Status.found,
                dateOfBirth:
                    DateFormat('yyyy-MM-dd').parse(_dateController.text),
                userId: context.read<AuthService>().user!.uid);
            try {
              await context.read<PetRepository>().addPet(pet);
            } catch (e) {
              print('Error adding pet: $e');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.toString()),
                  backgroundColor: Colors.red,
                ),
              );
            }

            Navigator.pop(context);
          }
        },
        heroTag: 'salvar',
        child: const Icon(Icons.save),
      ),
    );
  }
}
