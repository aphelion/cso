include SessionsConcern

class UsersController < ApplicationController
  before_action :logged_in_user, only: [:tickets]

  def tickets
  end
end
