module Omnikassa

  CURRENCY_CODES = {
    '978' => 'euro'
  }

  PAYMENT_MEAN_BRANDS = %W{IDEAL VISA MASTERCARD MAESTRO MINITIX INCASSO ACCEPTGIRO REMBOURS}

  PAYMENT_MEAN_TYPES = %W{CREDIT_TRANSFER CARD OTHER}

  # Response code van pagina 25-27.
  RESPONSE_CODES = {
    '00' => 'Transaction success, authorization accepted.',
    '02' => 'Please call the bank because the authorization limit on the card has been exceeded.',
    '03' => 'Invalid merchant contract',
    '05' => 'Do not honor, authorization refused',
    '12' => 'Invalid transaction, check the parameters sent in the request',
    '14' => 'Invalid card number or invalid Card Security Code or Card (for MasterCard) or invalid Card Verification Value (for Visa/Maestro)',
    '17' => 'Cancellation of payment by the end user',
    '24' => 'Invalid status',
    '25' => 'Transaction not found in database',
    '30' => 'Invalid format',
    '34' => 'Fraud suspicion',
    '40' => 'Operation not allowed to this Merchant',
    '60' => 'Pending transaction',
    '63' => 'Security breach detected, transaction stopped',
    '75' => 'The number of attempts to enter the card number has been exceeded (three tries exhausted)',
    '90' => 'Acquirer server temporarily unavailable',
    '94' => 'Duplicate transaction',
    '97' => 'Request time-out; transaction refused',
    '99' => 'Payment page temporarily unavailable'
  }
end
