import 'package:dio/dio.dart';

//! Injeção de dependencia por construtor (forma mais utilizada)!!
void main() async {
  final dio = Dio();
  final product = Product(dio: dio);

  final list = await product.fetchProduct();
  print(list);
}

class Product {
  final Dio dio;
  Product({
    required this.dio,
  });

  Future<List> fetchProduct() async {
    final response =
        await dio.get('https://jsonplaceholder.typicode.com/todos/');
    return response.data;
  }
}
