class ApplicationController < ActionController::Base
  include SentientController
  
  def current_user
    nil
  end

end
