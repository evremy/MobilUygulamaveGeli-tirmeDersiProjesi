import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:perakende/models/cart.dart';
import 'package:perakende/models/catalog.dart';

class MyCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
              childAspectRatio: 1.0,
            ),
            delegate: SliverChildBuilderDelegate(
                (context, index) => _MyListItem(index)),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInCart = context.select<CartModel, bool>(
      (cart) => cart.items.contains(item),
    );

    return SizedBox(
        width: 260.00,
        height: 50.00,
        child: DecoratedBox(
          decoration: const BoxDecoration(
              color: Color.fromRGBO(00, 00, 00, 0.3),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0))),
          child: TextButton(
              onPressed: isInCart
                  ? null
                  : () {
                      var cart = context.read<CartModel>();
                      cart.add(item);
                    },
              child: Align(
                  alignment: Alignment.topRight,
                  child: isInCart
                      ? Icon(Icons.check,
                          color: Colors.grey[200],
                          size: 30.0,
                          semanticLabel: 'Ekli')
                      : Icon(Icons.add,
                          color: Colors.grey[200],
                          size: 30.0,
                          semanticLabel: 'Ekle'))),
        ));
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.black,
      title: Text('ÜRÜNLER',
          style: TextStyle(
            color: Colors.grey[200],
            fontWeight: FontWeight.w400,
            fontSize: 30,
          )),
      floating: true,
      actions: [
        IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.grey[200],
            size: 30,
          ),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  _MyListItem(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = context.select<CatalogModel, Item>(
      (catalog) => catalog.getByPosition(index),
    );
    var imagecount = (index % 5).toString();

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              image: DecorationImage(
                  image: AssetImage('asset/images/' + imagecount + '.jpg'),
                  fit: BoxFit.cover)),
          height: 100.0,
          child: Column(
            children: [
              SizedBox(width: 100),
              Expanded(
                child: Text(
                  item.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.grey,
                        offset: Offset(0, 2.0),
                      ),
                    ],
                  ),
                ),
              ),
              _AddButton(item: item),
            ],
          ),
        ));
  }
}
