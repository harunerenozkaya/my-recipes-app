import 'package:flutter/material.dart';
import 'package:myRecipes/ui/add_new_recipe_page.dart';
import 'package:myRecipes/ui/category_page.dart';
import 'package:myRecipes/ui/home_page.dart';
import './ui/recipe_detail_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/recipe.dart';

void main() async {
  await Hive.initFlutter("db");
  Hive.registerAdapter<Recipe>(RecipeAdapter());
  await Hive.openBox("recipes");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Route ile veri gönderme
  // ignore: missing_return
  MaterialPageRoute generateRoute(RouteSettings settings) {
    List args = settings.name.split("/");
    switch (args[0]) {
      case "categoryPage":
        if (args[1] == "Home") {
          return MaterialPageRoute(
            builder: (context) => MyHomePage(),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => CategoryPage(
              args[1],
              args[2],
            ),
          );
        }
        break;
      case "detailPage":
        return MaterialPageRoute(builder: (context) => RecipeDetail(args[1]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => MyHomePage(),
        "/addNewRecipe": (context) => AddNewRecipePage()
      },
      onGenerateRoute: (settings) => generateRoute(settings),
      theme: ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 252, 242, 249),
        ),
        appBarTheme: AppBarTheme(
          color: Color.fromARGB(255, 235, 172, 215),
        ),
      ),
      title: 'My Recipes',
      debugShowCheckedModeBanner: false,
    );
  }
}
