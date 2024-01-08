import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<Map<String, dynamic>> locales = [
  {'name': 'English', 'locale': const Locale('en', 'US')},
  {
    'name': 'Español',
    'locale': const Locale('es', 'ES')
  }, // Corrected 'SP' to 'ES'
];

final Rx<Locale> currentLocale = Rx<Locale>(const Locale('en', 'US'));

Future<void> buildLanguageDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Choose Your Language'.tr),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Text(locales[index]['name']),
                  onTap: () {
                    updateLanguage(locales[index]['locale']);
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.blue,
              );
            },
            itemCount: locales.length,
          ),
        ),
      );
    },
  );
}

Future<void> updateLanguage(Locale locale) async {
  // print("${locale}");
  Get.back();
  Get.updateLocale(locale);
  currentLocale.value = locale;

  // Save selected language to shared preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('languageCode', locale.languageCode);
  await prefs.setString('countryCode', locale.countryCode!);
}


