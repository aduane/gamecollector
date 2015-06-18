When(/^I go to the home page$/) do
  visit '/'
end

When(/^I sign in$/) do
  visit '/'
  click_link "Sign in"
end
