# Rails.configuration.stripe = {
#   publishable_key: Rails.application.credentials.stripe[:publishable_key],
#   secret_key: Rails.application.credentials.stripe[:secret_key]
# }

# Stripe.api_key = Rails.configuration.stripe[:secret_key]

if Rails.application.credentials.dig(:stripe, :publishable_key).present?
  Rails.configuration.stripe = {
    publishable_key: Rails.application.credentials.dig(:stripe, :publishable_key),
    secret_key:      Rails.application.credentials.dig(:stripe, :secret_key)
  }

  Stripe.api_key = Rails.configuration.stripe[:secret_key]
else
  Rails.logger.warn("⚠️ Stripe credentials not found. Stripe will not be initialized.")
end
