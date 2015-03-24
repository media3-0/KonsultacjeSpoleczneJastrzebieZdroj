# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user = User.new
user.email = "jakub.nekro@gmail.com"
user.encrypted_password = "$2a$10$J8mwiZFRz7WS7Ghoe1.G3ecl.nFssx4ch0mPHiUJuLfRCjQlewYp6"
user.admin = true
user.save!