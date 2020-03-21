# prepare_monday.rb

def get_boards(token_monday)
  res = HTTP.auth(token_monday)
      .headers('content-type' => 'application/json')
      .post('https://api.monday.com/v2/', json:
        { "query": "{boards{name id}}" })

  return JSON.parse(res.body)['data']['boards']
end


def determine_board
  puts "What board would you like to map?"
end




# select board
# change column id
# define where new items should go to
# select columns to modal
# update modal
