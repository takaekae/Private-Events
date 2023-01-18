class AttendingsController < ApplicationController

  before_action :authenticate_user!

  # check the attending does not already exist
  def create
    if Attending.find_by(attending_params).nil?
      @attending = Attending.new(attending_params)

      respond_to do |format|
        if @attending.save
          format.html { redirect_to my_events_path, notice: "You are attending this event!" }
        else
          format.html { redirect_to my_events_path, alert: "An error occured." }
        end
      end
    else
      flash.alert = 'You are already attending.'
      redirect_to my_events_path
    end
  end

  # to prevent errors, check if record exists
  # check destroy worked and notify
  def destroy
    @attending = Attending.find_by(attending_params)
    if @attending.nil?
      flash.alert = "This event attendance does not exist"
    elsif @attending.destroy
      flash.notice = "You are no longer attending this event."
    else
      flash.alert = "Error - attendance was not deleted."
    end
    redirect_to my_events_path
  end
  
  private

  def attending_params
    params.permit(:attendee_id, :attended_event_id)
  end

end