import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';

import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget(
    this.cartItem, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalPrice = cartItem.price * cartItem.quantity;
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Tem Certeza?'),
            content: Text('Quer remover o item ${cartItem.name}?'),
            actions: [
              TextButton(
                child: const Text('Não'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
              TextButton(
                child: Text(
                  'Sim',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (_) {
        Provider.of<Cart>(
          context,
          listen: false,
        ).removeItem(cartItem.productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 4,
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: FittedBox(
                child: Text(
                  cartItem.price.toStringAsFixed(2),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          title: Text(cartItem.name),
          subtitle: Text('Total: R\$${totalPrice.toStringAsFixed(2)}'),
          trailing: Text('${cartItem.quantity}X'),
        ),
      ),
    );
  }
}
