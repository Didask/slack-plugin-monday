# open_modal.rb
# frozen_string_literal: true

require_relative 'modal_feedback'

def open_modal(token_slack, payload)
  channel_id = payload['channel']['id']
  message_ts = payload['message_ts']
  message_initial_value = payload['message']['text']

  view_data = modal_feedback(channel_id, message_ts, prep_blocks(message_initial_value))

  # puts JSON.pretty_generate(view_data)

  res = HTTP.auth("Bearer #{token_slack}")
      .headers('content-type' => 'application/json')
      .post('https://slack.com/api/views.open', json:
        { "trigger_id": payload['trigger_id'].to_s,
          "view": view_data })
end

def prep_blocks(message_initial_value)
  feature = Feature.find_by(feature_name: 'share_feedback')

  blocks = []
  feature.blocks.each { |_column, column_info|
    block_content = column_info['modal_block'].tr("\n", '').tr("\r", '').split.join(' ')
    block_content.gsub!('##message_initial_value##', message_initial_value)
    blocks.unshift JSON.parse(block_content) unless block_content == ''
  }

  blocks
end
