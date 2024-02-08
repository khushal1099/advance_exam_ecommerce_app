import 'package:advance_exam_ecommerce_app/Modal/api_helper.dart';
import 'package:advance_exam_ecommerce_app/View/detailpge.dart';
import 'package:advance_exam_ecommerce_app/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    ApiHelper().getApi();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: productlist.length,
        itemBuilder: (context, index) {
          var product = productlist[index];
          return Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DetailPage(
                        title: product.title,
                        rating: double.parse(
                          product.rating!.rate.toString(),
                        ),
                        image: product.image,
                        category: product.category.toString(),
                        description: product.description,
                        price: product.price,
                      );
                    },
                  ),
                );
              },
              child: Container(
                height: 400,
                width: 500,
                color: Colors.black12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      product.image ?? "",
                      height: 100,
                      width: 100,
                    ),
                    Text(
                      product.title.toString(),
                      style: TextStyle(fontSize: 10),
                      maxLines: 2,
                    ),
                    Text("Price: ${product.price}"),
                    RatingBarIndicator(
                      rating: double.parse(
                        product.rating!.rate.toString(),
                      ),
                      itemCount: 5,
                      itemSize: 17.0,
                      direction: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Icon(
                          Icons.star,
                          color: Colors.amber,
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
      ),
    );
  }
}
