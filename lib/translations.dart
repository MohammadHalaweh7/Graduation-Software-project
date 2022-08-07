import 'package:get/get.dart';
import 'package:udemy_flutter/utils/languages/ar.dart';
import 'package:udemy_flutter/utils/languages/en.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
      };
}
