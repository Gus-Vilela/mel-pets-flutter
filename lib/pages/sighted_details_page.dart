import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/models/sighted.dart';
import 'package:projeto/repositories/sighted_repository.dart';
import 'package:projeto/services/auth.service.dart';
import 'package:provider/provider.dart';

class SightingDetailsPage extends StatelessWidget {
  final Sighted sighting;

  const SightingDetailsPage({Key? key, required this.sighting});

  @override
  Widget build(BuildContext context) {
    final isCurrentUserCreator =
        sighting.userId == context.read<AuthService>().user?.uid;

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
        backgroundColor: Colors.red[100],
      ),
      body: 
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_month, color: Colors.grey[80]),
                const SizedBox(width: 8),
                Text(
                  'Visto em: ${sighting.dateOfSight != null ? DateFormat('dd/MM/yyyy').format(sighting.dateOfSight!) : 'Não especificada'}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.color_lens, color: Colors.grey[80]),
                const SizedBox(width: 8),
                Text(
                  'Cor: ${sighting.color}',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.pets, color: Colors.grey[80]),
                const SizedBox(width: 8),
                Text('Espécie: ${sighting.type.name}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.category, color: Colors.grey[80]),
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
    var sightedRepository = context.read<SightedRepository>();
    sightedRepository.deleteSighting(sighting.id);
    Navigator.pop(context);
  }
}
