Given(/^there exists (\d+) "(.*?)" games$/) do |number, name|
  games_to_search = []
  1.upto(number.to_i) do |num|
    games_to_search << {gbd_id: num, title: "#{name} #{num}"}
  end
  stub_game_search(name, games_to_search)
end

Then(/^I click to add the game to my collection$/) do
  click_on "Add to collection"
end

When(/^I search for "(.*?)"$/) do |search_term|
  fill_in "search_term", with: search_term
  click_on "Search"
end

def stub_game_search(search_term, games)
  xml_response = %{<?xml version="1.0" encoding="UTF-8" ?>
    <Data>}
  games.each do |game|
    stub_game(game[:gbd_id], game[:title])
    xml_response << "<Game>"
    xml_response << "<id>#{game[:gbd_id]}</id>"
    xml_response << "<GameTitle>#{game[:title]}</GameTitle>"
    xml_response << "<ReleaseDate>01/#{game[:gbd_id]}/2000</ReleaseDate>"
    xml_response << "<Platform>Game Box</Platform>"
    xml_response << "</Game>"
  end
  xml_response << "</Data>"

  stub_request(:any, "thegamesdb.net/api/GetGamesList.php").
    with(query: {name: search_term}).
    to_return(status: 200, body: xml_response)
end
