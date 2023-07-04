import 'dart:math';

import 'package:chat_app/components/comment.dart';
import 'package:chat_app/components/comment_button.dart';
import 'package:chat_app/components/delete_button.dart';
import 'package:chat_app/components/like_button.dart';
import 'package:chat_app/helper/timestamp_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GupShupPosts extends StatefulWidget {
  final String message;
  final String user;
  final String time;
  final String postId;
  final List<String> likes;
  const GupShupPosts({
    super.key,
    required this.message,
    required this.user,
    required this.time,
    required this.postId,
    required this.likes,
  });

  @override
  State<GupShupPosts> createState() => _GupShupPostsState();
}

class _GupShupPostsState extends State<GupShupPosts> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  // comment text editting controller
  final commentC = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  // like toggle
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    // access the document from the firebase
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);

    if (isLiked) {
      // if user like, so add the user email in Likes(ist) field
      postRef.update({
        'likes': FieldValue.arrayUnion([currentUser.email]),
      });
    } else {
      // if user unLike, so remove user email frome like field
      postRef.update({
        'likes': FieldValue.arrayRemove([currentUser.email]),
      });
    }
  }

  // add comment
  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection('User Posts')
        .doc(widget.postId)
        .collection('comments')
        .add({
      'commentText': commentText,
      'commentedBy': currentUser.email,
      'commentTime': Timestamp.now(),
    });
  }

  // show dialog for comment
  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Comment'),
        content: TextField(
          controller: commentC,
          decoration: const InputDecoration(hintText: 'enter a comment'),
        ),
        actions: [
          // save,post comment
          TextButton(
            onPressed: () {
              addComment(commentC.text);
              // pop the dialog
              Navigator.pop(context);
            },
            child: const Text('POST'),
          ),

          // cancel,discard comment
          TextButton(
            onPressed: () {
              // pop the dialog
              Navigator.pop(context);
              // clear textfield
              commentC.clear();
            },
            child: const Text('DISCARD'),
          ),
        ],
      ),
    );
  }

  // delete post function
  void deletePost() {
    if (widget.postId == currentUser.email) {
      // show dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Are you sure you want to delete this post..?'),
          actions: [
            // cancel
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),

            // delete
            TextButton(
              onPressed: () async {
                // get comments and delete them first
                final commentDocs = await FirebaseFirestore.instance
                    .collection("User Posts")
                    .doc(widget.postId)
                    .collection("comments")
                    .get();

                for (var doc in commentDocs.docs) {
                  await FirebaseFirestore.instance
                      .collection("User Posts")
                      .doc(widget.postId)
                      .collection("comments")
                      .doc(doc.id)
                      .delete();
                }

                // delete post
                await FirebaseFirestore.instance
                    .collection("User Posts")
                    .doc(widget.postId)
                    .delete()
                    .then(
                  (value) {
                    // pop the dialog
                    Navigator.pop(context);
                    // showing snakcbar msg
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green.shade600,
                        content: const Text(
                          'Delete Successfuly',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ).onError((error, stackTrace) {
                  // ignore: avoid_print
                  print(error.toString());
                });
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // message and user
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // group of texts
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // message
                  Text(
                    widget.message,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      letterSpacing: 1.5,
                    ),
                  ),
                  // gap
                  const SizedBox(
                    height: 10,
                  ),
                  // user email and time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.user,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const Text(" . "),
                      Text(
                        widget.time,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  )
                ],
              ),

              // delete icon
              DeleteButton(onTap: deletePost),
            ],
          ),

          // gap
          const SizedBox(height: 20),

          // buttons section

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // like area
              Column(
                children: [
                  // like button
                  LikeButton(isLiked: isLiked, onTap: toggleLike),

                  const SizedBox(height: 5),

                  // like count
                  Text(
                    widget.likes.length.toString(),
                    style: TextStyle(
                      color: Colors.primaries[Random().nextInt(5)],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 5),

              // comment area
              Column(
                children: [
                  // comment button
                  CommentButton(onTap: showCommentDialog),

                  const SizedBox(height: 5),

                  // comment count
                  Text(
                    '0',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // showing comments in box
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('User Posts')
                .doc(widget.postId)
                .collection('comments')
                .orderBy('commentTime', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              // show loading circle if nothing data yet
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                shrinkWrap:
                    true, //its good to shrink if use listview in another parent widget, nested list
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data!.docs.map((doc) {
                  // get the comment
                  final commentData = doc.data() as Map<String, dynamic>;

                  // return comments
                  return Comment(
                    text: commentData['commentText'],
                    user: commentData['commentedBy'],
                    time: formatData(commentData['commentTime']),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
