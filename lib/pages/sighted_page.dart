import 'package:flutter/material.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/models/sighted.dart';
import 'package:projeto/pages/sighted_details_page.dart';
import 'package:projeto/repositories/sighted_repository.dart';
import 'package:projeto/services/auth.service.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class SightedPage extends StatefulWidget {
  const SightedPage({super.key});

  @override
  State<SightedPage> createState() => _SightedPageState();
}

class _SightedPageState extends State<SightedPage> {
  late SightedRepository _sightedRepository;
  late List<Sighted> _filteredSightings;
  final TextEditingController _searchController = TextEditingController();
  String _selectedSearchItem = 'Cor';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchSightings);
  }

  void _searchSightings() {
    setState(() {
      _filteredSightings = _sightedRepository.filteredSightings(
        _searchController.text,
        _selectedSearchItem,
      );
    });
  }

  void _addSighting() async {
    await showDialog(
      context: context,
      builder: (_) => _AddSightingDialog(
        onSightingAdded: (sighting) {
          _sightedRepository.addSighting(sighting);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _sightedRepository = context.watch<SightedRepository>();
    _filteredSightings = _sightedRepository.filteredSightings(
      _searchController.text,
      _selectedSearchItem,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: const Text('Mel Pets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Pesquisar',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _showFilterDialog,
                  icon: const Icon(Icons.filter_list),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredSightings.length,
                itemBuilder: (context, index) {
                  final sighting = _filteredSightings[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SightingDetailsPage(sighting: sighting),
                        ),
                      );
                    },
                    child: Card(
                      shadowColor: Colors.red,
                      color: Colors.red[100],
                      child: ListTile(
                        title: Text(
                          'Cor: ${sighting.color}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Cidade: ${sighting.city}'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSighting,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Filtrar por:'),
          content: DropdownButton<String>(
            value: _selectedSearchItem,
            onChanged: (value) {
              setState(() {
                _selectedSearchItem = value!;
              });
              Navigator.pop(context);
            },
            items: <String>[
              'Cor',
              'Raça',
              'Descrição',
              'Endereço',
              'Cidade',
              'Visto em'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _AddSightingDialog extends StatefulWidget {
  final Function(Sighted) onSightingAdded;

  const _AddSightingDialog({required this.onSightingAdded});

  @override
  _AddSightingDialogState createState() => _AddSightingDialogState();
}

class _AddSightingDialogState extends State<_AddSightingDialog> {
  late String _color;
  late PetType _type;
  late String _breed;
  late String _description;
  late String _address;
  late String _city;
  DateTime? _dateOfSight;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _type = PetType.cachorro;
    // _dateOfSight = DateTime.now();
    _dateController = TextEditingController();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dateOfSight) {
      setState(() {
        _dateOfSight = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(_dateOfSight!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Avistamento'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _dateController,
              readOnly:true,
              decoration: InputDecoration(
                labelText: 'Data do Avistamento',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[400]!),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Cor',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[400]!),
                ),
              ),
              onChanged: (value) => _color = value,
            ),
            DropdownButtonFormField<PetType>(
              value: _type,
              onChanged: (value) => setState(() => _type = value!),
              items: const [
                DropdownMenuItem<PetType>(
                  value: PetType.cachorro,
                  child: Text('Cachorro'),
                ),
                DropdownMenuItem<PetType>(
                  value: PetType.gato,
                  child: Text('Gato'),
                ),
                DropdownMenuItem<PetType>(
                  value: PetType.passaro,
                  child: Text('Pássaro'),
                ),
                DropdownMenuItem<PetType>(
                  value: PetType.outros,
                  child: Text('Outro'),
                ),
              ],
              decoration: InputDecoration(
                labelText: 'Espécie',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[400]!),
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Raça',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[400]!),
                ),
              ),
              onChanged: (value) => _breed = value,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Descrição',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[400]!),
                ),
              ),
              onChanged: (value) => _description = value,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Endereço',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[400]!),
                ),
              ),
              onChanged: (value) => _address = value,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Cidade',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[400]!),
                ),
              ),
              onChanged: (value) => _city = value,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Sighted newSighting = Sighted(
              id: const Uuid().v4(),
              dateOfSight: _dateOfSight,
              color: _color,
              type: _type,
              breed: _breed,
              description: _description,
              address: _address,
              city: _city,
              userId: context.read<AuthService>().user!.uid,
            );
            widget.onSightingAdded(newSighting);
            Navigator.pop(context);
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color?>(Colors.black87),
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (states) => Colors.red[100]),
          ),
          child: const Text('Adicionar'),
        ),
      ],
    );
  }
}
