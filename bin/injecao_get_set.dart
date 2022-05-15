import 'package:dio/dio.dart';

//! Injeção de dependencia por get e set !!
//! Repare que eu estancio o Dio dentro da classe product, com isso poderia facilmente trocar pra um HTTP
void main() async {
  final dio = Dio();
  final product = Product();
  product.dio = dio;
  final list = await product.fetchProduct();
  print(list);
}

class Product {
  var dio = Dio();
  Future<List> fetchProduct() async {
    final response =
        await dio.get('https://jsonplaceholder.typicode.com/todos/');
    return response.data;
  }
}
