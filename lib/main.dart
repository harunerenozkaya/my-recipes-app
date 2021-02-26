import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myRecipes/ui/add_new_recipe_page.dart';
import 'package:myRecipes/ui/category_page.dart';
import 'package:myRecipes/ui/edit_recipe_page.dart';
import 'package:myRecipes/ui/home_page.dart';
import './ui/recipe_detail_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/recipe.dart';
import 'package:flutter/services.dart';
import 'app_localization.dart';

void main() async {
  await Hive.initFlutter("db");
  Hive.registerAdapter<Recipe>(RecipeAdapter());
  await Hive.openBox("recipes");
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // Route ile veri gönderme
  // ignore: missing_return
  MaterialPageRoute generateRoute(RouteSettings settings) {
    List args = settings.name.split("/");
    switch (args[0]) {
      case "categoryPage":
        // ignore: unrelated_type_equality_checks
        if (args[2] == "home") {
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
      case "editPage":
        return MaterialPageRoute(builder: (context) => EditRecipePage(args[1]));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sadece dikey kullanım
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      routes: {
        "/": (context) => MyHomePage(),
        "/addNewRecipe": (context) => AddNewRecipePage()
      },
      onGenerateRoute: (settings) => generateRoute(settings),
      theme: ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
        appBarTheme: AppBarTheme(
            color: Color.fromARGB(255, 232, 147, 148),
            iconTheme: IconThemeData(color: Colors.white)),
        accentColor: Color.fromARGB(255, 232, 147, 148),
        primaryColor: Color.fromARGB(255, 232, 147, 148),
        primaryColorDark: Color.fromARGB(255, 232, 147, 148),
        primaryTextTheme: TextTheme(
          headline6: TextStyle(color: Colors.white),
        ),
        buttonColor: Color.fromARGB(255, 232, 147, 148),
      ),
      localizationsDelegates: [
        const DemoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('tr', ''),
      ],
      title: 'My Recipes',
      debugShowCheckedModeBanner: false,
    );
  }
}
