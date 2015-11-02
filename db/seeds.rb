# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
categories = Category.create([{ name: '司法/法制', english_name: 'law'}, 
                              { name: '外交/國防', english_name: 'diplomacy' }, 
                              { name: '內政', english_name: 'interior' }, 
                              { name: '財政', english_name: 'finance' }, 
                              { name: '經濟', english_name: 'economy' }, 
                              { name: '交通', english_name: 'traffic' },
                              { name: '教育/文化', english_name: 'education' }, 
                              { name: '社福/衛環', english_name: 'social' }])

location = Location.create([{ name: "基隆市"},{ name: "臺北市"},
                            { name: "新北市"},{ name: "桃園市"},
                            { name: "新竹市"},{ name: "新竹縣"},
                            { name: "苗栗縣"},{ name: "臺中市"},
                            { name: "南投縣"},{ name: "彰化縣"},
                            { name: "雲林縣"},{ name: "嘉義市"},
                            { name: "嘉義縣"},{ name: "臺南市"},
                            { name: "屏東縣"},{ name: "宜蘭縣"},
                            { name: "花蓮縣"},{ name: "臺東縣"},
                            { name: "澎湖縣"},{ name: "金門縣"},
                            { name: "連江縣"}])