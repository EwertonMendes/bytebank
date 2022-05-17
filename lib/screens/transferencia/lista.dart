import 'package:flutter/material.dart';
import 'dart:convert';
import '../../models/transferencia.dart';
import 'formulario.dart';
import 'package:flutter/services.dart' show rootBundle;

class ListaTransferencias extends StatefulWidget {
  ListaTransferencias({Key? key}) : super(key: key);

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
    return await json.decode(response);
  }

  @override
  void initState() {
    super.initState();
    readJson().then(
      (transferences) => setState(
        () {
          for (var transference in transferences) {
            Transferencia transferencia = Transferencia(
              double.parse(transference['value']),
              int.parse(transference['accountNumber']),
              transference['status'],
            );
            widget._transferencias.add(transferencia);
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
          future.then(
            (transferenciaRecebida) {
              debugPrint('Future');
              debugPrint('$transferenciaRecebida');
              if (transferenciaRecebida != null) {
                setState(
                  () => widget._transferencias.add(transferenciaRecebida),
                );
              }
            },
          );
        },
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(this._transferencia, {Key? key}) : super(key: key);

  Color _corTransferencia() {
    if (_transferencia.status == 'processing') {
      return Colors.amber;
    }

    if (_transferencia.status == 'canceled') {
      return Colors.grey[500]!;
    }

    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2.0,
        child: ListTile(
          leading: const Icon(Icons.monetization_on),
          title: Text(_transferencia.valor.toString()),
          subtitle: Text(
              '${_transferencia.numeroConta.toString()} | ${_transferencia.status.toUpperCase()}'),
          tileColor: _corTransferencia(),
        ));
  }
}
