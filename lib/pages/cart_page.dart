import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item.dart';
import 'package:shop/models/order_list.dart';

import '../models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Carrinho'),
          centerTitle: true,
        ),
        body: cart.itemsCount > 0
            ? Column(
                children: [
                  Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 25),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Chip(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            label: Text(
                              'R\$${cart.totalAmount.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .headline6
                                    ?.color,
                              ),
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              Provider.of<OrderList>(
                                context,
                                listen: false,
                              ).addOrder(cart);

                              cart.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 3),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  content: const Text(
                                    'Compra efetuada com sucesso!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              textStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            child: const Text('COMPRAR'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (ctx, i) => CartItemWidget(items[i]),
                    ),
                  )
                ],
              )
            : Center(
                child: Text(
                  'Adicione suas compras ao carrinho!!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ));
  }
}
