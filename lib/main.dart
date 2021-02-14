import 'package:flutter/material.dart';
import 'package:myRecipes/ui/add_new_recipe_page.dart';
import 'package:myRecipes/ui/category_page.dart';
import 'package:myRecipes/ui/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Route ile veri gönderme
  MaterialPageRoute generateRoute(RouteSettings settings) {
    List args = settings.name.split("/");
    switch (args[0]) {
      //Menüden ana sayfa seçildiyse ana sayfaya yönlendir diğerleri seçildiyse kendi sayfasına yönlendir.
      /*
        Niyeyse bu şekilde yazınca çalışmıyo
      
        args[1] == "Home")
            ? MaterialPageRoute(builder: (context) => MyHomePage())
            : MaterialPageRoute(
                builder: (context) => CategoryPage(args[1], args[2]));
                
                */

      case "categoryPage":
        if (args[1] == "Home") {
          return MaterialPageRoute(builder: (context) => MyHomePage());
        } else {
          return MaterialPageRoute(
              builder: (context) => CategoryPage(args[1], args[2]));
        }
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
