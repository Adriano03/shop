import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    const divider = Divider(thickness: 1.5);

    return Drawer(
      child: ListView(
        children: [
          AppBar(
            title: const Text('Bem vindo!'),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          ListTile(
            leading: const Icon(Icons.shopify),
            title: const Text('Loja'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.AUTH_OR_HOME);
            },
          ),
          divider,
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Pedidos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS);
              // Navigator.of(context).pushReplacement(
              //   CustomRoute(builder: (ctx) => const OrdersPage()),
              // );
            },
          ),
          divider,
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Gerenciar Produtos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.PRODUCTS);
            },
          ),
          divider,
          ListTile(
            leading: const Icon(Icons.exit_to_app_rounded),
            title: const Text('Sair'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.AUTH_OR_HOME);
            },
          ),
          divider,
        ],
      ),
    );
  }
}
