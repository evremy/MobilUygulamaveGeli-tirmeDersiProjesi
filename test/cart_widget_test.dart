import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:perakende/models/cart.dart';
import 'package:perakende/models/catalog.dart';
import 'package:perakende/screens/cart.dart';

CartModel cartModel;
CatalogModel catalogModel;
Widget createCartScreen() => MultiProvider(
      providers: [
        Provider(create: (context) => CatalogModel()),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            catalogModel = catalog;
            cartModel = cart;
            cart.catalog = catalogModel;
            return cart;
          },
        ),
      ],
      child: MaterialApp(
        home: MyCart(),
      ),
    );

void main() {
  group('CartScreen widget tests', () {
    testWidgets('Tapping BUY button displays snackbar.', (tester) async {
      await tester.pumpWidget(createCartScreen());

      expect(find.byType(SnackBar), findsNothing);
      await tester.tap(find.text('Satın Al'));
      await tester.pump();
      // Verifying the snackbar upon clicking the button.
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('Testing when the cart contains items', (tester) async {
      await tester.pumpWidget(createCartScreen());

      // Adding five items in the cart and testing.
      for (var i = 0; i < 5; i++) {
        var item = catalogModel.getByPosition(i);
        cartModel.add(item);
        await tester.pumpAndSettle();
        expect(find.text(item.name), findsOneWidget);
      }

      // Testing total price of the five items.
      expect(find.text('${50 * 5}\₺'), findsOneWidget);
      expect(find.byIcon(Icons.done), findsNWidgets(5));
    });
  });
}
