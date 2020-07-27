// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

List<Post> postFromJson(List str) =>
    List<Post>.from((str).map((x) => Post.fromJson(x)));

class Post {
  Post({
    this.id,
    this.date,
    this.modified,
    this.slug,
    this.title,
    this.content,
    this.excerpt,
    this.tags,
    this.jetpackFeaturedMediaUrl,
    this.embedded,
  });

  int id;
  DateTime date;
  DateTime modified;
  String slug;
  Title title;
  Content content;
  Content excerpt;
  List<dynamic> tags;
  String jetpackFeaturedMediaUrl;
  Embedded embedded;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        modified: DateTime.parse(json["modified"]),
        slug: json["slug"],
        title: Title.fromJson(json["title"]),
        content: Content.fromJson(json["content"]),
        excerpt: Content.fromJson(json["excerpt"]),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        jetpackFeaturedMediaUrl: json["jetpack_featured_media_url"],
        embedded: json["_embedded"] == null
            ? null
            : Embedded.fromJson(json["_embedded"]),
      );
}

class Content {
  Content({
    this.rendered,
    this.protected,
  });

  String rendered;
  bool protected;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        rendered: json["rendered"],
        protected: json["protected"],
      );

  Map<String, dynamic> toJson() => {
        "rendered": rendered,
        "protected": protected,
      };
}

class Embedded {
  Embedded({
    this.author,
    this.wpFeaturedmedia,
    this.wpTerm,
  });

  List<Author> author;
  List<WpFeaturedmedia> wpFeaturedmedia;
  List<List<WpTerm>> wpTerm;

  factory Embedded.fromJson(Map<String, dynamic> json) => Embedded(
        author:
            List<Author>.from(json["author"].map((x) => Author.fromJson(x))),
        wpFeaturedmedia: json["wp:featuredmedia"] == null
            ? null
            : List<WpFeaturedmedia>.from(json["wp:featuredmedia"]
                .map((x) => WpFeaturedmedia.fromJson(x))),
        wpTerm: List<List<WpTerm>>.from(json["wp:term"]
            .map((x) => List<WpTerm>.from(x.map((x) => WpTerm.fromJson(x))))),
      );
}

class Author {
  Author({
    this.id,
    this.name,
    this.url,
    this.description,
    this.link,
    this.slug,
    this.avatarUrls,
  });

  int id;
  String name;
  String url;
  String description;
  String link;
  String slug;
  Map<String, String> avatarUrls;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        description: json["description"],
        link: json["link"],
        slug: json["slug"],
        avatarUrls: Map.from(json["avatar_urls"])
            .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "description": description,
        "link": link,
        "slug": slug,
        "avatar_urls":
            Map.from(avatarUrls).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class WpFeaturedmedia {
  WpFeaturedmedia({
    this.id,
    this.date,
    this.link,
    this.altText,
    this.mediaType,
    this.mimeType,
    this.mediaDetails,
    this.sourceUrl,
  });

  int id;
  DateTime date;
  String link;
  String altText;
  String mediaType;
  String mimeType;
  MediaDetails mediaDetails;
  String sourceUrl;

  factory WpFeaturedmedia.fromJson(Map<String, dynamic> json) =>
      WpFeaturedmedia(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        link: json["link"],
        altText: json["alt_text"],
        mediaType: json["media_type"],
        mimeType: json["mime_type"],
        // mediaDetails: json["media_details"] == null
        //     ? null
        //     : MediaDetails.fromJson(json["media_details"]),
        sourceUrl: json["source_url"],
      );
}

class MediaDetails {
  MediaDetails({
    this.width,
    this.height,
    this.sizes,
  });

  int width;
  int height;
  String file;
  Sizes sizes;

  factory MediaDetails.fromJson(Map<String, dynamic> json) => MediaDetails(
        width: json["width"],
        height: json["height"],
        sizes: Sizes.fromJson(json["sizes"]),
      );
}

class Sizes {
  Sizes({
    this.thumbnail,
    this.medium,
    this.mediumLarge,
    this.large,
  });

  Large thumbnail;
  Large medium;
  Large mediumLarge;
  Large large;

  factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
        thumbnail: Large.fromJson(json["thumbnail"]),
        medium: Large.fromJson(json["medium"]),
        mediumLarge: Large.fromJson(json["medium_large"]),
        large: Large.fromJson(json["large"]),
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail.toJson(),
        "medium": medium.toJson(),
        "medium_large": mediumLarge.toJson(),
        "large": large.toJson(),
      };
}

class Large {
  Large({
    this.file,
    this.width,
    this.height,
    this.mimeType,
    this.sourceUrl,
  });

  String file;
  int width;
  int height;
  String mimeType;
  String sourceUrl;

  factory Large.fromJson(Map<String, dynamic> json) => Large(
        file: json["file"],
        width: json["width"],
        height: json["height"],
        mimeType: json["mime_type"],
        sourceUrl: json["source_url"],
      );

  Map<String, dynamic> toJson() => {
        "file": file,
        "width": width,
        "height": height,
        "mime_type": mimeType,
        "source_url": sourceUrl,
      };
}

class WpTerm {
  WpTerm({
    this.id,
    this.link,
    this.name,
    this.slug,
    this.taxonomy,
  });

  int id;
  String link;
  String name;
  String slug;
  String taxonomy;

  factory WpTerm.fromJson(Map<String, dynamic> json) => WpTerm(
        id: json["id"],
        link: json["link"],
        name: json["name"],
        slug: json["slug"],
        taxonomy: json["taxonomy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "name": name,
        "slug": slug,
        "taxonomy": taxonomy,
      };
}

class Title {
  Title({
    this.rendered,
  });

  String rendered;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        rendered: json["rendered"],
      );

  Map<String, dynamic> toJson() => {
        "rendered": rendered,
      };
}
