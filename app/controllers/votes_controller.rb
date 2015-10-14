class VotesController < ApplicationController

before_action :authenticate_user!

before_action :set_vote, :only => [:show, :edit, :update]

  def index
    @votes = Vote.all
  end

  def show
    
  end

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.save
    flash[:notice] = "新增成功的訊息"
    redirect_to votes_path
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



  private

  def vote_params
    params.require(:vote).permit(:content, :result)
  end

  def set_vote
    @vote = Vote.find(params[:id])
  end

end
