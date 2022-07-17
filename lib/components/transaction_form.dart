import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    //se os dados tiverem vazios ou invalidos ele sai da função
    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            controller: titleController,
            onSubmitted: (_) => _submitForm(),
            decoration: InputDecoration(
              labelText: "Titulo",
            ),
          ),
          TextField(
            controller: valueController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _submitForm(),
            decoration: InputDecoration(
              labelText: "Valor (R\$)",
            ),
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Text("Nenhuma data selecionada!"),
                TextButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).copyWith().primaryColor),
                  onPressed: () {},
                  child: Text(
                    "Selecionar Data",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).copyWith().primaryColor,
                  textStyle: TextStyle(
                      color: Theme.of(context).textTheme.button!.color),
                ),
                child: Text("Nova Transação"),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
