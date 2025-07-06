import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/core/util/stripe_servece.dart';
import 'package:ecommerce/features/payment/models/payment%20_intent_input_model.dart';
import 'package:ecommerce/features/payment/repos/checkout_repo.dart';

class CheckoutRepoImpl implements CheckoutRepo {
  final StripeService stripeService;

  CheckoutRepoImpl(this.stripeService);

  @override
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    try {
      await stripeService.makePayment(
        paymentIntentInputModel: paymentIntentInputModel as dynamic,
      );
      return const Right(null);
    } on Exception catch (e) {
      // TODO
      return Left(ServerFailure(e.toString()));
    }
  }
}
