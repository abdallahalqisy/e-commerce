import 'tip.dart';

class AmountDetails {
  Tip? tip;

  AmountDetails({this.tip});

  factory AmountDetails.fromIdPi3MtwBwLkdIwHu7ix28a3tqPaObjectPaymentIntentAmount2000AmountCapturable0AmountDetailsTipAmountReceived0ApplicationNullApplicationFeeAmountNullAutomaticPaymentMethodsEnabledTrueCanceledAtNullCancellationReasonNullCaptureMethodAutomaticClientSecretPi3MtwBwLkdIwHu7ix28a3tqPaSecretYrKjuKribcBjcG8HVhfZluoGhConfirmationMethodAutomaticCreated1680800504CurrencyUsdCustomerNullDescriptionNullLastPaymentErrorNullLatestChargeNullLivemodeFalseMetadataNextActionNullOnBehalfOfNullPaymentMethodNullPaymentMethodOptionsCardInstallmentsNullMandateOptionsNullNetworkNullRequestThreeDSecureAutomaticLinkPersistentTokenNullPaymentMethodTypesCardLinkProcessingNullReceiptEmailNullReviewNullSetupFutureUsageNullShippingNullSourceNullStatementDescriptorNullStatementDescriptorSuffixNullStatusRequiresPaymentMethodTransferDataNullTransferGroupNull(
    Map<String, dynamic> json,
  ) {
    return AmountDetails(
      tip: json['tip'] == null
          ? null
          : Tip.fromJson(json['tip'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'tip': tip?.toJson()};
  }

  static fromJson(data) {}
}
