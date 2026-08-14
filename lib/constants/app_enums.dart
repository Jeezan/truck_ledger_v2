enum TransactionType {
  sale('sale'),
  purchase('purchase');

  final String value;
  const TransactionType(this.value);
}
