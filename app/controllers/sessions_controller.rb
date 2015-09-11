#
# SessionsController -
#
# @author [Joice]
#
class SessionsController < Devise::SessionsController
  layout 'signin'

  def destroy
    super
  end
end
