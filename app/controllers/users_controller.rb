class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @created_events = current_user.events.all
    @attended_events = current_user.attended_events.past_events
    @attending_events = current_user.attended_events.future_events
  end

end