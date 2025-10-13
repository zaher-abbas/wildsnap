import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wildsnap/services/post_service.dart';

class NewPostHome extends StatefulWidget {
  const NewPostHome({Key? key}) : super(key: key);

  @override
  _NewPostHomeState createState() => _NewPostHomeState();
}

class _NewPostHomeState extends State<NewPostHome> {
  final PostService _postService = PostService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _postService.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final posts = snapshot.data!.docs;
          return Column(
            children: posts.map((post) {
              return Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    if (Theme.of(context).brightness == Brightness.dark)
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(0, 4),
                      ),
                  ],
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Card(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.amber[200],
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        post['imageUrl'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 400,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Animal: ',
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: post['animalName']),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Localisations: ',
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: post['location']),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Description: ',
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: post['description']),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
