import 'dart:convert';
import 'package:advance_exam_ecommerce_app/Modal/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QuantityProvider extends ChangeNotifier {
  List<ProductModel> productlist = [];
  List<ProductModel> cartlist = [];
  String? cartListJson = "";

  Future<void> getApi() async {
    var future = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    productlist = productModelFromJson(future.body);
    notifyListeners();
  }

  void addProduct(int index) {
    cartlist[index].quantity = (cartlist[index].quantity ?? 1) + 1;
    saveCartList();
    notifyListeners();
  }

  void removeProduct(int index) {
    if (cartlist[index].quantity != null && cartlist[index].quantity! > 1) {
      cartlist[index].quantity = cartlist[index].quantity! - 1;
      saveCartList();
      notifyListeners();
    }
  }

  void deleteProduct(int index) {
    cartlist.removeAt(index);
    saveCartList();
    notifyListeners();
  }

  void loadCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartlistJson = prefs.getString('cartlist');
    if (cartlistJson != null) {
      try {
        List<dynamic> decodedList = jsonDecode(cartlistJson);
        cartlist =
            decodedList.map((item) => ProductModel.fromJson(item)).toList();
      } catch (e) {
        // Handle JSON decoding error
        print("Error decoding cartlist JSON: $e");
      }
    }
    notifyListeners();
  }

  void saveCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartListJson = jsonEncode(cartlist.map((e) => e.toJson()).toList());
    prefs.setString("cartlist", cartListJson!);
    notifyListeners();
  }
}
