require 'unicorn'
require 'sequel'
require 'sinatra'
require 'newrelic_rpm'

get '/' do
	"Home route"
end

