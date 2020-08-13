import 'dart:io';

import 'stack.dart';

abstract class Calculator {
  double _result;

  Calculator(double value1, double value2) {
    stdout.write('Sonuç --> ');
  }
  static Stack<String> stringToStack(String input) {
    var equationStack = Stack<String>();
    var number = '';
    input.runes.forEach((elemant) {
      var eachChar = String.fromCharCode(elemant);
      // Char kodundan char haline dönüşütürüp kullanmak üzere değişkene atadık
      if (eachChar == '+' ||
          eachChar == '-' ||
          eachChar == '*' ||
          eachChar == '/' ||
          eachChar == '(' ||
          eachChar == ')') {
        if (number != '') {
          equationStack.push(number);
        } //Elimizdeki number değişkenini yığına ekliyoruz

        equationStack.push(eachChar); //Elimizdeki operatörü de yığına ekliyoruz
        number =
            ''; //Bir sonraki sayılar için number değişkenimizi sıfırlıyoruz
      } else {
        number +=
            eachChar; //number değişkenimize gelen rakamı ekleyelim ki birden fazla basamaklı sayıları da ekleyebilelim
      }
    });
    if (number != '') {
      equationStack.push(number);
    }
// elde kalan son sayıyı da ekliyoruz yığına

    return equationStack;
  }

  static int prec(
      ch) // Operatörlerin işlem önceliğini belirlemek için kullanıyoruz. Önceliği yüksek operatörün değeri de yüksek. Bunlar dışında karakter var ise -1 dönüyoruz.
  {
    switch (ch) {
      case '+':
      case '-':
        return 1;

      case '*':
      case '/':
        return 2;
    }
    return -1;
  }

  static Stack infixToPostfix(Stack<String> infix) {
    var result = Stack();
    var stack = Stack<String>();
    for (var i = 0; i < infix.size(); i++) {
      var eachChar = infix.get(i);

      // Eğer karakter sayı ise outputa ekle
      if (isNumeric(eachChar)) {
        result.push(eachChar);
      }

      // Eğer karakter parantez aç ise yığına ekle
      else if (eachChar == '(') {
        stack.push(eachChar);
      } else if (stack.isEmpty || stack.top() == '(') {
        stack.push(eachChar);
      }

      // Eğer karakter parantez kapa ise
      else if (eachChar == ')') {
        while (!stack.isEmpty && stack.top() != '(') {
          result.push(stack
              .pop()); // Yığın tamamen bol kalmadan parantez kapamaya denk gelene kadar poplayıp resulta ekliyoruz.
        }

        if (!stack.isEmpty && stack.top() != '(') {
          throw Exception('Hatalı ifade');
        } else {
          stack.pop();
        }
      }

      // Eğer karakter bir operatör ise
      else {
        //Yığın tamamen boş kalmadan işlem önceliği düşük olacak şekilde result'a ekliyoruz
        while (!stack.isEmpty && prec(eachChar) <= prec(stack.top())) {
          //Eğer yığının en üstünde parantez açma işareti var ise ifade hatalı demektir
          if (stack.top() == '(') {
            throw Exception('Hatalı ifade');
          }
          result.push(stack.pop());
        }
        //Yığına elimizdeki karakteri ekliyoruz
        stack.push(eachChar);
      }
    }
    // Yığın boşalana kadar geriye kalmış olan operatörleri popluyoruz
    while (!stack.isEmpty) {
      if (stack.top() == '(') {
        throw Exception('Hatalı ifade');
      }
      result.push(stack.pop());
    }

    return result;
  }

  /*static Stack<String> postfixToPrefix(Stack<String> postfix){


  }*/
  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }

    return double.tryParse(s) != null;
  }

  static String reverseEquation(String input) {
    var reversedInput =
        input.split('').reversed.join(''); // Verilen denklemi ters çevirdik.

    //Parantezleri tersine çevirdik.
    reversedInput = reversedInput.replaceAll('(', '?');
    reversedInput = reversedInput.replaceAll(')', '(');
    reversedInput = reversedInput.replaceAll('?', ')');
    return reversedInput;
  }

  static double calculateFromPrefix(Stack stack) {
    var _results = Stack();

    var _operators = Stack();
    for (var i = 0; i < stack.size(); i++) {
      // Sayıyı en başta ters çevirdiğimiz için çok haneli sayıları düzeltmek amacıyla tekrar çeviriyoruz.
      var elemant = stack.get(i).split('').reversed.join('');
      //Eğer eleman sayıysa sonuçlar yığınına, değilse operatörler yığınına ekle
      if (isNumeric(elemant)) {
        _results.push(double.parse(elemant));
      } else {
        _operators.push(elemant);
      }
      // _results yığının iki ve ikiden fazla sayı varsa, aynı zamanda herhangi bir operatör var ise bu operatörle en yukarıdaki iki sayıya işlem yap.
      // Sonucu tekrardan yığına ekle
      if (_results.size() >= 2 && _operators.size() > 0) {
        switch (_operators.pop()) {
          case '+':
            _results.push(_results.pop() + _results.pop());
            break;
          case '-':
            _results.push(_results.pop() - _results.pop());
            break;
          case '*':
            _results.push(_results.pop() * _results.pop());
            break;
          case '/':
            _results.push(_results.pop() / _results.pop());
            break;
        }
      }
    }

    //Geriye kalan sonucumuzu return ediyoruz

    return _results.get(0);
  }
}
