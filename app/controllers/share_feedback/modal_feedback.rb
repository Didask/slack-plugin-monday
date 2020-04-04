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
        'optional': true,
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
        'type': 'divider'
      },
      {
        'type': 'input',
        'block_id': 'importance',
        'element': {
          'type': 'static_select',
          'action_id': 'input',
          'placeholder': {
            'type': 'plain_text',
            'text': 'Select an item',
            'emoji': true
          },
          'options': [
            {
              'text': {
                'type': 'plain_text',
                'text': ':thinking_face: Nice to have',
                'emoji': true
              },
              'value': 'Nice to have'
            },
            {
              'text': {
                'type': 'plain_text',
                'text': ':star-struck: High value',
                'emoji': true
              },
              'value': 'High value'
            },
            {
              'text': {
                'type': 'plain_text',
                'text': ':rage: Blocking point',
                'emoji': true
              },
              'value': 'Blocking point'
            },
            {
              'text': {
                'type': 'plain_text',
                'text': ':space_invader: Other information',
                'emoji': true
              },
              'value': 'Other information'
            }
          ]
        },
        'label': {
          'type': 'plain_text',
          'text': 'Importance',
          'emoji': true
        }
      },
      {
        'type': 'input',
        'block_id': 'feedback_from',
        'element': {
          'type': 'static_select',
          'action_id': 'input',
          'placeholder': {
            'type': 'plain_text',
            'text': 'Select an item',
            'emoji': true
          },
          'options': [
            {
              'text': {
                'type': 'plain_text',
                'text': ':beetle: Client',
                'emoji': true
              },
              'value': 'Client'
            },
            {
              'text': {
                'type': 'plain_text',
                'text': ':didask: Internal',
                'emoji': true
              },
              'value': 'Internal'
            }
          ]
        },
        'label': {
          'type': 'plain_text',
          'text': 'This is a feedback from...',
          'emoji': true
        }
      },
      {
        'type': 'input',
        'block_id': 'client_name',
        'optional': true,
        'element': {
          'type': 'plain_text_input',
          'action_id': 'input',
          'placeholder': {
            'type': 'plain_text',
            'text': ' ',
            'emoji': true
          }
        },
        'label': {
          'type': 'plain_text',
          'text': 'Client name',
          'emoji': true
        }
      }
    ]
  }
end
