class PaymentIntentInputModel {
  int? amount;
  String? currency;

  PaymentIntentInputModel({this.amount, this.currency});

  toJson() {
    return {'amount': amount, 'currency': currency};
  }
}
