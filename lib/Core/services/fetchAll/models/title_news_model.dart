class TitleNewsModel {
  List<Post> posts;
  List<Slider> sliders;

  TitleNewsModel({required this.posts, required this.sliders});

  factory TitleNewsModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> postsList = json['posts'];
    List<dynamic> slidersList = json['sliders'];

    List<Post> posts =
        postsList.map((postJson) => Post.fromJson(postJson)).toList();
    List<Slider> sliders =
        slidersList.map((sliderJson) => Slider.fromJson(sliderJson)).toList();

    return TitleNewsModel(posts: posts, sliders: sliders);
  }
}

class Post {
  int id;
  int categoryId;
  String title;
  String img;
  int dateTime;

  Post({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.img,
    required this.dateTime,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      categoryId: json['category_id'],
      title: json['title'],
      img: json['img'],
      dateTime: json['date_time'],
    );
  }
}

class Slider {
  int id;
  String title;
  String img;
  int dateTime;
  int categoryId;
  String categoryTitle;
  Category category;

  Slider({
    required this.id,
    required this.title,
    required this.img,
    required this.dateTime,
    required this.categoryId,
    required this.categoryTitle,
    required this.category,
  });

  factory Slider.fromJson(Map<String, dynamic> json) {
    return Slider(
      id: json['id'],
      title: json['title'],
      img: json['img'],
      dateTime: json['date_time'],
      categoryId: json['category_id'],
      categoryTitle: json['category_title'],
      category: Category.fromJson(json['category']),
    );
  }
}

class Category {
  int id;
  String slug;
  String title;
  int parentId;

  Category({
    required this.id,
    required this.slug,
    required this.title,
    required this.parentId,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      slug: json['slug'],
      title: json['title'],
      parentId: json['parent_id'],
    );
  }
}
