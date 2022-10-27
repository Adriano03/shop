import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_grid_item.dart';

import '../models/product.dart';
import '../models/product_list.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  const ProductGrid(
    this.showFavoriteOnly, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProduct =
        showFavoriteOnly ? provider.favoriteItems : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: loadedProduct.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProduct[i],
        // ignore: prefer_const_constructors
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade700),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(10),
              top: Radius.circular(5),
            ),
          ),
          child: const ProductGridItem(),
        ),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
