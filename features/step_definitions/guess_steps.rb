Given "I am on the Github favorite language guess page" do
  visit root_url
end
VCR.use_cassette('login to shopify') do
  When "I enter an arbitary Github username" do
    fill_in :github_username, with: 'leo-ajc'
    click_on 'Submit'
  end
end

Then "I should see the username's favorite language" do
  expect(page).to have_content('Ruby')
end

When "I enter an Github username that does not exist" do
  fill_in :github_username, with: 'leo-ajc-this-username-does-not-exist'
  click_on 'Submit'
end

Then "I should see an error notice the Github username does not exist" do
  expect(page).to have_content('Github username not found')
end

When(/^I do not enter any value into Github username field$/) do
  fill_in :github_username, with: ''
  click_on 'Submit'
end

Then "I should see an error notice requesting a Github username" do
  expect(page).to have_content 'Please provide a Github username'
end
