import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/models/missing_post.dart';
import 'package:projeto/models/pet.dart';

class AddMissingPostDetailsPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onNextStep;
  final Pet pet;
  final MissingPost? initialData;
  const AddMissingPostDetailsPage(
      {super.key,
      required this.onNextStep,
      required this.pet,
      this.initialData});

  @override
  State<AddMissingPostDetailsPage> createState() =>
      _AddMissingPostDetailsPageState();
}

class _AddMissingPostDetailsPageState extends State<AddMissingPostDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _value1 = TextEditingController();
  final _value2 = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _value1.text = widget.initialData!.description;
      _value2.text = widget.initialData!.location;
      _dateController.text =
          DateFormat('yyyy-MM-dd').format(widget.initialData!.date);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    onSubmit() {
      if (_formKey.currentState!.validate()) {
        widget.onNextStep({
          'description': _value1.text,
          'location': _value2.text,
          'date': _dateController.text,
        });
      }
    }

    return Scaffold(
        body: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(24.0),
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
                    labelText: 'Descrição do ocorrido',
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
                      return 'Por favor, insira uma descrição';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _value2,
                  style: const TextStyle(color: Colors.black87, fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Local aproximado do ocorrido',
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
                      return 'Por favor, insira o local aproximado do ocorrido';
                    }
                    return null;
                  },
                ),
                // date picker
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
          onPressed: onSubmit,
          child: const Icon(Icons.arrow_forward),
        ));
  }
}
