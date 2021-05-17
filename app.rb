require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "cookbook"
require_relative "recipe"
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @recipes = Cookbook.new('recipes.csv').all
  erb :index
end

get '/about' do
  erb :about
end

get '/new' do
  erb :new
end

post '/create' do
  recipe = Recipe.new(params[:name], params[:description], params[:rating], params[:prep_time])
  Cookbook.new('recipes.csv').add_recipe(recipe)
  redirect '/'
end

set :bind, '0.0.0.0'
