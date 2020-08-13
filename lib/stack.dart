import 'dart:collection';

import 'dart:io';

class Stack<T> {
  final ListQueue<T> _list = ListQueue();

  /// Yığın boş mu kontrol ediyor
  bool get isEmpty => _list.isEmpty;
  
  /// Yığının üstüne eleman ekler
  void push(T e) {
    _list.addLast(e);
  }

  /// Yığının en üstündeki elemanı siler ve döndürür
  T pop() {
    var last = _list.last;
    _list.removeLast();
    return last;
  }

  /// Yığının en üstündeki elemanı silmeden döndürür
  T top() {
    return _list.last;
  }

  /// Boyutu döndürür
  int size() {
    return _list.length;
  }

  T get(int index) {
    return _list.elementAt(index);
  }

  T takeFirst() {
    var _first = _list.elementAt(0);

    _list.removeFirst();
    return _first;
  }

  void insertFirst(T first) {
    _list.addFirst(first);
  }

  void printAll() {
    _list.forEach((var element) {
      stdout.write(element.toString() + ' ');
    });
    stdout.write('\n');
  }
}
