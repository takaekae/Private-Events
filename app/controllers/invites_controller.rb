class InvitesController < ApplicationController
  before_action :authenticate_user!

  def create
    @invite = Invite.new(invite_params)

    respond_to do |format|
      if @invite.save
        format.html { redirect_to event_path(invite_params[:event_id]), notice: "Invite sent!" }
      else
        format.html { redirect_to root_path, status: :unprocessable_entity }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  # to prevent errors, check if record exists
  # check destroy worked and notify
  def destroy
    @invite = Invite.find_by(invite_params)
    if @invite.nil?
      flash.alert = "This invite does not exist"
    elsif @invite.destroy
      flash.notice = "Invite removed."
    else
      flash.alert = "Error - invite was not deleted."
    end
    redirect_to my_events_path
  end
  
  private

  def invite_params
    # no require method here because I am not using an invite#new object above
    params.permit(:event_id, :invitee_id, :inviter_id)
  end

end