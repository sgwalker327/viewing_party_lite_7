class ViewingPartyController < ApplicationController
  def new
    if current_user
      @user = User.find(params[:user_id])
      @movie = MovieFacade.new.all_movie_info(params[:movie_id])
      @users = UserParty.other_users(params[:user_id])
    else
      flash[:error] = ("You must be logged in or registered to create a viewing party.")
      redirect_to user_movies_path(params[:user_id], params[:movie_id])
    end
  end

  def create
    user = User.find(params[:user_id])

    movie = MovieFacade.new.all_movie_info(params[:movie_id])
    party = Party.new(party_params)
    if party[:duration] >= movie.runtime
      party.save
      party.update(:host_id => params[:user_id])
      user_parties = UserParty.party_guests(params[:users], party.id)
      redirect_to user_path(params[:user_id])
    else 
      redirect_to new_user_movie_viewing_party_path(params[:user_id], params[:movie_id])
    end
  end

  private

  def party_params
    params.permit(:duration, :date, :time, :movie_id, :host_id)
  end
end