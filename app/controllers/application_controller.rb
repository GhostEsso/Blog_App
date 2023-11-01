class ApplicationController < ActionController::Base
  # Create current_user method to temporary return the first user from the database
  def current_user
    @first_user = User.first
  end
end
