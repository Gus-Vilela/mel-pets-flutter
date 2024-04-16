import 'package:flutter/material.dart';
import 'package:projeto/pages/add_missing_post_multi_page.dart';
import 'package:projeto/pages/missing_details_page.dart';
import 'package:projeto/repositories/missing_post_repository.dart';
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
              return Card.outlined(
                shadowColor: Colors.red,
                color: Colors.red[100],
                child: ListTile(
                  title: Text(
                    missingPostRepository.missingPosts[post].description,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(missingPostRepository
                      .missingPosts[post].pet.name as String),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: missingPostRepository.missingPosts[post].pet.image !=
                            null
                        ? Image.asset(
                            missingPostRepository.missingPosts[post].pet.image
                                as String,
                            width: 60,
                            height: 60,
                          )
                        : const SizedBox(
                            width: 60, // increase this value
                            height: 60, // increase this value
                            child: Icon(Icons.pets, size: 60),
                          ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_comment_rounded),
                    onPressed: () {},
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
