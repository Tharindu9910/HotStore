import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:hot_store1/models/product.dart';

class APIManager {
  var dio = Dio();

  static Future<List<Product>> fetchProducts() async {
    Response response = await Dio().get('https://fakestoreapi.com/products');
    return (response.data as List).map((x) => Product.fromJson(x)).toList();
  }

  static Future<Product> fetchProduct(int id) async {
    Response response =
        await Dio().get('https://fakestoreapi.com/products/$id');
    return Product.fromJson(response.data);
  }

  static Future<List<String>> fetchCategories() async {
    Response response =
        await Dio().get('https://fakestoreapi.com/products/categories');
    List<String> categories =
        (response.data as List).map((e) => e.toString()).toList();
    return categories;
  }
}
