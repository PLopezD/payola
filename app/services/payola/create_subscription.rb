module Payola
  class CreateSubscription
    def self.call(params)
      plan = params[:plan]
      affiliate = params[:affiliate]

      Payola::Subscription.new do |s|
        s.plan = plan
        s.email = params[:stripeEmail]
        s.stripe_token = params[:stripeToken]
        s.affiliate_id = affiliate.try(:id)
        s.currency = plan.respond_to?(:currency) ? plan.currency : Payola.default_currency
        s.coupon = params[:coupon]
        #s.signed_custom_fields = params[:signed_custom_fields]

        s.amount = plan.amount
      end
    end
  end
end
