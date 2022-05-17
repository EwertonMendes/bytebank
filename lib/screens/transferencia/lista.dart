import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import '../../models/transferencia.dart';
import 'formulario.dart';
import 'package:flutter/services.dart' show rootBundle;

class ListaTransferencias extends StatefulWidget {
  Future<String> getJson() async {
    return await rootBundle.loadString('assets/transferencias.json');
  }

  final List<Transferencia> _transferencias = <Transferencia>[];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  Future<List> readJson() async {
    final String response = await rootBundle.loadString('lib/db/database.json');
    final data = await json.decode(response);
    return data;
  }

  @override
  void initState() {
    super.initState();
    readJson().then(
      (value) => setState(
        () {
          for (var item in value) {
            widget._transferencias.add(Transferencia(
              double.parse(item['value']),
              int.parse(item['accountNumber'])));
          }
        },
      ),
    );
  }

  Widget emptableList(List list, BuildContext context) {
    return list.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ItemTransferencia(list[index]);
            })
        : const Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                'SEM TRANFERÊNCIAS POR AQUI ¯\\_(ツ)_/¯',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
      body: emptableList(widget._transferencias, context),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            final Future future = Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FormularioTransferencia(),
              ),
            );
            future.then((transferenciaRecebida) {
              debugPrint('Future');
              debugPrint('$transferenciaRecebida');
              if (transferenciaRecebida != null) {
                setState(
                    () => widget._transferencias.add(transferenciaRecebida));
              }
            });
          }),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(this._transferencia, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2.0,
        child: ListTile(
          leading: const Icon(Icons.monetization_on),
          title: Text(_transferencia.valor.toString()),
          subtitle: Text(_transferencia.numeroConta.toString()),
        ));
  }
}
