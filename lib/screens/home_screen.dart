import 'package:chat_app/helper/timestamp_format.dart';
import 'package:chat_app/screens/profile_screen.dart';
import 'package:chat_app/widgets/gupshup_posts.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/widgets/my_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // variables
  final currentUser = FirebaseAuth.instance.currentUser!;

  // text controller
  final TextEditingController textController = TextEditingController();

  // _________--------------FUNCTION----------------_______________

  // sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  // post messages
  void postMessage() {
    // first we check if Textfield is not empty then msg post otherwise not
    if (textController.text.isNotEmpty) {
      final Map<String, dynamic> data = {
        "userEmail": currentUser.email,
        "message": textController.text,
        "timeStamp": Timestamp.now(),
        "likes": [],
      };
      FirebaseFirestore.instance.collection("User Posts").add(data);
    }

    // clear text fields
    setState(() {
      textController.clear();
    });
  }

  // navigating to profile screen
  void goToProfile() {
    // pop the drawer
    Navigator.pop(context);

    // navigate to profile screen
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text(
          'GUP SHUP',
          style: TextStyle(
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
      ),
      drawer: MyDrawer(
        goToProfile: goToProfile,
        signOut: signOut,
      ),
      body: Center(
        child: Column(
          children: [
            // gup shup

            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("User Posts")
                    .orderBy(
                      "timeStamp",
                      descending: false,
                    )
                    .snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        // getting all posts
                        final post = snapshot.data!.docs[index];
                        return GupShupPosts(
                          message: post["message"],
                          user: post["userEmail"],
                          postId: post.id,
                          likes: List<String>.from(post['likes'] ?? []),
                          time: formatData(post["timeStamp"]),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error ${snapshot.error}"),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),

            // post message
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                        controller: textController,
                        hintText: 'Participate in Gup-Shup',
                        obscureText: false),
                  ),
                  IconButton(
                    onPressed: postMessage,
                    icon: Icon(
                      Icons.arrow_circle_up_outlined,
                      size: 30,
                      color: Colors.green.shade900,
                    ),
                  ),
                ],
              ),
            ),

            // logged in as (showing user email)
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                'Logged in as ${currentUser.email}',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
