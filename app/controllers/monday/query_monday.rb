# prepare_monday.rb

def get_boards(token_monday)
  res = HTTP.auth(token_monday)
      .headers('content-type' => 'application/json')
      .post('https://api.monday.com/v2/', json:
        { "query": "{boards{name id}}" })

  return JSON.parse(res.body)['data']['boards']
end
