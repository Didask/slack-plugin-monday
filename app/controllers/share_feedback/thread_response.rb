# message_feedback_saved.rb
# frozen_string_literal: true

def thread_feedback_saved(channel_id, message_ts, user_id, feedback)
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
          'text': "*#{feedback[:summary]}*\n#{feedback[:details]}\n>This is a feedback from *#{feedback[:feedback_from]}* #{'-*' + feedback[:client_name] + '*' unless feedback[:client_name].nil?}\n\n>Importance: *#{feedback[:importance]}*\n>Created by <@#{user_id}>"
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
            'url': 'https://view.monday.com/497735152-0318577eb437200a372eb69aabf07ebb'
          }
        ]
      }
    ]
  }
end

def thread_error(channel_id, message_ts, user_id, error_message)
  {
    'channel': channel_id,
    'thread_ts': message_ts,
    'blocks': [
      {
        'type': 'section',
        'text': {
          'type': 'mrkdwn',
          'text': "<@#{user_id}>, something went wrong while saving your feedback\n> Error message: #{error_message}\n> -> <@USDK5AGD9>"
        }
      }
    ]
  }
end
