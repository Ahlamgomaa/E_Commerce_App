import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:e_commerce_app/data/product_repository.dart';
import 'package:e_commerce_app/blocs/product/product_bloc.dart';
import 'package:e_commerce_app/blocs/cart/cart_bloc.dart';
import 'package:e_commerce_app/models/cart_item.dart';
import 'package:e_commerce_app/screens/product_list_screen.dart';
import 'package:e_commerce_app/screens/cart_screen.dart';
import 'package:e_commerce_app/blocs/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(CartItemAdapter());
  }
  final cartBox = await Hive.openBox<CartItem>('cartBox');
  runApp(MyApp(cartBox: cartBox));
}

class MyApp extends StatelessWidget {
  final Box<CartItem> cartBox;
  final ProductRepository? productRepository;
  const MyApp({super.key, required this.cartBox, this.productRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final repo = productRepository ?? ProductRepository();
    return MultiRepositoryProvider(
      providers: [RepositoryProvider.value(value: repo)],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ProductBloc(repository: repo)..add(LoadProducts()),
          ),
          BlocProvider(
            create: (_) => CartBloc(cartBox: cartBox)..add(LoadCart()),
          ),
          BlocProvider(create: (_) => ThemeCubit()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
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
