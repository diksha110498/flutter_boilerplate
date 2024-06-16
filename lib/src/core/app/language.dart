import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:collection';

class Language{

  Language();

  Map<String, String> localizedValues = HashMap<String, String>();
  Future<void> loadAppLanguage() async {

    String jsonResult =  await loadAsset();
    Map<String, dynamic> mappedJson = json.decode(jsonResult);
    //print(mappedJson);
    localizedValues = mappedJson.map((key, value) {
      return MapEntry(key, value.toString());
    });
    //print("localizedValues = ${getTranslated('labelStudent')}");
  }

   String getTranslated(String? key) {
    //print("localizedValues = ${localizedValues('labelStudent')}");
    return this.localizedValues[key]!;
  }


  Future<String> loadAsset() async {
    //print("\nselectedLangauge = ${selectedLangauge}");
    return await rootBundle.loadString('assets/i10n/en.json');
  }

}
