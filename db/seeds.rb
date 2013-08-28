# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  #seed weeks first - schedules contains {foreign key - week_id}

  #inserts for weeks
  @weeks_insert_file = ::Rails.root.join('db','WEEKS_INSERTS.sql')
  @weeks_statement_array = File.read(@weeks_insert_file).lines(separator=';')
  @weeks_statement_array.each do |weeks_insert_stmt|
    ActiveRecord::Base.connection.execute(weeks_insert_stmt)
  end
  #end_weeks_inserts

  #inserts for schedules - all games
  @schedules_insert_file = ::Rails.root.join('db','SCHEDULES_INSERTS.sql')
  @schedules_statement_array = File.read(@schedules_insert_file).lines(separator=';')
  @schedules_statement_array.each do |schedules_insert_stmt|
    ActiveRecord::Base.connection.execute(schedules_insert_stmt)
  end
  #end_schedules_inserts

