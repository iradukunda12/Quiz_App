import 'dart:convert';

import 'package:http/http.dart' as http;

class Constants {
  static String uri = 'http://localhost'; // Add this line

  static Future<int> getBackendPort() async {
    try {
      final response = await http.get(Uri.parse('$uri/getPort'));
      if (response.statusCode == 200) {
        final port = jsonDecode(response.body)['port'];
        return port;
      } else {
        // Handle the error
        print('Error: ${response.statusCode}');
        return 4000; // Use a default port or handle the error as needed
      }
    } catch (e) {
      print('Error: $e');
      return 4000; // Use a default port or handle the error as needed
    }
  }
}
