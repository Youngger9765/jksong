namespace :raw_vote do

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

end


namespace :raw_vote_to_vote do



end

