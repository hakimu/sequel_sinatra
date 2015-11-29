require 'unicorn'
require 'sequel'
require 'sinatra'
require 'newrelic_rpm'

get '/' do
	"mic check"
end

get '/foo' do
	"foo"
end
