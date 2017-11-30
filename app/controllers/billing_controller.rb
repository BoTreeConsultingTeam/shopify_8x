class BillingController < ShopifyApp::AuthenticatedController
  # around_filter :shopify_session
  layout 'embedded_app'

  def index
    charge = ShopifyAPI::RecurringApplicationCharge.current
    unless charge
    charge = ShopifyAPI::RecurringApplicationCharge.create(
        name: 'BoTree Basic Plan',
        price: 10,
        return_url: billing_confirm_url,
        trial_days: 3,
        test: true
      )
    end
    redirect_to charge.confirmation_url
  end

  def confirm
  	begin
      charge = ShopifyAPI::RecurringApplicationCharge.find(params[:charge_id])
      
      if charge.status == 'accepted'
  		  charge.activate
  		  redirect_to root_path
      elsif charge.status == 'declined'
        redirect_to billing_declined_path
      elsif charge.status == 'pending'
        redirect_to charge.confirmation_url
      else
        raise
      end
  	rescue => error
  		redirect_to "https://apps.shopify.com/#{ENV['SHOPIFY_APP']}"
  	end
  end

  def declined
  end
end
