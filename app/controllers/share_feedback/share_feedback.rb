# open_modal.rb
# frozen_string_literal: true

require_relative 'modal_feedback'

def open_modal(token_slack, payload)
  channel_id = payload['channel']['id']
  message_ts = payload['message_ts']
  message_initial_value = payload['message']['text']

  view_data = modal_feedback(channel_id, message_ts, prep_blocks)

  res = HTTP.auth("Bearer #{token_slack}")
      .headers('content-type' => 'application/json')
      .post('https://slack.com/api/views.open', json:
        { "trigger_id": payload['trigger_id'].to_s,
          "view": view_data })

      puts JSON.pretty_generate(JSON.parse(res.body))
end

def prep_blocks
  feature = Feature.find_by(feature_name: 'share_feedback')
  blocks = []
  feature.blocks.each { |_column, column_info|
    # puts column_info['modal_block']
    blocks << column_info['modal_block'] unless column_info['modal_block'] == "" }

  puts blocks

  # FINISH BLOCK ASSEMBLY
  # PREP_BLOCKS VARIABLE

  # if blocks.include [[]]
end
