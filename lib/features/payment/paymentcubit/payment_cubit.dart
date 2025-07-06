import 'package:bloc/bloc.dart';
import 'package:ecommerce/features/payment/models/payment%20_intent_input_model.dart';
import 'package:ecommerce/features/payment/paymentcubit/payment_state.dart';
import 'package:ecommerce/features/payment/repos/checkout_repo.dart';
import 'package:meta/meta.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkoutRepo) : super(PaymentInitial());
  final CheckoutRepo checkoutRepo;
  Future makePayment({
    String? paymentIntentId,
    String? clientSecret,
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    emit(PaymentLoading());
    final data = await checkoutRepo.makePayment(
      paymentIntentInputModel: paymentIntentInputModel,
    );
    data.fold(
      (failure) => emit(PaymentFailure(failure.message)),
      (_) => emit(PaymentSuccess()),
    );
  }

  @override
  void onChange(Change<PaymentState> change) {
    super.onChange(change);
    print(change);
  }
}
