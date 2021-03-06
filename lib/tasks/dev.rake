namespace :dev do

  task :regenerate_user_token => :environment do
    User.all.each do |u|
      puts "User: #{u.id}"
      u.authentication_token = Devise.friendly_token
      u.save
    end
  end

  task :fetch_raw_vote => :environment do
    puts "fetching raw_vote"

    url = "http://vote.ly.g0v.tw/api/vote/?page=1"
    raw_content = RestClient.get(url)
    data = JSON.parse( raw_content )

    while data["next"] != nil
       data["results"].each do |r|

        RawVote.create( :url => r["url"],
                        :uid => r["uid"],
                        :sitting_id => r["sitting_id"],
                        :vote_seq => r["vote_seq"],
                        :content => r["content"],
                        :conflict => r["conflict"],
                        :results => r["results"],
                        :result => r["result"])
      end
        url = data["next"]
        raw_content = RestClient.get(url)
        data = JSON.parse( raw_content )
    end
  end

  task :fetch_raw_legislator => :environment do
    puts "fetching raw_lagisltor"

    url = "http://vote.ly.g0v.tw/api/legislator_terms/"
    raw_content = RestClient.get(url)
    data = JSON.parse( raw_content )

    while data["next"] != nil 
      puts url

      data["results"].each do |r|
        RawLegislator.create( :url => r["url"],
                        :le_id => r["id"],
                        :legislator => r["legislator"],
                        :ad => r["ad"],
                        :name => r["name"],
                        :county => r["county"],
                        :gender => r["gender"],
                        :party => r["party"],
                        :in_office => r["in_office"],
                        :education => r["education"],
                        :experience => r["experience"],
                        :image => r["image"])  
      end
        url = data["next"]
        raw_content = RestClient.get(url)
        data = JSON.parse( raw_content )
    end
  end

  task :fetch_raw_legislators_votes => :environment do
    puts "fetching raw_lagisltor_votes"

    url = "http://vote.ly.g0v.tw/api/legislator_vote/?page=10205"
    raw_content = RestClient.get(url)
    data = JSON.parse( raw_content )

    while data["next"] != nil 
      puts url

      data["results"].each do |r|

        RawLegislatorVote.create( :url =>r["url"],
                              :decision => r["decision"],
                              :conflict => r["conflict"],
                              :legislator => r["legislator"],
                              :vote => r["vote"])
      end

      url = data["next"]
      raw_content = RestClient.get(url)
      data = JSON.parse( raw_content )   
    end
  end
end

namespace :transfer do
  task :transfer_vote => :environment do
    RawVote.all.each do |r|

      Vote.create(  :url => r[:url],
                    :uid => r[:uid],
                    :original_content => r[:content],
                    :conflict => r[:conflict],
                    :result => r[:result])
    end
  end  

  task :transfer_legislator_8_party => :environment do
    RawLegislator.where(:ad => 8).each do |r|
      if Legislator.find_by_name(r[:name])
        le = Legislator.find_by_name(r[:name])
        le.party = r[:party]
        le.save!
        puts Legislator.find_by_name(r[:name]).try(:party)
      end
    end
  end


  task :transfer_legislator_8 => :environment do
    RawLegislator.where(:ad => 8).each do |r|

        Legislator.create(  :url => r[:url],
                            :le_id => r[:le_id],
                            :legislator => r[:legislator],
                            :ad => r[:ad],
                            :name => r[:name],
                            :county => r[:county],
                            :gender => r[:gender],
                            :party => r[:party],
                            :in_office => r[:in_office],
                            :education => r[:education],
                            :experience => r[:experience],
                            :image => r[:image])

    end
  end  

  task :transfer_legislator_vote => :environment do
    
    Legislator.all.each do |le|
      legislator_id = le.id
      puts le.id
      raw_datas = RawLegislatorVote.where(:legislator => le.url)

      raw_datas.all.each do |r|
        if Vote.find_by_url(r.vote) != nil
          vote_id = Vote.find_by_url(r.vote).id
        end

        LegislatorVoteShip.create(  :legislator_id => legislator_id,
                                    :vote_id => vote_id,
                                    :decision => r[:decision],
                                    :conflict => r[:conflict])  
      end
    end
  end  
end

namespace :refresh do
  task :legislator_party_logo => :environment do
    Legislator.all.each do |le|
      le.party_logo = nil
      le.save!
    end

  end
end


namespace :update do
  task :legislator_party_logo => :environment do
    puts "updating"
    Legislator.all.each do |le|
      if le.party =="中國國民黨"
        le.party_logo = "http://attach.kmt.org.tw/200910/20091015163058.jpg"
        le.save!
      elsif le.party == "民主進步黨"
        le.party_logo = "https://upload.wikimedia.org/wikipedia/zh/thumb/c/c1/Emblem_of_Democratic_Progressive_Party_(new).svg/1024px-Emblem_of_Democratic_Progressive_Party_(new).svg.png"
        le.save!
      elsif le.party == "民國黨"
        le.party_logo = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/Flag_of_Minkuotang.svg/125px-Flag_of_Minkuotang.svg.png"
        le.save!
      elsif le.party == "無黨團結聯盟"
        le.party_logo = "https://upload.wikimedia.org/wikipedia/zh/thumb/a/ac/Flag_of_NPSU.svg/125px-Flag_of_NPSU.svg.png"
        le.save!
      elsif le.party == "臺灣團結聯盟"
        le.party_logo = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/TUS.png/125px-TUS.png"
        le.save!
      elsif le.party == "親民黨"
        le.party_logo = "https://upload.wikimedia.org/wikipedia/zh/thumb/6/66/Flag_of_People_First_Party.svg/125px-Flag_of_People_First_Party.svg.png"
        le.save!
      end
    end
  end
end

