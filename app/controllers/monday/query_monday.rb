# query_monday.rb

def get_boards(token_monday)
  res = HTTP.auth(token_monday)
      .headers('content-type' => 'application/json')
      .post('https://api.monday.com/v2/', json:
        { "query": "{boards{name id columns { title id type }}}" })

  return JSON.parse(res.body)['data']['boards']
end

def get_columns(token_monday, board_id)
  res = HTTP.auth(token_monday)
      .headers('content-type' => 'application/json')
      .post('https://api.monday.com/v2/', json:
        { "query": "{boards(ids: #{board_id}){columns { title id type }}}" })

  return JSON.parse(res.body)['data']['boards'][0]['columns']
end
