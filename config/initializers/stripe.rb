Rails.configuration.stripe = {
  :publishable_key => 'pk_test_fkB0LG0oAbOKBnsp7N8HVz58',
  :secret_key      => 'sk_test_qma69wmGccTvlgZNurRILL6n'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]