class ViewingPartiesController < ApplicationController
  def new
    @facade = MovieFacade.new(params[:movie_id])
  end

  def create
    @host = User.find(current_user.id)
    viewing_party = ViewingParty.new({
      duration: params[:duration],
      date: params[:date],
      start_time: params[:start_time],
      movie_id: params[:movie_id],
      movie_duration: params[:movie_duration]
      })

    if viewing_party.save
      UserParty.create({user_id: @host.id, viewing_party_id: viewing_party.id, host: true})
      redirect_to user_path(@host)
      
      if params[:email_address1].present? && User.find_by(email: params[:email_address1])
        UserParty.create({user_id: User.find_by(email: params[:email_address1]).id, viewing_party_id: viewing_party.id, host: false})
      elsif params[:email_address2].present? && User.find_by(email: params[:email_address2])
        UserParty.create({user_id: User.find_by(email: params[:email_address2]).id, viewing_party_id: viewing_party.id, host: false})
      elsif params[:email_address3].present? && User.find_by(email: params[:email_address3])
        UserParty.create({user_id: User.find_by(email: params[:email_address3]).id, viewing_party_id: viewing_party.id, host: false})
      end
    else
      flash[:error] = "#{error_message(viewing_party.errors)}"
      redirect_to new_movie_viewing_party_path(params[:movie_id])
    end
  end

  def show
    @facade = MovieFacade.new(params[:movie_id])
    @viewing_party = ViewingParty.find(params[:id])
  end

  # private
  # def party_params
  #   params.permit(:duration, :date, :start_time, :movie_id)
  # end
end