import 'package:flutter/material.dart';
import 'package:projeto/models/sighted.dart';
import 'package:projeto/models/user.dart';
import 'package:projeto/repositories/sighted_repository.dart';
import 'package:projeto/repositories/user_repository.dart';
import 'package:provider/provider.dart'; 

class SightingDetailsPage extends StatelessWidget {
  final Sighted sighting;
  final Function onSearch;

  const SightingDetailsPage({Key? key, required this.sighting, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    final isCurrentUserCreator = sighting.user.id == CurrentUser.currentUser.id;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalhes do avistamento',
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, 
        backgroundColor:  Colors.red[100], 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row( 
              children: [
                Icon(Icons.color_lens, color: Colors.grey[80]), 
                const SizedBox(width: 8), 
                Text(
                  'Cor: ${sighting.color}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row( 
              children: [
                Icon(Icons.pets, color: Colors.grey[80]), 
                const SizedBox(width: 8),
                Text('Espécie: ${sighting.type}'),
              ],
            ),
            const SizedBox(height: 8),
            Row( 
              children: [
                Icon(Icons.category, color:  Colors.grey[80]), 
                const SizedBox(width: 8),
                Text('Raça: ${sighting.breed ?? 'Não especificada'}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.description, color: Colors.grey[80]), 
                const SizedBox(width: 8), 
                Text('Descrição: ${sighting.description ?? 'Sem descrição'}'),
              ],
            ),
            const SizedBox(height: 8),
            Row( 
              children: [
                Icon(Icons.location_on, color: Colors.grey[80]), 
                const SizedBox(width: 8), 
                Text('Endereço: ${sighting.address}'),
              ],
            ),
            const SizedBox(height: 8),
            Row( 
              children: [
                Icon(Icons.location_city, color: Colors.grey[80]), 
                const SizedBox(width: 8), 
                Text('Cidade: ${sighting.city}'),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: isCurrentUserCreator 
          ? FloatingActionButton( 
              onPressed: () {
                _deleteSighting(context); 
              },
              backgroundColor: Colors.red[400],
              child: const Icon(Icons.delete),
            )
          : null, 
    );
  }

  
  void _deleteSighting(BuildContext context) {
    final sightedRepository = Provider.of<SightedRepository>(context, listen: false);
    sightedRepository.deleteSighting(sighting.id); 
    onSearch(); 
    Navigator.pop(context); 
  }
}
