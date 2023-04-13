import 'package:flutter/services.dart';

Future<String> googleAPIKey() async {
  return (await rootBundle.loadString('assets/.keys/GOOGLE_API_KEY')).trim();
}
