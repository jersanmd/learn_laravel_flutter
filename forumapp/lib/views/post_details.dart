import 'package:flutter/material.dart';
import 'package:forumapp/models/post_model.dart';
import 'package:forumapp/views/widgets/input_widgets.dart';
import 'package:forumapp/views/widgets/post_data.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key, required this.post});

  final PostModel post;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final TextEditingController _commentEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.post.content!),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          PostData(post: widget.post),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 500,
            child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Text('Comment');
                }),
          ),
          InputWidgets(
              hintText: "Write a comment.",
              controller: _commentEditingController,
              obscureText: false),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
              onPressed: () {},
              child: const Text("Comment"))
        ]),
      ),
    );
  }
}
