import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction, {Key? key}) : super(key: key);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      //variavel para inplementar os dias da semana tendo como referencia o dia atual menos o index
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      //variavel para guardar o valor total do dia
      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        //verificando se a transação foi feita no mesmo dia, mês e ano
        bool sameDay = recentTransaction[1].date.day == weekDay.day;
        bool sameMonth = recentTransaction[1].date.month == weekDay.month;
        bool sameYear = recentTransaction[1].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum = totalSum + recentTransaction[1].value;
        }
      }

      return {
        //o construtuar E() representa a sigla do dia da semana, formatando a primeira letra do dia atual
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

//pegar os valores gastos durante a semana
  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'].toString(),
                value: (tr['value'] as double),
                percentage: (tr['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
