import 'package:advance_exam_ecommerce_app/Controller/quantity_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    Provider.of<QuantityProvider>(context, listen: false).loadCartList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Consumer<QuantityProvider>(
        builder: (context, qp, child) {
          //Calculation of subtotal
          double subtotal = 0;
          qp.cartlist.forEach((product) {
            subtotal += (product.price! * (product.quantity ?? 1));
          });

          //Calculation of net total
          double total = 0;
          qp.cartlist.forEach((product) {
            total += (product.price! * (product.quantity ?? 1));
          });

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var product = qp.cartlist[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.94,
                              color: Colors.black26,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(
                                        product.image ?? "",
                                        // Add null check for product
                                        height: 70,
                                        width: 70,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(product.title ?? ""),
                                        // Add null check for product
                                        Text(
                                          "Price: ${product.price! * (product.quantity ?? 1)}",
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 40, left: 182),
                                height:
                                    MediaQuery.of(context).size.height * 0.043,
                                width: MediaQuery.of(context).size.width * 0.35,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        qp.addProduct(index);
                                      },
                                      child: Icon(Icons.add),
                                    ),
                                    Text("${product.quantity ?? 1}"),
                                    InkWell(
                                      onTap: () {
                                        qp.removeProduct(index);
                                      },
                                      child: Icon(Icons.remove),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: IconButton(
                                  onPressed: () {
                                    qp.deleteProduct(index);
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: qp.cartlist.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.040,
                  width: MediaQuery.sizeOf(context).width * 1,
                  color: Colors.orange,
                  child:
                      Consumer<QuantityProvider>(builder: (context, qp, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Total: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text("\$${total.toStringAsFixed(2)}"),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
