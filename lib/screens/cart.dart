import 'package:flutter/material.dart';
import 'package:perakende/screens/payment.dart';
import 'package:provider/provider.dart';
import 'package:perakende/models/cart.dart';
import 'payment.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Alışveriş Sepeti', style: TextStyle(color: Colors.grey[200])),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.grey[200]),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CartList(),
              ),
            ),
            Divider(height: 4, color: Colors.black),
            _CartTotal()
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.headline6;
    var cart = context.watch<CartModel>();

    return ListView.builder(
      itemCount: cart.items.length,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.done),
        trailing: IconButton(
          icon: Icon(Icons.remove_circle_outline),
          onPressed: () {
            cart.remove(cart.items[index]);
          },
        ),
        title: Text(
          cart.items[index].name,
          style: itemNameStyle,
        ),
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CartModel>(
                builder: (context, cart, child) => Text(
                    'Toplam Ücret : ${cart.totalPrice}\₺',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 50))),
            SizedBox(width: 24),
            TextButton(
              onPressed: () {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Buying not supported yet.')));
              },
              style: TextButton.styleFrom(primary: Colors.white),
              child: ElevatedButton(
                child: Text('Satın Al'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<dynamic>(builder: (context) => Payment()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
