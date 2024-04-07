import 'package:flutter/material.dart';
import 'package:projeto/repositories/missing_post_repository.dart';

class MissingPage extends StatelessWidget {
  const MissingPage({super.key});

  @override
  Widget build(BuildContext context) {
    MissingPostRepository missingPostRepository = MissingPostRepository();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: const Text('Mel Pets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        // list of missing posts
        child: ListView.builder(
          itemCount: missingPostRepository.missingPosts.length,
          itemBuilder: (context, index) {
            return Card.outlined(
              shadowColor: Colors.red,
              color: Colors.red[100],
              child: ListTile(
                  title: Text(
                    missingPostRepository.missingPosts[index].description,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(missingPostRepository
                      .missingPosts[index].pet.name as String),
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        missingPostRepository.missingPosts[index].pet.image
                            as String,
                      )),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_comment_rounded),
                    onPressed: () {},
                  )),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
