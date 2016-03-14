include SessionsConcern

class TicketsController < ApplicationController
  before_action :logged_in_user

  def status
  end
end
