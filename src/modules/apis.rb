def fortune(category = '')
  base_url = 'http://yerkee.com/api/fortune'
  categories = %w[all computers cookie definitions miscellaneous people platitudes politics science wisdom]
  url = if categories.include? category.to_s
          "#{base_url}/#{category}"
        else
          base_url
        end
  response = HTTP.get(url)
  if response.code == 200
    {
      'text' => response.parse['fortune'],
      'lucky_numbers' => (1..99).to_a.sample(6).join('-')
    }
  else
    response.parse['errors']
  end
end
