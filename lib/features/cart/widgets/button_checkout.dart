import 'package:ecommerce/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce/features/payment/models/payment%20_intent_input_model.dart';
import 'package:ecommerce/features/payment/paymentcubit/payment_cubit.dart';
import 'package:ecommerce/features/payment/paymentcubit/payment_state.dart';
import 'package:ecommerce/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomButtonCheckout extends StatefulWidget {
  final double amount;

  const CustomButtonCheckout({super.key, required this.amount});

  @override
  State<CustomButtonCheckout> createState() => _CustomButtonCheckoutState();
}

class _CustomButtonCheckoutState extends State<CustomButtonCheckout> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is PaymentSuccess) {
          setState(() {
            isLoading = false;
          });

          // 🧹 تفريغ السلة
          context.read<CartCubit>().clearCart();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('تم إتمام الدفع بنجاح!')));

          // ✅ الرجوع للصفحة الرئيسية
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainLayout()),
          );
        } else if (state is PaymentFailure) {
          setState(() {
            isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('فشل في إتمام الدفع: ${state.error}')),
          );
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            final paymentIntentInputModel = PaymentIntentInputModel(
              amount: widget.amount.toInt(),
              currency: 'EGP',
            );

            context.read<PaymentCubit>().makePayment(
              paymentIntentInputModel: paymentIntentInputModel,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: isLoading
              ? const CircularProgressIndicator()
              : const Text('إتمام الدفع', style: TextStyle(fontSize: 16)),
        );
      },
    );
  }
}
