
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:perakende/models/cart.dart';
import 'package:perakende/models/catalog.dart';
import 'package:perakende/screens/catalog.dart';
import 'package:perakende/screens/login.dart';

void main() {
  testWidgets('Login page Widget test', (tester) async {
    await tester.pumpWidget(MultiProvider(
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
        initialRoute: '/',
        routes: {
          '/': (context) => MyLogin(),
          '/catalog': (context) => MyCatalog(),
        },
      ),
    ));

    await tester.tap(find.text('ENTER'));
    await tester.pumpAndSettle();

    expect(find.text('Catalog'), findsOneWidget);
  });
}
