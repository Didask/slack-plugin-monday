# query_monday.rb

def top_group_id(token_monday, board_id)
  res = HTTP.auth(token_monday)
      .headers('content-type' => 'application/json')
      .post('https://api.monday.com/v2/', json:
        { "query": "{boards(ids: #{board_id}){top_group { title id }}}" })

  JSON.parse(res.body)['data']['boards'][0]['top_group']['id']
end
