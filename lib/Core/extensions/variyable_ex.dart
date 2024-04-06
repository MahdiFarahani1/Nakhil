import 'package:nakhil/Core/utils/category.dart';

extension IntEx on int {
  String categoryCheker() {
    String result = categoryId[this] ?? "الاخبار";
    return result;
  }
}
