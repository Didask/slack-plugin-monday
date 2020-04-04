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

    share_feedback = Feature.new(
      name: 'share_feedback',
      board_id: ENV['MONDAY_FEEDBACK_BOARD_ID'],
      new_items_group: top_group_id(
        ENV['MONDAY_API_TOKEN'],
        ENV['MONDAY_FEEDBACK_BOARD_ID']
      )
    )

    case payload['type']
    when 'message_action'
      open_modal(ENV['SLACK_API_TOKEN'], payload)

    when 'view_submission'
      save_feedback(
        ENV['SLACK_API_TOKEN'],
        ENV['MONDAY_API_TOKEN'],
        share_feedback,
        payload
      )
    end
  end
end
