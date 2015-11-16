require 'spec_helper'
describe MyController do
  login_user

  it 'should have a current_user' do
    # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
    subject.current_user.should_not be_nil
  end
end
