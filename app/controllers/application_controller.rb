class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers
  include CanCan::ControllerAdditions
end
