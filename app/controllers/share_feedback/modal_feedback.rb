# modal_feedback.rb

def modal_feedback(channel_id, message_ts, blocks)
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
    'blocks': blocks
  }
end
