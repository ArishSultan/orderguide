import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;


class HttpService<File> {
  Dio dio = Dio();
  Future<File> getOne(String route,String savePath) async {
    try {
      final response = await Dio().download(route,savePath);
      print(response.data);
      return response.data;
    }
    on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }
      return e.response.data['message'];
    }

  }

}
