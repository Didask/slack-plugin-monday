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

  put '/update_feature' do
    @feature = Feature.find_by(feature_name: params['feature']['feature_name'])
    @feature.update(params['feature'])

    redirect "/feature_#{@feature.feature_name}?#feature_name=#{@feature.feature_name}"
  end

  get '/feature_share_feedback' do
    @feature = Feature.find_by(feature_name: 'share_feedback')
    @boards = get_boards(ENV['MONDAY_API_TOKEN'])

    if !@feature.board_id.nil?
      @columns = get_columns(ENV['MONDAY_API_TOKEN'], @feature.board_id)
      @groups = get_groups(ENV['MONDAY_API_TOKEN'], @feature.board_id)
      # @board_name = get_boards_name(ENV['MONDAY_API_TOKEN'], @feature.board_id)
    else
      @columns = nil
      @groups = nil
      # @board_name = nil
    end

    erb :feature_share_feedback
  end
end
