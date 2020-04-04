# save_feedback.rb
# frozen_string_literal: true

require_relative 'thread_response'

def save_feedback(token_slack, token_monday, share_feedback, payload)
  @token_slack = token_slack
  @token_monday = token_monday
  @share_feedback = share_feedback
  @payload = payload
  @user_id = payload['user']['id']

  Thread.new do
    retrive_modal_data
    save_on_monday ? post_thread : post_error_thread
  end

  response.body = ''
  response
end

def retrive_modal_data
  @feedback = {
    summary: @payload['view']['state']['values']['summary']['input']['value'],
    details: @payload['view']['state']['values']['details']['input']['value'],
    feedback_from: @payload['view']['state']['values']['feedback_from']['input']['selected_option']['value'],
    importance: @payload['view']['state']['values']['importance']['input']['selected_option']['value'],
    client_name: @payload['view']['state']['values']['client_name']['input']['value']
  }
end

def save_on_monday
  column_values = JSON.generate(
    dropdown: { labels: [@feedback[:feedback_from]] },
    status7: { label: @feedback[:importance] },
    text: @feedback[:client_name]
  )

  save_item = HTTP.auth(@token_monday)
            .headers('content-type' => 'application/json')
            .post('https://api.monday.com/v2/', json:
              { "query": "mutation($columns: JSON!)\
                { create_item (
                  board_id: #{@share_feedback.board_id},
                  group_id: #{@share_feedback.new_items_group},
                  item_name: \"#{@feedback[:summary]}\",
                  column_values: $columns
                  ){name id column_values {id value}}}",
                "variables": { "columns": column_values } })

  item_id = JSON.parse(save_item.body)['data']['create_item']['id']

  save_details = HTTP.auth(@token_monday)
            .headers('content-type' => 'application/json')
            .post('https://api.monday.com/v2/', json:
              { "query": "mutation{ create_update (
                  item_id: #{item_id},
                  body: \"#{@feedback[:details]}\"
                  ){id}}" })

  return true if save_item.status == 200 && save_details.status == 200

  @monday_response = "Item: #{JSON.parse(save_item.body)} - Update: #{save_details.body}"
  return false
end

def post_thread
  message_data = @payload['view']['private_metadata'].match(/(.*)\|(.*)/)

  res = HTTP.auth("Bearer #{@token_slack}")
      .headers('content-type' => 'application/json')
      .post('https://slack.com/api/chat.postMessage', json: thread_feedback_saved(message_data[1],message_data[2], @user_id, @feedback))
end

def post_error_thread
  message_data = @payload['view']['private_metadata'].match(/(.*)\|(.*)/)

  HTTP.auth("Bearer #{@token_slack}")
      .headers('content-type' => 'application/json')
      .post('https://slack.com/api/chat.postMessage', json: thread_error(message_data[1], message_data[2], @user_id, @monday_response))
end
