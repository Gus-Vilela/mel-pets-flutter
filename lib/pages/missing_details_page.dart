import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/models/pet.dart';
import 'package:projeto/pages/add_missing_post_multi_page.dart';
import 'package:projeto/pages/add_missing_post_page.dart';
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
      listen: true,
    ).missingPosts.firstWhere(
          (element) => element.id == widget.postId,
        );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: Text(missingPost.description),
      ),
      body: SingleChildScrollView(
        reverse: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.red[300] as Color,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.description,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          missingPost.description,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.place,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          missingPost.location,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          //format date date fns
                          DateFormat('dd-MM-yyyy').format(
                            missingPost.date,
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (missingPost.pet.image != null)
                      Container(
                        width: 125.0,
                        height: 125.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              missingPost.pet.image as String,
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(missingPost.pet.name as String, // user name
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.red[300] as Color,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.pets,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          petTypeToString(missingPost.pet.type),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // user phone
                  Row(
                    children: [
                      const Icon(
                        Icons.category,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          missingPost.pet.breed as String,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.palette,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          missingPost.pet.color as String,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.red[300] as Color,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          missingPost.pet.userId == null
                              ? 'Desconhecido'
                              : context
                                  .read<UserRepository>()
                                  .getUserById(missingPost.pet.userId as String)
                                  .name,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.email),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          missingPost.user.email,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // user phone
                  Row(
                    children: [
                      const Icon(Icons.phone),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          missingPost.user.phone as String,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          missingPost.user.address as String,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // user city
                  Row(
                    children: [
                      const Icon(Icons.location_city),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          missingPost.user.city as String,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: (missingPost.user.id == CurrentUser.currentUser.id)
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
