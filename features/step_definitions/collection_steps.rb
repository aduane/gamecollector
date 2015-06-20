When(/^I view my collection$/) do
  visit '/my_collection'
end

Given(/^I own (\d+) "(.*?)" Game.?$/) do |number, name|
  user = User.last
  1.upto(number.to_i) do |num|
    gbd_id = stub_game(num, "#{name} #{num}")
    user.add_to_collection(gbd_id, "#{name} #{num}", "Game Box")
  end
end

When(/^I click the button to remove a game from my collection$/) do
  within ".game-list" do
    click_on("X")
  end
end

def stub_game(num, name)
  stub_request(:any, "thegamesdb.net/api/GetGame.php").
    with(query: {id: num}).
    to_return(status: 200,
              body: %{<?xml version="1.0" encoding="UTF-8" ?>
<Data>
  <Game>
    <id>112</id>
    <GameTitle>#{name}</GameTitle>
    <PlatformId>1</PlatformId>
    <Platform>Game Box</Platform>
    <ReleaseDate>01/01/2001</ReleaseDate>
    <Publisher>Games, Inc.</Publisher>
  </Game>
</Data>}
             )
  num
end
