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

  get '/didask' do
    @didaskbot_features = [{ name: 'share_feedback', type: :action, require: { modal: true } },{ name: 'share_feedback', type: :action, require: { modal: true } }]

    @boards = get_boards(ENV['MONDAY_API_TOKEN'])

    erb :index
  end

  post '/prepare_monday' do
    @board_id = params['board_id']
    redirect "/board/#{@board_id}"
  end

  get '/board/:id' do
    @board_id
  end
end
