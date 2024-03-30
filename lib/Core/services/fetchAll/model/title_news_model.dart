class TitleNewsModel {
  List<Posts>? posts;
  List<Sliders>? sliders;

  TitleNewsModel({this.posts, this.sliders});

  TitleNewsModel.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
    if (json['sliders'] != null) {
      sliders = <Sliders>[];
      json['sliders'].forEach((v) {
        sliders!.add(new Sliders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    if (this.sliders != null) {
      data['sliders'] = this.sliders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Posts {
  int? id;
  int? categoryId;
  String? title;
  String? img;
  int? dateTime;

  Posts({this.id, this.categoryId, this.title, this.img, this.dateTime});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    img = json['img'];
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['img'] = this.img;
    data['date_time'] = this.dateTime;
    return data;
  }
}

class Sliders {
  int? id;
  String? title;
  String? img;
  int? dateTime;
  int? categoryId;
  String? categoryTitle;
  Category? category;

  Sliders(
      {this.id,
      this.title,
      this.img,
      this.dateTime,
      this.categoryId,
      this.categoryTitle,
      this.category});

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    img = json['img'];
    dateTime = json['date_time'];
    categoryId = json['category_id'];
    categoryTitle = json['category_title'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['img'] = this.img;
    data['date_time'] = this.dateTime;
    data['category_id'] = this.categoryId;
    data['category_title'] = this.categoryTitle;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? slug;
  String? title;
  int? parentId;

  Category({this.id, this.slug, this.title, this.parentId});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    parentId = json['parent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['parent_id'] = this.parentId;
    return data;
  }
}
