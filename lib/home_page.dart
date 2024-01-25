import 'dart:convert';

import 'package:find_better_app/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];
  bool _showGrid = true;

  Future<void> getProductData() async {
    String url = "https://fakestoreapi.com/products/";
    Uri convertedUri = Uri.parse(url);
    var result = await http.get(convertedUri);
    if (result.statusCode == 200) {
      List resultingList = jsonDecode(result.body) as List;
      for (var element in resultingList) {
        products.add(Product.fromJson(element));
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    getProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60,
        leadingWidth: 75,
        elevation: 2,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
        ],
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          height: 30,
          width: 30,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              "https://i.pinimg.com/564x/a8/6b/03/a86b03696ff877b483b9d741a62ba2de.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          onPressed: () {
            setState(() {
              _showGrid = !_showGrid;
            });
          },
          label: Icon(
            _showGrid ? Icons.grid_on : Icons.list,
            color: Colors.white,
          )),
      body: Container(
        margin: const EdgeInsets.only(left: 8, right: 8, top: 16),
        child: !_showGrid ? _gridDisplay() : _listDisplay(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _listDisplay() {
    return ListView.separated(
        itemBuilder: (BuildContext context, int pos) {
          Product product = products[pos];
          return Card(
            elevation: 0.5,
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              onTap: () {},
              title: Text(
                product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              subtitle: Text(
                product.more,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 10,
                    color: Colors.grey),
              ),
              leading: Image.network(
                product.image,
                fit: BoxFit.cover,
                height: 48,
                width: 48,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "USD ${product.price}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.red),
                  ),
                  ClipRRect(
                    child: Container(
                      color: Colors.black,
                      padding: const EdgeInsets.all(4.0),
                      child: Text(product.category,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 8,
                              color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int pos) {
          return const SizedBox(height: 16);
        },
        itemCount: products.length);
  }

  Widget _gridDisplay() {
    return GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 8.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ),
        itemBuilder: (BuildContext context, int pos) {
          Product product = products[pos];
          return Container(
            color: Colors.white,
            child: Card(
              elevation: 0.5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    product.image,
                    fit: BoxFit.cover,
                    height: 100,
                    width: double.infinity,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Text(
                      product.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              product.more,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10,
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "USD ${product.price}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
