import 'package:hive/hive.dart';

part 'recipe.g.dart';

@HiveType(typeId: 1)
class Recipe {
  @HiveField(0)
  String recipeId;
  @HiveField(1)
  List<String> imagesPath;
  @HiveField(2)
  List<Map> ingredients = [];
  @HiveField(3)
  List<String> steps = [];
  @HiveField(4)
  String recipeDuration;
  @HiveField(5)
  String category;
  @HiveField(6)
  String price;

  Recipe(this.recipeId, this.imagesPath, this.ingredients, this.steps,
      this.recipeDuration, this.category, this.price);

  /*@override
  String toString() {
    print("$recipeId , $price");
  }*/
}
