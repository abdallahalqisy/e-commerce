import 'package:ecommerce/features/brand/brand_model.dart';

abstract class BrandState {}

class BrandInitial extends BrandState {}

class BrandLoading extends BrandState {}

class BrandSuccess extends BrandState {
  final List<BrandModel> brands;

  BrandSuccess(this.brands);
}

class BrandError extends BrandState {
  final String message;

  BrandError(this.message);
}
