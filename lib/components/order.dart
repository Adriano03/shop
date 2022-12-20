import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/order.dart';

class OrderWidget extends StatefulWidget {
  final Order order;

  const OrderWidget({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  // bool _exapanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ExpansionTile(
            childrenPadding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8.0,
            ),
            title: Text('R\$ ${widget.order.total.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy HH:mm').format(widget.order.date),
            ),
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.order.products.length,
                itemBuilder: (ctx, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${widget.order.products[index].quantity}x    ${widget.order.products[index].name}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'R\$ ${widget.order.products[index].price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   final itemsHeight = widget.order.products.length * 25.0 + 10;
  //   return AnimatedContainer(
  //     duration: const Duration(milliseconds: 300),
  //     height: _exapanded ? itemsHeight + 80 : 80,
  //     child: Card(
  //       child: Column(
  //         children: [
  //           ListTile(
  //             title: Text('R\$${widget.order.total.toStringAsFixed(2)}'),
  //             subtitle: Text(
  //               DateFormat('dd/MM/yyyy HH:mm').format(widget.order.date),
  //             ),
  //             trailing: IconButton(
  //               onPressed: () {
  //                 setState(() {
  //                   //Valor inicial é false, então false recebe o contrário de false(true), ou ao contrário!
  //                   _exapanded = !_exapanded;
  //                 });
  //               },
  //               icon: _exapanded
  //                   ? const Icon(Icons.expand_less)
  //                   : const Icon(Icons.expand_more),
  //             ),
  //           ),
  //             AnimatedContainer(
  //               duration: const Duration(milliseconds: 300),
  //               height: _exapanded ? itemsHeight : 0,
  //               padding: const EdgeInsets.symmetric(
  //                 horizontal: 15,
  //                 vertical: 4,
  //               ),
  //               child: ListView(
  //                 children: widget.order.products.map(
  //                   (product) {
  //                     return Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           product.name,
  //                           style: const TextStyle(
  //                             fontSize: 18,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                         Text(
  //                           '${product.quantity}x R\$${product.price.toStringAsFixed(2)}',
  //                           style: TextStyle(
  //                             fontSize: 18,
  //                             color: Colors.grey.shade400,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ],
  //                     );
  //                   },
  //                 ).toList(),
  //               ),
  //             ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
