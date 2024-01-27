import 'package:e_commerce/modules/products/blocs/categories_bloc.dart';
import 'package:e_commerce/modules/products/blocs/products_bloc.dart';
import 'package:e_commerce/modules/products/view/products_view.dart';
import 'package:flutter/material.dart';

import 'utils/bloc/bloc_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: ProductsBloc(),
      child: BlocProvider(
        bloc: CategoriesBloc(),
        child: MaterialApp(
          title: 'E-Commerce',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Rubik',
          ),
          builder: ((context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.noScaling),
              child: child!,
            );
          }),
          home: const ProductsView(),
        ),
      ),
    );
  }
}
