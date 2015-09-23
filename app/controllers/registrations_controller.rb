class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    puts "here are the cookies"
    puts cookies
    raise
    new_charges_path
  end
end
