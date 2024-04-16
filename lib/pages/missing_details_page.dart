import 'package:flutter/material.dart';
import 'package:projeto/pages/add_missing_post_multi_page.dart';
import 'package:projeto/repositories/missing_post_repository.dart';
import 'package:projeto/repositories/pet_repository.dart';
import 'package:projeto/repositories/user_repository.dart';
import 'package:provider/provider.dart';

class MissingDetailsPage extends StatefulWidget {
  String postId;

  MissingDetailsPage({super.key, required this.postId});

  @override
  State<MissingDetailsPage> createState() => _MissingDetailsPageState();
}

class _MissingDetailsPageState extends State<MissingDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var missingPost = Provider.of<MissingPostRepository>(
      context,
      listen: false,
    ).missingPosts.firstWhere(
          (element) => element.id == widget.postId,
        );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: Text(missingPost.description),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: missingPost.pet.image != null
                      ? Image.asset(
                          missingPost.pet.image as String,
                          width: 100,
                          height: 100,
                        )
                      : const SizedBox(
                          width: 100, // increase this value
                          height: 100, // increase this value
                          child: Icon(Icons.pets, size: 100),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        missingPost.pet.name as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        missingPost.pet.breed as String,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
      floatingActionButton: (missingPost.user.id == CurrentUser.currentUser?.id)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 45,
                  height: 45,
                  child: FloatingActionButton(
                    onPressed: () {
                      var petProvider = Provider.of<PetRepository>(
                        context,
                        listen: false,
                      );
                      petProvider.petFound(
                        missingPost.pet,
                      );
                      var postProvider = Provider.of<MissingPostRepository>(
                        context,
                        listen: false,
                      );
                      postProvider.removeMissingPost(missingPost);
                      Navigator.pop(context);
                    },
                    heroTag: 'deletar',
                    backgroundColor: Colors.red[400],
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 55,
                  height: 55,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MultiStepForm(
                            initialData: missingPost,
                          ),
                        ),
                      );
                    },
                    heroTag: 'editar',
                    child: const Icon(Icons.edit),
                  ),
                ),
              ],
            )
          : null,
    );
  }
}
