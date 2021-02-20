import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:perakende/common/theme.dart';
import 'package:perakende/models/cart.dart';
import 'package:perakende/models/catalog.dart';
import 'package:perakende/screens/cart.dart';
import 'package:perakende/screens/catalog.dart';
import 'package:perakende/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CatalogModel()),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => MyLogin(),
          '/catalog': (context) => MyCatalog(),
          '/cart': (context) => MyCart(),
        },
      ),
    );
  }
}
