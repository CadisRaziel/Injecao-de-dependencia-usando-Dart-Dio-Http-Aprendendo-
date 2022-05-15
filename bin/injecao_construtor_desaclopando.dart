import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

//! Injeção de dependencia por construtor (forma mais utilizada)!!
//! porém agora vamos criar uma interface e yn get para desaclopar ainda mais o Dio da classe 'Product'
void main() async {
  final dio = Dio();
  final dioSercice = DioService(dio: dio);

  final client = http.Client();
  final httpService = HttpService(client: client);

  //*Olha como eu posso alternar entre DIO e HTTP
  final product = Product(service: dioSercice);
  final product2 = Product(service: httpService);

  final list = await product2.fetchProduct();
  print(list);
}

abstract class IHttpService {
  Future<dynamic> get(String url);
}

//!==============================================================\\
class DioService implements IHttpService {
  final Dio dio;
  DioService({
    required this.dio,
  });
  @override
  Future get(String url) async => (await dio.get(url)).data;
}

class HttpService implements IHttpService {
  final http.Client client;
  HttpService({
    required this.client,
  });
  @override
  Future get(String url) async =>
      jsonDecode((await client.get(Uri.parse(url))).body);
}
//!==============================================================\\

class Product {
  final IHttpService service;
  Product({
    required this.service,
  });

  Future<List> fetchProduct() async {
    final response =
        await service.get('https://jsonplaceholder.typicode.com/todos/');
    return response;
  }
}
