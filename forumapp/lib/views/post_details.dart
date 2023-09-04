import 'package:flutter/material.dart';
import 'package:forumapp/controllers/post_controller.dart';
import 'package:forumapp/models/post_model.dart';
import 'package:forumapp/views/widgets/input_widgets.dart';
import 'package:forumapp/views/widgets/post_data.dart';
import 'package:get/get.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key, required this.post});

  final PostModel post;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final TextEditingController _commentEditingController =
      TextEditingController();
  final PostController _postController = Get.put(PostController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _postController.getComments(widget.post.id);
    });

    super.initState();
  }

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
          SizedBox(
            width: double.infinity,
            height: 500,
            child: Obx(() {
              return _postController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _postController.comments.value.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_postController
                                  .comments.value[index].user!.name ??
                              'Cannot find username.'),
                          subtitle: Text(
                              _postController.comments.value[index].body ??
                                  'Cannot find comment.'),
                        );
                      });
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
              onPressed: () async {
                await _postController.createComment(
                    widget.post.id, _commentEditingController.text.trim());
                _commentEditingController.clear();
                _postController.getComments(widget.post.id);
              },
              child: const Text("Comment"))
        ]),
      ),
    );
  }
}
