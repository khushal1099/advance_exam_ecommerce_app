import 'package:advance_exam_ecommerce_app/Controller/quantity_provider.dart';
import 'package:advance_exam_ecommerce_app/Modal/product_model.dart';
import 'package:advance_exam_ecommerce_app/View/cartpage.dart';
import 'package:advance_exam_ecommerce_app/View/detailpge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Provider.of<QuantityProvider>(context, listen: false).getApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CartPage();
                }));
              },
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: Consumer<QuantityProvider>(
        builder: (BuildContext context, qp, Widget? child) {
          List<ProductModel> productList = qp.productlist;
          // CONVERT
          Map<Category, List<ProductModel>> categoryMap = {};
          productList.forEach((product) {
            if (!categoryMap.containsKey(product.category)) {
              categoryMap[product.category!] = [];
            }
            categoryMap[product.category]!.add(product);
          });

          return (productList.isEmpty)
              ? Stack(
                children: [
                  Container(
                      height: MediaQuery.sizeOf(context).height * 1,
                      width: MediaQuery.sizeOf(context).width * 1,
                      color: Colors.orange,
                    ),
                  Center(child: CircularProgressIndicator())
                ],
              )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: categoryMap.entries.map((entry) {
                      return CategorySection(
                          title: entry.key, productList: entry.value);
                    }).toList(),
                  ),
                );
        },
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final Category title;
  final List<ProductModel> productList;

  const CategorySection({
    required this.title,
    required this.productList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toString().split('.').last, // Extract category name from enum
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200, // Adjust the height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              var sample = productList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return DetailPage(
                          title: sample.title,
                          rating: double.parse("${sample.rating!.rate}"),
                          image: sample.image,
                          category: "${sample.category}",
                          price: sample.price,
                          description: sample.description);
                    },
                  ));
                },
                child: Container(
                  width: 150, // Adjust the width as needed
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        sample.image!,
                        height: 100,
                        width: 150,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 4),
                      Text(
                        sample.title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      RatingBarIndicator(
                        rating: double.parse("${sample.rating!.rate}"),
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 15.0,
                        direction: Axis.horizontal,
                      ),
                      Text("\$${sample.price}"),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
