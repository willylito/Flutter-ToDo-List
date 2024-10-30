import 'package:dio/dio.dart';

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add a custom header to the request
          return handler.next(options);
        },
      ),
    );

    return dio;
  }
}

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<Response> getToDoById({required int id}) async {
    var response =
        await dio.get('https://jsonplaceholder.typicode.com/todos/$id');
    return response;
  }
}
