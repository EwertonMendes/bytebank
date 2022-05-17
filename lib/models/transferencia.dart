class Transferencia {
  final double valor;
  final int numeroConta;
  final String status;

  Transferencia(this.valor, this.numeroConta, this.status);

  @override
  String toString() {
    return 'Transferencia: valor: $valor, numeroConta: $numeroConta, status: $status';
  }
}
