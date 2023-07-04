import 'package:chat_app/components/my_text_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // user
    final User? currentUser = FirebaseAuth.instance.currentUser;
    // all users
    final userCollection = FirebaseFirestore.instance.collection('users');

    // function for editting field
    Future<void> editField(String field) async {
      String newValue = '';
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey.shade900,
          title: Text(
            'Edit $field',
            style: TextStyle(color: Colors.grey.shade200),
          ),
          content: TextField(
            autofocus: true,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: 'Edit $field',
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontWeight: FontWeight.bold,
              ),
            ),
            onChanged: (value) {
              newValue = value;
            },
          ),
          // buttons
          actions: [
            // cancel
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'CANCEL',
                style: TextStyle(color: Colors.blue.shade200),
              ),
            ),

            // save
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(newValue);
              },
              child: Text(
                'SAVE',
                style: TextStyle(color: Colors.blue.shade200),
              ),
            ),
          ],
        ),
      );

      // update the field in firebase
      if (newValue.trim().isNotEmpty) {
        // this condition means, update if there is something
        await userCollection.doc(currentUser!.email).update({
          field: newValue,
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          'PROFILE',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return ListView(
              children: [
                const SizedBox(height: 25),
                // user profile pic

                const Icon(
                  Icons.person_rounded,
                  size: 120,
                ),
                // user email
                Center(
                  child: Text(
                    currentUser.email.toString(),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                ),

                // user details
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Details',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        letterSpacing: 1.7,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                // user name
                MyTextBox(
                  onTap: () {
                    editField('username');
                  },
                  sectionTitle: 'UserName',
                  sectionDetail: userData['username'],
                ),

                // bio
                MyTextBox(
                  onTap: () {
                    editField('bio');
                  },
                  sectionTitle: 'Bio',
                  sectionDetail: userData['bio'],
                ),

                // user details
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'My Posts',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        letterSpacing: 1.7,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error is: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
