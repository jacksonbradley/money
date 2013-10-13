### UTILITY METHODS ###

def create_visitor
  @visitor ||= { :email => "test@test.com", :password => "a1234567" }
end

def create_user
  create_visitor
  delete_user
  @visitor[:confirmed_at] = Time.now
  @user = FactoryGirl.create(:user, @visitor)
end

def delete_user
  @user ||= User.where(:email => @visitor[:email]).first
  @user.destroy unless @user.nil?
end

def sign_in
  visit '/users/sign_in'
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  click_button "Sign in"
end

def toHash(*p)
  {
    amount: p[0],
    category_id: p[1],
    description: p[2],
    day: p[3],
    month: p[4],
    year: p[5]
  }
end
### Given ###

Given /^I exist as a user and logged in$/ do
  create_user
  sign_in
  page.should have_content "Signed in successfully."
end

And /^the system knows about the following category$/ do |table|
  table.raw.each do |cid, name|
    Category.create({cid: cid, name: name})
  end
end

And /^the system knows about the following monny record$/ do |table|
  table.raw.each do |amount, category, desc, day, month, year|
    r = @user.money_records.build(toHash(amount, category, desc, day, month, year))
    r.save
  end
end

When /^I send a GET request to category api$/ do
  @response = page.driver.get api_category_path
end

When /^I send a GET request to list years api$/ do
  @response = page.driver.get api_list_path
end

When /^I send a GET request to list months of (\d+) api$/ do |year|
  @response = page.driver.get api_list_path(y: year)
end

When /^I send a GET request to query month (\d+) of (\d+) api$/ do |month, year|
  @response = page.driver.get api_query_path(m: month, y: year)
end

When /^I send a GET request to summary month (\d+) of (\d+) api$/ do |month, year|
  @response = page.driver.get api_summary_path(m: month, y: year)
end

When /^I send a GET request to summary year (\d+) api$/ do |year|
  @response = page.driver.get api_summary_path(y: year)
end

When /^I send a GET request to trend year (\d+) api$/ do |year|
  @response = page.driver.get api_trend_path(y: year)
end

Then /^should response correct category JSON data$/ do |expect|
  # puts @response.body
  assert_equal expect.gsub(/\n/,''), @response.body
  # category = JSON.parse(@response.body)
  # category["monny"].each do |item|
  #   assert_equal item['name'], '食' if item['cid'] == 1
  #   assert_equal item['name'], '交際娛樂' if item['cid'] == 2
  #   assert_equal item['name'], '交通' if item['cid'] == 3
  # end
end
