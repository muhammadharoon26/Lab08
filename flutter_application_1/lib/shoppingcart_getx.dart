import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(ShoppingCartApp());
}

class ShoppingCartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: ProductListPage(),
    );
  }
}

class CartController extends GetxController {
  var cart = <Product>[].obs;

  void addToCart(Product product) {
    cart.add(product);
  }

  void removeFromCart(Product product) {
    cart.remove(product);
  }
}

class Product {
  final String name;
  final double price;

  Product(this.name, this.price);
}

class ProductListPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  final products = [
    Product('Laptop', 1000.0),
    Product('Smartphone', 500.0),
    Product('Headphones', 200.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Get.to(() => CartPage()),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price}'),
            trailing: ElevatedButton(
              onPressed: () {
                cartController.addToCart(product);
              },
              child: Text('Add to Cart'),
            ),
          );
        },
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Obx(() {
        return ListView.builder(
          itemCount: cartController.cart.length,
          itemBuilder: (context, index) {
            final product = cartController.cart[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text('\$${product.price}'),
              trailing: IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  cartController.removeFromCart(product);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
