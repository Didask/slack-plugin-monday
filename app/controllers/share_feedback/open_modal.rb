# open_modal.rb
# frozen_string_literal: true

require_relative 'modal_feedback'

def open_modal(token_slack, payload)
  channel_id = payload['channel']['id']
  message_ts = payload['message_ts']
  message_initial_value = payload['message']['text']

  view_data = modal_feedback(channel_id, message_ts, message_initial_value)

  HTTP.auth("Bearer #{token_slack}")
      .headers('content-type' => 'application/json')
      .post('https://slack.com/api/views.open', json:
        { "trigger_id": payload['trigger_id'].to_s,
          "view": view_data })
end
