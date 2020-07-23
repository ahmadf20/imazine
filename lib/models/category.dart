// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

class Post {
  Post({
    this.id,
    this.count,
    this.description,
    this.link,
    this.name,
    this.slug,
    this.taxonomy,
  });

  int id;
  int count;
  String description;
  String link;
  String name;
  String slug;
  String taxonomy;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        count: json["count"],
        description: json["description"],
        link: json["link"],
        name: json["name"],
        slug: json["slug"],
        taxonomy: json["taxonomy"],
      );
}
