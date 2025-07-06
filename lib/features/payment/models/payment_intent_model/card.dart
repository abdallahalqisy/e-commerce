class Card {
  dynamic installments;
  dynamic mandateOptions;
  dynamic network;
  String? requestThreeDSecure;

  Card({
    this.installments,
    this.mandateOptions,
    this.network,
    this.requestThreeDSecure,
  });

  factory Card.fromIdPi3MtwBwLkdIwHu7ix28a3tqPaObjectPaymentIntentAmount2000AmountCapturable0AmountDetailsTipAmountReceived0ApplicationNullApplicationFeeAmountNullAutomaticPaymentMethodsEnabledTrueCanceledAtNullCancellationReasonNullCaptureMethodAutomaticClientSecretPi3MtwBwLkdIwHu7ix28a3tqPaSecretYrKjuKribcBjcG8HVhfZluoGhConfirmationMethodAutomaticCreated1680800504CurrencyUsdCustomerNullDescriptionNullLastPaymentErrorNullLatestChargeNullLivemodeFalseMetadataNextActionNullOnBehalfOfNullPaymentMethodNullPaymentMethodOptionsCardInstallmentsNullMandateOptionsNullNetworkNullRequestThreeDSecureAutomaticLinkPersistentTokenNullPaymentMethodTypesCardLinkProcessingNullReceiptEmailNullReviewNullSetupFutureUsageNullShippingNullSourceNullStatementDescriptorNullStatementDescriptorSuffixNullStatusRequiresPaymentMethodTransferDataNullTransferGroupNull(
    Map<String, dynamic> json,
  ) {
    return Card(
      installments: json['installments'] as dynamic,
      mandateOptions: json['mandate_options'] as dynamic,
      network: json['network'] as dynamic,
      requestThreeDSecure: json['request_three_d_secure'] as String?,
    );
  }

  Map<String, dynamic>
  toIdPi3MtwBwLkdIwHu7ix28a3tqPaObjectPaymentIntentAmount2000AmountCapturable0AmountDetailsTipAmountReceived0ApplicationNullApplicationFeeAmountNullAutomaticPaymentMethodsEnabledTrueCanceledAtNullCancellationReasonNullCaptureMethodAutomaticClientSecretPi3MtwBwLkdIwHu7ix28a3tqPaSecretYrKjuKribcBjcG8HVhfZluoGhConfirmationMethodAutomaticCreated1680800504CurrencyUsdCustomerNullDescriptionNullLastPaymentErrorNullLatestChargeNullLivemodeFalseMetadataNextActionNullOnBehalfOfNullPaymentMethodNullPaymentMethodOptionsCardInstallmentsNullMandateOptionsNullNetworkNullRequestThreeDSecureAutomaticLinkPersistentTokenNullPaymentMethodTypesCardLinkProcessingNullReceiptEmailNullReviewNullSetupFutureUsageNullShippingNullSourceNullStatementDescriptorNullStatementDescriptorSuffixNullStatusRequiresPaymentMethodTransferDataNullTransferGroupNull() {
    return {
      'installments': installments,
      'mandate_options': mandateOptions,
      'network': network,
      'request_three_d_secure': requestThreeDSecure,
    };
  }
}
