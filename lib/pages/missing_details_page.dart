import 'package:flutter/material.dart';
import 'package:projeto/models/missing_post.dart';

class MissingDetailsPage extends StatefulWidget {
  MissingPost missingPost;

  MissingDetailsPage({super.key, required this.missingPost});

  @override
  State<MissingDetailsPage> createState() => _MissingDetailsPageState();
}

class _MissingDetailsPageState extends State<MissingDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: Text(widget.missingPost.description),
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
                  child: Image.asset(
                    widget.missingPost.pet.image as String,
                    width: 100,
                    height: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.missingPost.pet.name as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        widget.missingPost.pet.breed as String,
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
    );
  }
}
