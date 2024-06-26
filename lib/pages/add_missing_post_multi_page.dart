import 'package:flutter/material.dart';
import 'package:projeto/models/missing_post.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/pages/add_missing_post_details_page.dart';
import 'package:projeto/pages/add_missing_post_page.dart';
import 'package:projeto/repositories/missing_post_repository.dart';
import 'package:projeto/repositories/pet_repository.dart';
import 'package:projeto/services/auth.service.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MultiStepForm extends StatefulWidget {
  final MissingPost? initialData;
  const MultiStepForm({this.initialData, super.key});

  @override
  State<MultiStepForm> createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  int _currentStep = 0;
  final PageController _controller = PageController();
  final Map<String, dynamic> _formData = {};
  late MissingPostRepository postRepository;
  late PetRepository petRepository;

  Future<void> onNextStep(
    Map<String, dynamic> data,
  ) async {
    _formData.addAll(data);
    if (_currentStep < 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      setState(() {
        _currentStep++;
      });
      return;
    }
    if (_formData['isNewPet'] as bool) {
      petRepository.addPet(
        _formData['pet'] as Pet,
      );
    }
    if (widget.initialData != null) {
      await postRepository.updateMissingPost(
        MissingPost(
          id: widget.initialData!.id,
          location: _formData['location'] as String,
          description: _formData['description'] as String,
          date: DateTime.parse(_formData['date'] as String),
          petId: _formData['pet'].id,
          userId: context.read<AuthService>().user!.uid,
        ),
      );
      Navigator.pop(context);
      return;
    }

    await postRepository.addMissingPost(
      MissingPost(
        id: Uuid().v4(),
        location: _formData['location'] as String,
        description: _formData['description'] as String,
        date: DateTime.parse(_formData['date'] as String),
        petId: _formData['pet'].id,
        userId: context.read<AuthService>().user!.uid,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    postRepository = context.read<MissingPostRepository>();
    petRepository = context.read<PetRepository>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: widget.initialData == null
            ? const Text('Novo desaparecimento')
            : const Text('Editar desaparecimento'),
      ),
      body: PageView(
        controller: _controller,
        physics:
            const NeverScrollableScrollPhysics(), // disable swipe to next page
        children: <Widget>[
          _buildStep1(),
          _buildStep2(),
          // Add more steps here
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return AddMissingPostPetPage(
      onNextStep: onNextStep,
      initialData: widget.initialData,
    );
  }

  Widget _buildStep2() {
    if (_formData['pet'] != null) {
      return AddMissingPostDetailsPage(
        onNextStep: onNextStep,
        initialData: widget.initialData,
        pet: _formData['pet'] as Pet,
      );
    }
    return const Center(
      child: Text('Pet not selected'),
    );
  }
}
