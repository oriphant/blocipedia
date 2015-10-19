class RegistrationsController < Devise::RegistrationsController
  protected

  # def after_sign_up_path_for(resource)
  #   if current_user.signed_up_as_premium?
  #     new_charges_path
  #   end
  # end
end
