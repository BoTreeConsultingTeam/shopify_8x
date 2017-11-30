ShopifyApp.configure do |config|
  config.application_name = "My Shopify App"
  config.api_key = ENV['SHOPIFY_CLIENT_API_KEY'] || "818100ec4bda9e47619813b52be0f4fb"
  config.secret = ENV['SHOPIFY_CLIENT_API_SECRET'] || "24ab6bca16609c0a2dc575a46a844327"
  config.scope = "read_orders, read_products"
  config.embedded_app = true
  config.after_authenticate_job = false
  config.session_repository = Shop
end
