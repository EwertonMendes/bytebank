import 'package:flutter/material.dart';

import '../../components/editor.dart';
import '../../models/transferencia.dart';

const _tituloAppBar = 'Nova Transferência';

class FormularioTransferencia extends StatefulWidget {
  const FormularioTransferencia({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controllerNumeroConta = TextEditingController();
  final TextEditingController _controllerValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_tituloAppBar)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controlador: _controllerNumeroConta,
              rotulo: 'Número da conta',
              dica: '0000',
            ),
            Editor(
              controlador: _controllerValor,
              rotulo: 'Valor',
              dica: '0.00',
              icone: Icons.monetization_on,
            ),
            ElevatedButton(
              onPressed: () => _criarTransferencia(context),
              child: const Text('Confirmar'),
            )
          ],
        ),
      ),
    );
  }

  void _criarTransferencia(BuildContext context) {
    final double? valor = double.tryParse(_controllerValor.text);
    final int? numeroConta = int.tryParse(_controllerNumeroConta.text);

    if (valor == null || numeroConta == null) {
      return;
    }

    final novaTransferencia = Transferencia(valor, numeroConta);
    Navigator.pop(context, novaTransferencia);
  }
}
