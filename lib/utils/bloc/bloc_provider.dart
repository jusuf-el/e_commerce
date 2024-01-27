import 'package:e_commerce/utils/bloc/bloc_base.dart';
import 'package:flutter/material.dart';

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final T bloc;
  final Widget child;

  const BlocProvider({super.key, required this.bloc, required this.child});

  @override
  State<BlocProvider> createState() => _BlocProviderState();

  static T of<T extends BlocBase>(BuildContext context) {
    BlocProvider<T> provider = context
        .findAncestorWidgetOfExactType<BlocProvider<T>>() as BlocProvider<T>;

    return provider.bloc;
  }
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  void dispose() {
    super.dispose();
    widget.bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
