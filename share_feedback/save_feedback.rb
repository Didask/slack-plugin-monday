# save_feedback.rb
# frozen_string_literal: true

require_relative 'message_feedback_saved'

def save_feedback(token_slack, token_monday, board_id, payload)
  @token_slack = token_slack
  @token_monday = token_monday
  @board_id = board_id
  @payload = payload

  Thread.new do
    retrive_modal_data
    save_on_monday
    post_thread
  end

  response.body = ''
  response
end

def retrive_modal_data
  @summary = @payload['view']['state']['values']['summary']['input']['value']
end

def save_on_monday
  HTTP.auth(@token_monday)
      .headers('content-type' => 'application/json')
      .post('https://api.monday.com/v2/', json:
        { "query": "mutation{ create_item (board_id: 485987910, group_id: \"topics\", item_name: \"#{@summary}\"){id}}" })
end

def post_thread
  message_data = @payload['view']['private_metadata'].match(/(.*)\|(.*)/)

  HTTP.auth("Bearer #{@token_slack}")
      .headers('content-type' => 'application/json')
      .post('https://slack.com/api/chat.postMessage', json: message_feedback_saved(message_data[1],message_data[2]))
end
