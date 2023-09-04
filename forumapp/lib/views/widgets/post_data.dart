import 'package:flutter/material.dart';
import 'package:forumapp/controllers/post_controller.dart';
import 'package:forumapp/models/post_model.dart';
import 'package:forumapp/views/post_details.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PostData extends StatefulWidget {
  const PostData({super.key, required this.post});

  final PostModel post;

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  final PostController _postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.post.user!.name!,
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          Text(widget.post.user!.email!,
              style: GoogleFonts.poppins(fontSize: 12)),
          const SizedBox(height: 10),
          Text(widget.post.content!),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    await _postController.likeAndDislike(widget.post.id);
                    _postController.getAllPosts();
                  },
                  icon: Icon(
                    Icons.thumb_up,
                    color: widget.post.liked! ? Colors.blue : Colors.black,
                  )),
              IconButton(
                  onPressed: () {
                    Get.to(() => PostDetails(post: widget.post));
                  },
                  icon: const Icon(Icons.message))
            ],
          )
        ],
      ),
    );
  }
}
