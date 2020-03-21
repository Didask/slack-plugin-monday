# modal_feedback.rb

def modal_feedback(channel_id, message_ts, message_initial_value)
  {
    'type': 'modal',
    'callback_id': 'modal-identifier',
    'private_metadata': "#{channel_id}|#{message_ts}",
    'title': {
      'type': 'plain_text',
      'text': 'Share a feedback'
    },
    'submit': {
      'type': 'plain_text',
      'text': 'Submit',
      'emoji': true
    },
    'close': {
      'type': 'plain_text',
      'text': 'Cancel',
      'emoji': true
    },
    'blocks': [
      {
        'type': 'input',
        'block_id': 'summary',
        'element': {
          'type': 'plain_text_input',
          'action_id': 'input'
        },
        'label': {
          'type': 'plain_text',
          'text': 'Summarize in one line',
          'emoji': true
        }
      },
      {
        'type': 'input',
        'block_id': 'details',
        'element': {
          'type': 'plain_text_input',
          'multiline': true,
          'initial_value': message_initial_value,
          'action_id': 'input'
        },
        'label': {
          'type': 'plain_text',
          'text': 'Details',
          'emoji': true
        }
      },
      {
        'type': 'section',
        'text': {
          'type': 'mrkdwn',
          'text': 'This is a feedback from...'
        },
        'accessory': {
          'type': 'static_select',
          'placeholder': {
            'type': 'plain_text',
            'text': 'Select an item',
            'emoji': true
          },
          'options': [
            {
              'text': {
                'type': 'plain_text',
                'text': 'Client',
                'emoji': true
              },
              'value': 'value-0'
            },
            {
              'text': {
                'type': 'plain_text',
                'text': 'Internal',
                'emoji': true
              },
              'value': 'value-1'
            },
            {
              'text': {
                'type': 'plain_text',
                'text': 'Other',
                'emoji': true
              },
              'value': 'value-2'
            }
          ]
        }
      },
      {
        'type': 'section',
        'text': {
          'type': 'mrkdwn',
          'text': 'Importance'
        },
        'accessory': {
          'type': 'static_select',
          'placeholder': {
            'type': 'plain_text',
            'text': 'Select an item',
            'emoji': true
          },
          'options': [
            {
              'text': {
                'type': 'plain_text',
                'text': 'Nice to have',
                'emoji': true
              },
              'value': 'value-0'
            },
            {
              'text': {
                'type': 'plain_text',
                'text': 'Important',
                'emoji': true
              },
              'value': 'value-1'
            },
            {
              'text': {
                'type': 'plain_text',
                'text': 'Critical',
                'emoji': true
              },
              'value': 'value-2'
            },
            {
              'text': {
                'type': 'plain_text',
                'text': 'Information',
                'emoji': true
              },
              'value': 'value-3'
            }
          ]
        }
      }
    ]
  }
end
