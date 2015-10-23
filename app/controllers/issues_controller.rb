class IssuesController < ApplicationController

  def index

      @issues = Issue.page(params[:page]).per(5)

  end

  def show
    @issue = Issue.find(params[:id])
    @profile_issue = ProfileIssueShip.where(:profile_id => current_user.profile.id).find_by_issue_id(@issue)
    @related_legislators = Legislator.joins(:profile_legislator_ships).where(:profile_legislator_ships => {:profile_id => current_user.profile.id}).order("total DESC")

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
                
              if @issue.category.name == "司法/法制"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:law] 
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:law => score)

              elsif @issue.category.name == "外交/國防"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:diplomacy] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:diplomacy => score)
 
              elsif @issue.category.name == "內政"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:interior] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:interior => score)

              elsif @issue.category.name == "財政"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:finance] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:finance => score)

              elsif @issue.category.name == "經濟"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:economy] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:economy => score)

              elsif @issue.category.name == "交通"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:traffic] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:traffic => score)

              elsif @issue.category.name == "教育/文化"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:education] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:education => score)

              elsif @issue.category.name == "社福/衛環"  
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:social] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:social => score)

              end 


            end

          elsif ProfileLegislatorShip.where(:profile_id => current_user.profile.id, :legislator_id =>le.id).first

            if LegislatorVoteShip.where(:legislator_id => le.id).find_by_vote_id(v.id) && LegislatorVoteShip.where(:legislator_id => le.id).find_by_vote_id(v.id).decision == @p.decision
              a = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:total] 
              a += 1
              ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:total => a)
                
              if @issue.category.name == "司法/法制"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:law] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:law => score)

              elsif @issue.category.name == "外交/國防"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:diplomacy] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:diplomacy => score)
 
              elsif @issue.category.name == "內政"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:interior] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:interior => score)

              elsif @issue.category.name == "財政"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:finance] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:finance => score)

              elsif @issue.category.name == "經濟"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:economy] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:economy => score)

              elsif @issue.category.name == "交通"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:traffic] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:traffic => score)

              elsif @issue.category.name == "教育/文化"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:education] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:education => score)

              elsif @issue.category.name == "社福/衛環"  
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:social] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:social => score)

              end 


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
              score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:total] 
              score += 1
              ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:total => score)
              
              if @issue.category.name == "司法/法制"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:law] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:law => score)

              elsif @issue.category.name == "外交/國防"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:diplomacy] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:diplomacy => score)
 
              elsif @issue.category.name == "內政"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:interior] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:interior => score)

              elsif @issue.category.name == "財政"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:finance] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:finance => score)

              elsif @issue.category.name == "經濟"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:economy] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:economy => score)

              elsif @issue.category.name == "交通"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:traffic] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:traffic => score)

              elsif @issue.category.name == "教育/文化"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:education] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:education => score)

              elsif @issue.category.name == "社福/衛環"  
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:social] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:social => score)

              end  

            elsif LegislatorVoteShip.where(:legislator_id => le.id).find_by_vote_id(v.id) && LegislatorVoteShip.where(:legislator_id => le.id).find_by_vote_id(v.id).decision == (@p.decision.to_i * -1).to_s
              score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:total] 
              score -= 1
              ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:total => score)
              
              if @issue.category.name == "司法/法制"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:law] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:law => score)

              elsif @issue.category.name == "外交/國防"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:diplomacy] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:diplomacy => score)
 
              elsif @issue.category.name == "內政"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:interior] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:interior => score)

              elsif @issue.category.name == "財政"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:finance] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:finance => score)

              elsif @issue.category.name == "經濟"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:economy] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:economy => score)

              elsif @issue.category.name == "交通"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:traffic] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:traffic => score)

              elsif @issue.category.name == "教育/文化"
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:education] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:education => score)

              elsif @issue.category.name == "社福/衛環"  
                score = ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id)[:social] 
                score += 1
                ProfileLegislatorShip.where(:profile_id => current_user.profile.id).find_by_legislator_id(le.id).update(:social => score)

              end 

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
    ProfileIssueShip.destroy_all
    redirect_to issue_path(params[:id])
  end


  private

  def issue_params
    params.require(:issue).permit()
  end



end
