import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:perakende/models/cart.dart';
import 'package:perakende/models/catalog.dart';
import 'package:perakende/screens/catalog.dart';

Widget createCatalogScreen() => MultiProvider(
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
        home: MyCatalog(),
      ),
    );

void main() {
  final catalogListItems = CatalogModel.itemNames.sublist(0, 3);

  group('CatalogScreen Widget Tests', () {
    testWidgets('Testing item row counts and text', (tester) async {
      await tester.pumpWidget(createCatalogScreen());

      for (var item in catalogListItems) {
        expect(find.text(item), findsWidgets);
      }
    });

    testWidgets('Testing the ADD buttons and check after clicking',
        (tester) async {
      await tester.pumpWidget(createCatalogScreen());

      expect(find.text('Ekle'), findsWidgets);

      await tester.tap(find.widgetWithText(TextButton, 'Ekle').first);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check), findsOneWidget);
    });
  });
}
