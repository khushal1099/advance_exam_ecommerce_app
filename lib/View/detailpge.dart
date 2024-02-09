import 'package:advance_exam_ecommerce_app/Controller/quantity_provider.dart';
import 'package:advance_exam_ecommerce_app/Modal/product_model.dart';
import 'package:advance_exam_ecommerce_app/View/cartpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  String? title;
  String? description;
  double? price;
  String? category;
  String? image;
  double? rating;
  int? id;

  DetailPage(
      {super.key,
      this.rating,
      this.price,
      this.title,
      this.category,
      this.image,
      this.id,
      this.description});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DetailPage"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Consumer<QuantityProvider>(builder: (context, qp, child) {
          return Column(
            children: [
              Image.network(
                widget.image ?? "",
                height: 390,
                width: 307.20,
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: MediaQuery.sizeOf(context).height * 0.39,
                width: MediaQuery.sizeOf(context).width * 0.95,
                color: Colors.black12,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text("Title:-"),
                      Text(
                        "${widget.title}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("Description:-"),
                      Text(
                        widget.description ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Category:- "),
                            Text(
                              "${widget.category!.split('.').last}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Price:-  "),
                            Text(
                              widget.price.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Rating:-  "),
                            RatingBarIndicator(
                              rating: double.parse(
                                widget.rating.toString(),
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
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          ProductModel product = ProductModel(
                            title: widget.title,
                            price: widget.price,
                            image: widget.image,
                            id: widget.id,
                          );
                          bool isProductInCart = qp.cartlist
                              .any((index) => index.title == widget.title);
                          if (isProductInCart) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Product already in cart"),
                                backgroundColor: Colors.red,
                                action: SnackBarAction(
                                  label: "view cart",
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return CartPage();
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                            print("Product already in cart");
                          } else {
                            // If the product is not already in the cart list, add it
                            qp.cartlist.add(product);
                            qp.saveCartList();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Product added to cart'),
                                backgroundColor: Colors.orange,
                                action: SnackBarAction(
                                  label: "view cart",
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return CartPage();
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                          print(qp.cartlist.length);
                        },
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 0.070,
                          width: MediaQuery.sizeOf(context).width * 0.89,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              "Add To Cart",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
