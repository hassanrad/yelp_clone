require 'rails_helper'

feature 'reviewing' do

  scenario 'allows users to leave a review using a form' do
    sign_up
    add_restaurant
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select "3", from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'so so'
  end

  scenario 'only allows user to create one review' do
    sign_up
    add_restaurant
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select "3", from: 'Rating'
    click_button 'Leave Review'
    click_link 'Review KFC'
    click_button 'Leave Review'
    expect(page).to have_content 'You have already reviewed this restaurant'
  end


end
