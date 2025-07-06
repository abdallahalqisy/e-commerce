import 'package:dio/dio.dart';
import 'package:ecommerce/core/util/api_keys.dart';
import 'package:ecommerce/core/util/api_service.dart';
import 'package:ecommerce/features/auth/constant.dart';
import 'package:ecommerce/features/payment/models/payment%20_intent_input_model.dart';
import 'package:ecommerce/features/payment/models/payment_intent_model/payment_intent_model.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  final ApiService apiService = ApiService();
  // Your StripeService implementation
  Future<PaymentIntentModel> createPaymentIntent(
    PaymentIntentInputModel input,
  ) async {
    var response = await apiService.post(
      body: input.toJson(),
      contentType: Headers.formUrlEncodedContentType,
      url: 'https://api.stripe.com//v1/payment_intents',
      token: ApiKeys.stripeSecretKey,
    );
    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  Future initPaymentSheet({required String paymentIntentClientSecret}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: 'FreshCart',
      ),
    );
    // Initialize the payment sheet if needed
    // This is usually done in the UI layer, not here
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    await initPaymentSheet(
      paymentIntentClientSecret: paymentIntentModel.clientSecret!,
    );
    await displayPaymentSheet();
  }
}
