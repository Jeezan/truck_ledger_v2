enum TransactionType {
  sale('sale'),
  purchase('purchase');

  final String value;
  const TransactionType(this.value);
}

enum PaymentType {
  cashIn('cash_in'),
  cashOut('cash_out');

  final String value;
  const PaymentType(this.value);
}
