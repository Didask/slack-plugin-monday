# save_feedback.rb
# frozen_string_literal: true

require_relative 'thread_response'

def save_feedback(token_slack, token_monday, feature, payload)
  @token_slack = token_slack
  @token_monday = token_monday
  @payload = payload
  @user_id = @payload['user']['id']

  Thread.new do
    retrive_modal_data(feature)
    save_on_monday(feature).status == 200 ? post_thread : post_error_thread
  end

  response.body = ''
  response
end

def retrive_modal_data(feature)
  @summary = @payload['view']['state']['values']['summary']['input']['value']

  puts JSON.pretty_generate(@payload['view'])

  @feedback_from = @payload['view']['state']['values']['dropdown']['input']['value']
  @importance = @payload['view']['state']['values']['status7']['input']['value']

  # MAKE RETRIEVE BASED ON CONFIG
  # SAVE COLUMNS ON MONDAY
end

def save_on_monday(feature)
  HTTP.auth(@token_monday)
      .headers('content-type' => 'application/json')
      .post('https://api.monday.com/v2/', json:
        { "query": "mutation{ create_item (
          board_id: #{feature.board_id},
          group_id: #{feature.new_items_group},
          item_name: \"#{@summary}\",
          columns_values: {
            dropdown: \"#{@feedback_from}\",
            status7: \"#{@importance}\"
          }){id}}" })
end

def post_thread
  message_data = @payload['view']['private_metadata'].match(/(.*)\|(.*)/)

  HTTP.auth("Bearer #{@token_slack}")
      .headers('content-type' => 'application/json')
      .post('https://slack.com/api/chat.postMessage', json: thread_feedback_saved(message_data[1],message_data[2], @user_id))
end

def post_error_thread
  message_data = @payload['view']['private_metadata'].match(/(.*)\|(.*)/)

  HTTP.auth("Bearer #{@token_slack}")
      .headers('content-type' => 'application/json')
      .post('https://slack.com/api/chat.postMessage', json: thread_error(message_data[1], message_data[2], @user_id, @monday_response['status']))
end
