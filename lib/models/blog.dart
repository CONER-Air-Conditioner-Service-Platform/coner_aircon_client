import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  int bId;
  String image;
  String title;
  String url;

  Blog({
    required this.bId,
    required this.image,
    required this.title,
    required this.url,
  });
  // 파이어베이스에서 가져온 Map타입을 변경
  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(
      bId: map['bId'],
      image: map['image'],
      title: map['title'],
      url: map['url'],
    );
  }

  //파이어베이스에서 가져온 documentSnapshot을 변경
  factory Blog.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return Blog(
      bId: documentSnapshot['bId'],
      image: documentSnapshot['image'],
      title: documentSnapshot['title'],
      url: documentSnapshot['url'],
    );
  }
}
