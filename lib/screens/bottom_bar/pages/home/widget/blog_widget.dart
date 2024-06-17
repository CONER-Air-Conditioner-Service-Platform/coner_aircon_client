import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coner_client/screens/webview/webview_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../models/blog.dart';
import '../../../../../theme/app_text_styles.dart';

class BlogWidget extends StatelessWidget {
  const BlogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> requestStream =
        FirebaseFirestore.instance.collection("blog").orderBy("bId", descending: true).snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: requestStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const SizedBox();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          List<Blog> blogs = [];
          for (DocumentSnapshot docSnapshot in snapshot.data!.docs) {
            Map<String, dynamic> data = docSnapshot.data()! as Map<String, dynamic>;
            if (docSnapshot.data() != null) {
              blogs.add(Blog.fromMap(data));
            }
          }
          return Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "코너가 알려주는 에어컨 정보",
                    style: AppTextStyles.h2Bold,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 20),
                      for (Blog blog in blogs) ...[
                        itemCard(context, blog),
                        SizedBox(width: 12),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        });
  }

  Widget itemCard(BuildContext context, Blog blog) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WebviewScreen(url: blog.url, title: blog.title)),
        );
      },
      child: SizedBox(
        width: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(blog.image, fit: BoxFit.contain),
              ),
            ),
            SizedBox(height: 4),
            Container(
              child: Text(
                blog.title,
                style: AppTextStyles.b1Bold,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
