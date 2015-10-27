# TODO: remove
class VotesController < ApplicationController

before_action :authenticate_user!

before_action :set_vote, :only => [:show, :edit, :update]

  def index
    @votes = Vote.all
    @raw_votes = RawVote.all

    if params[:vote_id]
      @vote = Vote.find( params[:vote_id] )
    else
      @vote = Vote.new
    end
  end

  def show
    
  end

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.user = current_user

    if @vote.save
      flash[:notice] = "Create Success!"
      redirect_to votes_path
    else
      flash[:alert] = "Create fail!"
      render votes_path
    end
  end

  def edit

  end

  def update
    
    if @vote.update(vote_params)
      flash[:notice] = "event was successfully updated"
      redirect_to vote_path(@vote)
    else
      render "edit"
    end
  end

  def about
    @users = User.all
    @issues = Issue.all
    @votes = Vote.all 
  end



  private

  def vote_params
    params.require(:vote).permit(:category_id, :user_id, :original_content, :result, :new_content)
  end

  def set_vote
    @vote = Vote.find(params[:id])
  end

end
