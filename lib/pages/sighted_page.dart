import 'package:flutter/material.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/models/sighted.dart';
import 'package:projeto/pages/sighted_details_page.dart';
import 'package:projeto/repositories/sighted_repository.dart';
import 'package:projeto/repositories/user_repository.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SightedPage extends StatefulWidget {
  const SightedPage({super.key});

  @override
  State<SightedPage> createState() => _SightedPageState();
}

class _SightedPageState extends State<SightedPage> {
  late List<Sighted> _filteredSightings;
  final TextEditingController _searchController = TextEditingController();
  String _selectedSearchItem = 'Cor';

  @override
  void initState() {
    _filteredSightings = Provider.of<SightedRepository>(
      context,
      listen: false,
    ).allSightings;
    _searchController.addListener(_searchSightings);
    super.initState();
  }
  
   _searchSightings() {
    final String searchText = _searchController.text.toLowerCase();
    setState(() {
      _filteredSightings = Provider.of<SightedRepository>(
        context,
        listen: false,
      ).allSightings.where((sighting) {
        switch (_selectedSearchItem) {
          case 'Cor':
            return sighting.color.toLowerCase().contains(searchText);
          case 'Raça':
            return sighting.breed?.toLowerCase().contains(searchText) ?? false;
          case 'Descrição':
            return sighting.description?.toLowerCase().contains(searchText) ?? false;
          case 'Endereço':
            return sighting.address.toLowerCase().contains(searchText);
          case 'Cidade':
            return sighting.city.toLowerCase().contains(searchText);
          default:
            return false;
        }
      }).toList();
      
    });
  }

  void _addSighting() async {
    await showDialog(
      context: context,
      builder: (_) => _AddSightingDialog(
        onSightingAdded: (sighting) {
          Provider.of<SightedRepository>(
            context,
            listen: false,
          ).addSighting(sighting);
          _searchSightings();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                          builder: (context) => SightingDetailsPage(sighting: sighting, onSearch: _searchSightings),
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
                _searchSightings();
              });
              Navigator.pop(context);
            },
            items: <String>['Cor', 'Raça', 'Descrição', 'Endereço', 'Cidade']
                .map<DropdownMenuItem<String>>((String value) {
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

  @override
  void initState() {
    super.initState();
    _type = PetType.dog;
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
              decoration: const InputDecoration(labelText: 'Cor'),
              onChanged: (value) => _color = value,
            ),
            DropdownButtonFormField<PetType>(
              value: _type,
              onChanged: (value) => setState(() => _type = value!),
              items: const [
                DropdownMenuItem<PetType>(
                  value: PetType.dog,
                  child: Text('Cachorro'),
                ),
                DropdownMenuItem<PetType>(
                  value: PetType.cat,
                  child: Text('Gato'),
                ),
                DropdownMenuItem<PetType>(
                  value: PetType.bird,
                  child: Text('Pássaro'),
                ),
                DropdownMenuItem<PetType>(
                  value: PetType.other,
                  child: Text('Outro'),
                ),
              ],
              decoration: const InputDecoration(labelText: 'Espécie'),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Raça'),
              onChanged: (value) => _breed = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Descrição'),
              onChanged: (value) => _description = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Endereço'),
              onChanged: (value) => _address = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Cidade'),
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
              color: _color,
              type: _type,
              breed: _breed,
              description: _description,
              address: _address,
              city: _city,
              user: CurrentUser.currentUser
            );
            widget.onSightingAdded(newSighting);
            Navigator.pop(context);
          },
          child: const Text('Adicionar'),
        ),
      ],
    );
  }
}
