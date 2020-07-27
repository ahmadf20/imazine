// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

List<Category> categoriesFromJson(List str) =>
    List<Category>.from((str).map((x) => Category.fromJson(x)));

class Category {
  Category({
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

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        count: json["count"],
        description: json["description"],
        link: json["link"],
        name: json["name"],
        slug: json["slug"],
        taxonomy: json["taxonomy"],
      );
}
