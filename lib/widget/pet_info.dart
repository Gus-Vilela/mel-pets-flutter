import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/models/pet.dart';

class PetInfoDialog extends StatelessWidget {
  final Pet pet;

  const PetInfoDialog(this.pet, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero, // Remove o preenchimento interno
      backgroundColor: Colors.transparent, // Define a cor de fundo transparente para o AlertDialog
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // Fundo branco
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.pink, // Cor da borda cor de rosa
                width: 2.0, // Largura da borda
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Informações do Pet',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  if (pet.image != null)
                    Container(
                      height: 150.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage(pet.image!),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Nome: ${pet.name}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Tipo: ${_getTypeText(pet.type)}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Raça: ${pet.breed ?? 'Não especificada'}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Data de Nascimento: ${_formatDate(pet.dateOfBirth)}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Cor: ${pet.color ?? 'Não especificada'}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Proprietário: ${pet.owner != null ? pet.owner!.name : 'Não especificado'}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTypeText(PetType type) {
    switch (type) {
      case PetType.dog:
        return 'Cachorro';
      case PetType.cat:
        return 'Gato';
      case PetType.bird:
        return 'Pássaro';
      case PetType.fish:
        return 'Peixe';
      case PetType.rabbit:
        return 'Coelho';
      case PetType.hamster:
        return 'Hamster';
      case PetType.turtle:
        return 'Tartaruga';
      case PetType.guineaPig:
        return 'Porquinho da Índia';
      case PetType.other:
        return 'Outro';
      default:
        return 'Desconhecido';
    }
  }

  String _formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('dd/MM/yyyy').format(date);
    } else {
      return 'Não especificada';
    }
  }
}
