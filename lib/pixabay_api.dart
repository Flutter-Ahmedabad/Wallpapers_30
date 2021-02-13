import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpapers_30/images_response.dart';

class PixabayApi {
  Future<ImagesResponse> getImages() async {
    try {
      http.Response response = await http.get(
          'https://pixabay.com/api/?key=20262887-d61cf9ef053e27929250648b3');
      print('Status code ${response.statusCode}');
      // print(response.body ?? "No response");
      if (response.statusCode == 200) {
        // var jsonData = json.decode(response.body);
        // print("Total Hits = ${jsonData['totalHits']}");
        final ImagesResponse imagesResponse =
            imagesResponseFromJson(response.body);
        return imagesResponse;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
