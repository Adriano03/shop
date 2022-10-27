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
    final snackBar = ScaffoldMessenger.of(context);

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
                          CartButton(cart: cart, snackBar: snackBar),
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

class CartButton extends StatefulWidget {
  const CartButton({
    Key? key,
    required this.cart,
    required this.snackBar,
  }) : super(key: key);

  final Cart cart;
  final ScaffoldMessengerState snackBar;

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator()
        : TextButton(
            onPressed: () async {
              setState(() => _isLoading = true);
              await Provider.of<OrderList>(
                context,
                listen: false,
              ).addOrder(widget.cart);

              widget.cart.clear();
              setState(() => _isLoading = false);

              widget.snackBar.showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 3),
                  backgroundColor: Theme.of(context).colorScheme.primary,
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
          );
  }
}
