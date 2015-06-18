Then(/^I should see "(.*?)"$/) do |content|
  assert page.has_content?(content)
end

Then(/^I should not see "(.*?)"$/) do |content|
  assert !page.has_content?(content)
end

Then(/^show me the page$/) do
  save_and_open_page
end
