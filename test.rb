require 'sequel'
require 'sidekiq'
require 'sqlite3'
require 'new_relic/agent/method_tracer'
NewRelic::Agent.manual_start(:sync_startup => true)



# database = Sequel.sqlite('database.sqlite3') 
# database.run "CREATE TABLE people (id integer primary key autoincrement, name varchar(255))"
#print database[:people].select.to_a
# database.run "INSERT INTO people(name) VALUES('Foo')"
# database.run "INSERT INTO people(name) VALUES('Bar')"
# database.run "INSERT INTO people(name) VALUES('Baz')"
# results =  database.fetch "SELECT * from people;"
# puts results.to_a
# class TestClass
#   include ::NewRelic::Agent::Instrumentation::ControllerInstrumentation
#   def start
#   	puts x
#   end
#   add_transaction_tracer :start, :category => :task
# end

# TestClass.new.start

class BackgroundTask
	include Sidekiq::Worker
	def perform
		database = Sequel.sqlite('database.sqlite3')
		results = database.fetch "SELECT * from people;" 
		puts results.to_a
	end

end

BackgroundTask.perform_async

# class DatabaseClient
# 	include ::NewRelic::Agent::Instrumentation::ControllerInstrumentation
# 	def begin
# 		database = Sequel.sqlite('database.sqlite3')
# 		results = database.fetch "SELECT * from people;" 
# 		puts results.to_a
# 	end
# 	add_transaction_tracer :begin, :category => :task
# end

# DatabaseClient.new.begin