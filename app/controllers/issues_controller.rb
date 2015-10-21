class IssuesController < ApplicationController

  def index

      @issues = Issue.page(params[:page]).per(5)

  end

  def show
    @issue = Issue.find(params[:id])
    @p = ProfileIssueShip.where(:profile_id => current_user.profile.id).find_by_issue_id(@issue)
    
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(issue_params)
    @issue.save
    flash[:notice] = "新增成功的訊息"
    redirect_to issues_path
  end

  def edit
    @issue = Issue.find(params[:id])
  end

  def update
    @issue = Issue.find(params[:id])
    
    if @issue.update(issue_params)
      flash[:notice] = "更新成功"
      redirect_to issue_path(@issue)
    else
      render "edit"
    end
  end

  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy
    flash[:alert] = "刪除成功"
    redirect_to :back
  end

  def user_votting
    @legislators = Legislator.all
    @profile = current_user.profile    
    @issue = Issue.find(params[:id])
    @p = ProfileIssueShip.where(:profile_id => current_user.profile.id).find_by_issue_id(@issue)
    @profile_legislator_ship = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(@legislator)

    
    if current_user && !current_user.profile.vote_issue?(@issue)
      
      ProfileIssueShip.create(:profile_id => current_user.profile.id, :issue_id => @issue.id)
      @p = ProfileIssueShip.where(:profile_id => current_user.profile.id).find_by_issue_id(@issue)

      if params[:votting] == "yes" 
        @p.update(:decision => 1)

      elsif params[:votting] == "no"
        @p.update(:decision => -1)
      else
        @p.update(:decision => 0)
      end
      flash[:notice] = "vote_finish"

      @issue.votes.each do |v|
        @legislators.each do |le|

          if !ProfileLegislatorShip.where(:profile_id => current_user.profile.id, :legislator_id =>le.id).first
            
            if LegislatorVoteShip.where(:legislator_id => le.id).find_by_vote_id(v.id) && LegislatorVoteShip.where(:legislator_id => le.id).find_by_vote_id(v.id).decision == @p.decision
              ProfileLegislatorShip.create(:profile_id => current_user.profile.id, :legislator_id =>le.id, :total => 1)  
            end

          elsif ProfileLegislatorShip.where(:profile_id => current_user.profile.id, :legislator_id =>le.id).first

            if LegislatorVoteShip.where(:legislator_id => le.id).find_by_vote_id(v.id) && LegislatorVoteShip.where(:legislator_id => le.id).find_by_vote_id(v.id).decision == @p.decision
              a = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:total] 
              a += 1
              ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:total => a)
            end  
          end

        end  
      end

    
    elsif current_user && current_user.profile.vote_issue?(@issue)
      @p = ProfileIssueShip.where(:profile_id => current_user.profile.id).find_by_issue_id(@issue)
      
      if params[:votting] == "yes"
        @p.update(:decision => 1)
        flash[:alert] = "更新為贊成"
      elsif params[:votting] == "no"
        @p.update(:decision => -1)
        flash[:alert] = "更新為反對"
      elsif params[:votting] == "clean"
        @p.update(:decision => 0)
        flash[:alert] = "更新為不表態"
      else

      end

      @issue.votes.each do |v|
        @legislators.each do |le|

          if !ProfileLegislatorShip.where(:profile_id => current_user.profile.id, :legislator_id =>le.id).first
            
            if LegislatorVoteShip.where(:legislator_id => le.id).find_by_vote_id(v.id) && LegislatorVoteShip.where(:legislator_id => le.id).find_by_vote_id(v.id).decision == @p.decision
              ProfileLegislatorShip.create(:profile_id => current_user.profile.id, :legislator_id =>le.id, :total => 1)
            end

          elsif ProfileLegislatorShip.where(:profile_id => current_user.profile.id, :legislator_id =>le.id).first

            if LegislatorVoteShip.where(:legislator_id => le.id).find_by_vote_id(v.id) && LegislatorVoteShip.where(:legislator_id => le.id).find_by_vote_id(v.id).decision == @p.decision
              a = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:total] 
              a += 1
              ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:total => a)
              
            elsif LegislatorVoteShip.where(:legislator_id => le.id).find_by_vote_id(v.id) && LegislatorVoteShip.where(:legislator_id => le.id).find_by_vote_id(v.id).decision == (@p.decision.to_i * -1).to_s
              a = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:total] 
              a -= 1
              ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:total => a)
              
            end

          end

        end  
      end


    end   
      redirect_to issue_path(params[:id])
  end

  def user_votting_destroy
    @issue = Issue.find(params[:id])
    ProfileLegislatorShip.destroy_all
    ProfileIssueShip.where(:profile_id => current_user.profile.id, :issue_id => @issue.id).destroy_all
    redirect_to issue_path(params[:id])
  end


  private

  def issue_params
    params.require(:issue).permit()
  end



end
