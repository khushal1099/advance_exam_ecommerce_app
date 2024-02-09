// import 'package:advance_exam_ecommerce_app/Controller/quantity_provider.dart';
// import 'package:advance_exam_ecommerce_app/Modal/product_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
//
// class ApiHelper {
//   static ApiHelper obj = ApiHelper._();
//
//   ApiHelper._();
//
//   factory ApiHelper() {
//     return obj;
//   }
//
//   Future<String> getApi() async {
//     var future = await http.get(
//         Uri.parse("https://fakestoreapi.com/products"));
//     productlist = productModelFromJson(future.body);
//     return future.body;
//   }
// }