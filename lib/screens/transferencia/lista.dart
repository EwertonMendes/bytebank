import 'package:flutter/material.dart';

import '../../models/transferencia.dart';
import 'formulario.dart';

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = <Transferencia>[];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
      body: ListView.builder(
          itemCount: widget._transferencias.length,
          itemBuilder: (context, index) {
            return ItemTransferencia(widget._transferencias[index]);
          }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            final Future future = Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormularioTransferencia(),
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

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}
