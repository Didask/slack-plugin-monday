# app.rb
# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'http'
require 'json'

require 'dotenv'
Dotenv.load

# Routes
class App < Sinatra::Base
  set :views, File.join(__dir__, 'app', 'views')

  post '/share_feedback' do
    payload = JSON.parse(params[:payload])

    if payload['type'] == 'message_action'
      open_modal(ENV['SLACK_API_TOKEN'], payload)

    elsif payload['type'] == 'view_submission'
      save_feedback(ENV['SLACK_API_TOKEN'], ENV['MONDAY_API_TOKEN'], ENV['MONDAY_FEEDBACK_BOARD_ID'], payload)
    end
  end

  get '/config' do
    @didaskbot_features = Feature.all

    @boards = get_boards(ENV['MONDAY_API_TOKEN'])

    erb :index
  end

  post '/new_feature' do
    new_feature = params['new_feature']
    Feature.create(
      feature_name: new_feature['name'],
      feature_type: new_feature['type']
    )

    redirect '/config'
  end

  post '/board_updated' do
    feature = Feature.find

    feature_info = params['feature'].map { |key, value| "#{key}=#{value}" }.join('&')
    redirect "/feature_#{params['feature']['name']}?#{feature_info}"
  end

  get '/feature_share_feedback' do
    @feature = params
    @columns = get_columns(ENV['MONDAY_API_TOKEN'], @feature['board_id'])

    erb :feature_share_feedback
  end
end

def show_params
  p params
end
