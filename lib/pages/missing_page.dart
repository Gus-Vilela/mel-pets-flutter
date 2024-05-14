import 'package:flutter/material.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/pages/add_missing_post_multi_page.dart';
import 'package:projeto/pages/missing_details_page.dart';
import 'package:projeto/repositories/missing_post_repository.dart';
import 'package:projeto/repositories/pet_repository.dart';
import 'package:provider/provider.dart';

class MissingPage extends StatefulWidget {
  const MissingPage({super.key});

  @override
  State<MissingPage> createState() => _MissingPageState();
}

class _MissingPageState extends State<MissingPage> {
  @override
  Widget build(BuildContext context) {
    onShowDetails(String postId) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MissingDetailsPage(postId: postId),
        ),
      );
    }

    onAddMissingPost() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MultiStepForm()),
      );
    }

    var petRepository = context.watch<PetRepository>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: const Text('Mel Pets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        // list of missing posts
        child: Consumer<MissingPostRepository>(
            builder: (context, missingPostRepository, child) {
          return ListView.builder(
            itemCount: missingPostRepository.missingPosts.length,
            itemBuilder: (context, post) {
              Pet? pet = petRepository
                  .getPetById(missingPostRepository.missingPosts[post].petId);
              return pet == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Card.outlined(
                      shadowColor: Colors.red,
                      color: Colors.red[100],
                      child: ListTile(
                        title: Text(
                          missingPostRepository.missingPosts[post].description,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(pet.name as String),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: pet.image != null
                              ? Image.asset(
                                  pet.image as String,
                                  width: 65,
                                  height: 65,
                                )
                              : const SizedBox(
                                  width: 65, // increase this value
                                  height: 65, // increase this value
                                  child: Icon(Icons.pets, size: 45),
                                ),
                        ),
                        onTap: () => onShowDetails(
                            missingPostRepository.missingPosts[post].id),
                      ),
                    );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onAddMissingPost();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
