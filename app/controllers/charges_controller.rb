class ChargesController < ApplicationController

class Amount
  def self.default
    1000
  end
end

def create
  #Creates a Stripe Customer object, for associating with the charge
  
  customer = Stripe::Customer.create(
    email: current_user.email, 
    card: params[:stripeToken])

  #Where the real magic happens?
  charge = Stripe::Charge.create(
    customer: customer.id, # Note -- this is not the user_id in your app
    amount: Amount.default,
    description: "BigMoney Membership - #{current_user.email}",
    currency: 'usd'
    )

  flash[:notice] = "Thank you #{current_user.email}.  Your payment has been recieved."
  current_user.upgrade_acct
  redirect_to edit_user_registration_path

  # Stripe will send back CardErrors, with friendly messages when something goes wrong.  This 'rescue block' catches and displays those errors.

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to new_charge_path
end

def new
  @stripe_btn_data = {
    key: "#{Rails.configuration.stripe[:publishable_key]}",
    description: "BigMoney Membership - #{current_user.name}",
    amount: Amount.default
  }
end

def update
  current_user.downgrade_acct
  redirect_to edit_user_registration_path
end

end
