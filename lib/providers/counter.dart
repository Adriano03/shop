import 'package:flutter/material.dart';

//Exemplo usando o Inherited Widget de como compartilhar informações dentro da árvore de componentes
//Para funcionar precisa envolver com um widget o interessado.. Que nesse caso é o CounterProvider

class CounterState {
  int _value = 0;

  void inc() => _value++;
  void dec() => _value--;
  int get value => _value;

  bool diff(CounterState old) {
    return old._value != _value;
  }
}

class CounterProvider extends InheritedWidget {
  final CounterState state = CounterState();

  CounterProvider({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    return oldWidget.state.diff(state);
  }
}
