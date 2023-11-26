class SubscriptionsController < ApplicationController
  def create
    email = params[:email]
    # Logic to handle the subscription (e.g., saving the email to a database)
    Subscriber.create(email: email)
    # Redirect or render a response
    redirect_to root_path, notice: "Thank you for subscribing!"
  end
end
