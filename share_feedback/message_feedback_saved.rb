# message_feedback_saved.rb
# frozen_string_literal: true

def message_feedback_saved(channel_id, message_ts)
  {
    'channel': channel_id,
    'thread_ts': message_ts,
    'blocks': [
      {
        'type': 'section',
        'text': {
          'type': 'mrkdwn',
          'text': ':pushpin: Feedback added to our list.'
        }
      },
      {
        'type': 'section',
        'text': {
          'type': 'mrkdwn',
          'text': ">*Summary*\n>Description\n>--------------\n>This is a feedback from :fox_face: *Client*\n>Importance: :space_invader: *Information*\n>Created by User Name"
        }
      },
      {
        'type': 'divider'
      },
      {
        'type': 'actions',
        'elements': [
          {
            'type': 'button',
            'text': {
              'type': 'plain_text',
              'text': 'Go to all feedbacks  :speech_balloon:',
              'emoji': true
            },
            'value': 'click_me_123'
          }
        ]
      }
    ]
  }
end
