import 'package:dio/dio.dart';

//! Injeção de dependencia por parametro !!
//! Estou passando o dio no 'fetchProduct' por parametro

void main() async {
  final product = Product();
  final dio = Dio();
  final list = await product.fetchProduct(dio);
  print(list);
}

class Product {
  //? passando por parametro eu consigo desaclopar o Dio um pouco
  Future<List> fetchProduct(Dio dio) async {
    final response =
        await dio.get('https://jsonplaceholder.typicode.com/todos/');
    return response.data;
  }
}
