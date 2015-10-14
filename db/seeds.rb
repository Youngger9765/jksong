# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
categories = Category.create([{ name: '司法/法制' }, { name: '外交/國防' }, 
                              { name: '內政' }, { name: '財政' }, 
                              { name: '經濟' }, { name: '交通' },
                              { name: '教育/文化' }, { name: '社福/衛環' }])