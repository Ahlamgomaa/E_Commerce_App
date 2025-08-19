import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:e_commerce_app/data/product_servicesdart';
import 'package:e_commerce_app/ViewModel/product/product_bloc.dart';
import 'package:e_commerce_app/ViewModel/cart/cart_bloc.dart';
import 'package:e_commerce_app/models/cart_item_model.dart';
import 'package:e_commerce_app/views/product_list_screen.dart';
import 'package:e_commerce_app/views/cart_screen.dart';
import 'package:e_commerce_app/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(CartItemAdapter());
  }

  // Open cart box
  final cartBox = await Hive.openBox<CartItem>('cartBox');

  
  runApp(MyApp(cartBox: cartBox));
}

class MyApp extends StatelessWidget {
  final Box<CartItem> cartBox;
  final ProductServices? productServices;
  const MyApp({super.key, required this.cartBox, this.productServices});

  @override
  Widget build(BuildContext context) {
    final repo = productServices ?? ProductServices();
    return MultiRepositoryProvider(
      providers: [RepositoryProvider.value(value: repo)],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ProductBloc(service: repo)..add(LoadProducts()),
          ),
          BlocProvider(
            create: (_) => CartBloc(cartBox: cartBox)..add(LoadCart()),
          ),
          BlocProvider(create: (_) => ThemeApp()),
        ],
        child: BlocBuilder<ThemeApp, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Mini E-Commerce',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              ),
              darkTheme: ThemeData.dark(),
              themeMode: themeMode,
              home: const ProductListScreen(),
              routes: {'/cart': (_) => const CartScreen()},
            );
          },
        ),
      ),
    );
  }
}
