import 'package:flutter/material.dart';
import 'package:get/get.dart';
final List locale = [
  {'name': 'English', 'locale': const Locale('en', 'US')},
  {'name': 'Español', 'locale': const Locale('es', 'SP')},
];
final Rx<Locale> currentLocale =
Rx<Locale>(const Locale('en', 'US'));
buildLanguageDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title:  Text('Choose Your Language'.tr),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Text(locale[index]['name']),
                      onTap: () {
                        print(locale[index]['name']);
                        updateLanguage(locale[index]['locale']);
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.blue,
                  );
                },
                itemCount: locale.length),
          ),
        );
      });
}
updateLanguage(Locale locale) {
  Get.back();
  Get.updateLocale(locale);
  currentLocale.value = locale;

  // Update the radio size based on the selected language.

}