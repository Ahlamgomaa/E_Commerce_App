// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';


import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/models/cart_item.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/data/product_repository.dart';

class _FakeRepo extends ProductRepository {
  _FakeRepo() : super();
  @override
  Future<List<Product>> fetchProducts() async {
    return const [
      Product(
        id: 1,
        title: 'Test Product',
        description: 'desc',
        imageUrl: 'https://via.placeholder.com/150',
        price: 10.0,
      )
    ];
  }
}

void main() {
  testWidgets('Renders app with products app bar', (WidgetTester tester) async {
    final tempDir = await Directory.systemTemp.createTemp('hive_test_');
    Hive.init(tempDir.path);
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(CartItemAdapter());
    }
    final cartBox = await Hive.openBox<CartItem>('cartBox');

    await tester.pumpWidget(MyApp(cartBox: cartBox, productRepository: _FakeRepo()));
    await tester.pump();

    expect(find.text('Products'), findsOneWidget);

    await cartBox.close();
    await tempDir.delete(recursive: true);
  });
}
