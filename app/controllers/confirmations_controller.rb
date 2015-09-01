class ConfirmationsController < Devise::ConfirmationsController


  # def show
  #   p "nnnnnn"
  #   with_unconfirmed_confirmable do
  #     if @confirmable.has_no_password?
  #       do_show
  #     else
  #       do_confirm
  #     end
  #   end
  #   p @confirmable.confirmation_token
  #   if @confirmable.errors.present?
  #     self.resource = @confirmable
  #     render 'devise/confirmations/new' #Change this if you don't have the views on default path
  #   end
  # end

  # protected

  # def with_unconfirmed_confirmable
  #   original_token = params[:confirmation_token]
  #   confirmation_token = Devise.token_generator.digest(User, :confirmation_token, original_token)
  #   @confirmable = User.find_or_initialize_with_error_by(:confirmation_token, confirmation_token)
  #   if !@confirmable.new_record?
  #     @confirmable.only_if_unconfirmed {yield}
  #   end
  # end

  # def do_show
  #   @confirmation_token = params[:confirmation_token]
  #   @requires_password = true
  #   self.resource = @confirmable
  #   render 'devise/confirmations/show' #Change this if you don't have the views on default path
  # end

  # def do_confirm
  #   @confirmable.confirm!
  #   set_flash_message :notice, :confirmed
  #   sign_in_and_redirect(resource_name, @confirmable)
  # end


end
