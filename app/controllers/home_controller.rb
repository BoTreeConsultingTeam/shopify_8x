class HomeController < ShopifyApp::AuthenticatedController
  def index
    charge = ShopifyAPI::RecurringApplicationCharge.current
    # Check if there is a charge present
	  if charge
      if charge.status == 'pending'
        redirect_to charge.confirmation_url
      elsif charge.status == 'active'
        @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})
        @orders = ShopifyAPI::Order.find(:all, :params => {:limit => 10})
      end
    else
      # If there is no charge, bill him
      redirect_to billing_index_path
    end
  end
end
