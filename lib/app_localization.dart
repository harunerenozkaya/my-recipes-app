import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class DemoLocalizations {
  DemoLocalizations(this.locale);

  final Locale locale;

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'home_title': 'My Recipes',
      "favorite_recipes_title": "Favorite Recipes",
      "all_recipes_title": "All Recipes",
      "there_is_not_fv_rcp": "There is not any favorite recipe.",
      "there_is_not_rcp":
          "There is not any recipe.\nYou can add new recipes with the button in the \nbottom right corner.",
      "categories_title": "Categories",
      "home": "Home",
      "practical": "Practical",
      "soup": "Soup",
      "meatmeal": "Meat Meal",
      "vegetable": "Vegetable",
      "legumes": "Legumes",
      "salad": "Salad",
      "pastry": "Pastry",
      "desert": "Desert",
      "snack": "Snack",
      "appetizer": "Appetizer",
      "drink": "Drink",
      "abort": "Abort",
      "okay": "Okay",
      "add_new_recipe_title": "Add New Recipe",
      "photos_title": "Photos",
      "add_photo": "Add Photo",
      "ingredients_title": "Ingredients",
      "add_ingredient": "Add Ingredient",
      "steps_title": "Steps",
      "add_steps": "Add Step",
      "duration": "Duration",
      "category": "Category",
      "price": "Amount",
      "gallery": "Gallery",
      "camera": "Camera",
      "alert_add_new_ing": "Add New Ingredient",
      "ingredient_name": "Ingredient Name",
      "ingredient_amount": "Amount",
      "cancel": "Cancel",
      "add": "Add",
      "choose": "Choose",
      "choose_unit": "Choose Unit",
      "ingredient_name_cant_blank": "Ingredient name or amount can't be blank.",
      "amount": "Amount",
      "alert_add_new_step": "Add New Step",
      "step_description": "Step Descruption",
      "step_name_cant_blank": "Step descruption can't be blank.",
      "how_much_cost": "How much does it cost ? ",
      "what_category": "What is the category?",
      "how_much_take_time": "How much does it take to ready?",
      "spoon": "spoon",
      "glass": "glass",
      "what_recipe_name": "What is your recipe name?",
      "recipe_name": "Recipe Name",
      "recipe_added_succesfully": "Your recipe has added succesfully",
      "please_add_ing": "Please add any ingredient.",
      "please_add_step": "Please add any step.",
      "please_add_duration": "Please define duration",
      "please_add_category": "Please define a category for recipe",
      "please_add_price": "Please define a amount",
      "fav_before_category_recipe": "There is not any favorite",
      "fav_after_category_recipe": "recipe",
      "before_category_recipe": "There is not any",
      "after_category_recipe":
          "recipe. \nYou can add new recipes with the button in the \nbottom right corner.",
      "before_category_title_fav": "My Favorite",
      "after_category_title_fav": "Recipes",
      "before_category_title": "All",
      "after_category_title": "Recipes",
      "alert_recipe_delete": "This recipe will delete !\nAre you sure ?",
      "delete": "Delete",
    },
    'tr': {
      'home_title': 'Benim Tariflerim',
      "favorite_recipes_title": "Favori Tariflerim",
      "all_recipes_title": "Tüm Tarifler",
      "there_is_not_fv_rcp": "Henüz hiç favori tarif yok.",
      "there_is_not_rcp":
          "Henüz hiç tarif yok.\n Sağ alt köşedeki butona tıklayarak \nyeni bir tarif ekleyebilirsin.",
      "categories_title": "Kategoriler",
      "home": "Ana Sayfa",
      "practical": "Pratik",
      "soup": "Çorba",
      "meatmeal": "Et Yemeği",
      "vegetable": "Sebze",
      "legumes": "Baklagil",
      "salad": "Salata",
      "pastry": "Hamur İşi",
      "desert": "Tatlı",
      "snack": "Atıştırmalık",
      "appetizer": "Meze",
      "drink": "İçecek",
      "abort": "İptal",
      "okay": "Tamam",
      "add_new_recipe_title": "Yeni Tarif Ekle",
      "photos_title": "Fotoğraflar",
      "add_photo": "Fotoğraf Ekle",
      "ingredients_title": "Malzemeler",
      "add_ingredient": "Malzeme   Ekle",
      "steps_title": "Adımlar",
      "add_steps": "Adım Ekle",
      "duration": "Süre",
      "category": "Kategori",
      "price": "Maliyet",
      "gallery": "Galeri",
      "camera": "Kamera",
      "alert_add_new_ing": "Yeni Malzeme Ekle",
      "ingredient_name": "Malzeme Adı",
      "ingredient_amount": "Miktar",
      "cancel": "İptal",
      "add": "Ekle",
      "choose": "Seç",
      "choose_unit": "Birimi Seç",
      "ingredient_name_cant_blank": "Malzeme adı veya miktarı boş bırakılamaz.",
      "amount": "Miktar",
      "alert_add_new_step": "Yeni Adım Ekle",
      "step_description": "Adım Açıklaması",
      "step_name_cant_blank": "Adım açıklaması boş bırakılamaz.",
      "how_much_cost": "Bu tarifin maliyeti ne kadar ? ",
      "what_category": "Tarifin kategorisi nedir?",
      "how_much_take_time": "Bu tarifi yapmak ne kadar vakit alıyor?",
      "spoon": "kaşık",
      "glass": "bardak",
      "what_recipe_name": "Tarifin adı nedir?",
      "recipe_name": "Tarif Adı",
      "recipe_added_succesfully": "Tarifin başarıyla eklendi",
      "please_add_ing": "Lütfen en az bir tane malzeme ekleyin",
      "please_add_step": "Lütfen en az bir tane adım ekleyin",
      "please_add_duration": "Lütfen süreyi girin",
      "please_add_category": "Lütfen bir kategori belirleyin",
      "please_add_price": "Lütfen maliyeti girin",
      "fav_before_category_recipe": "Hiç favori",
      "fav_after_category_recipe": "tarifi yok",
      "before_category_recipe": "Henüz hiç",
      "after_category_recipe":
          "tarifi yok. \nSağ alt köşedeki butona tıklayarak \nyeni bir tarif ekleyebilirsin.",
      "before_category_title_fav": "Favori",
      "after_category_title_fav": "Tariflerim",
      "before_category_title": "Tüm",
      "after_category_title": "Tariflerim",
      "alert_recipe_delete": "Bu tarif silinecek !\nEmin misin ?",
      "delete": "Sil",
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode][key];
  }
}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'tr'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<DemoLocalizations>(DemoLocalizations(locale));
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
