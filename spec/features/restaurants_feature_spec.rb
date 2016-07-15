require 'rails_helper'

feature 'restaurants' do

  before do
    sign_up
  end

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    scenario 'display restaurants' do
      add_restaurant
      visit '/restaurants'
      expect(page).to have_content 'KFC'
      expect(page).to_not have_content 'No restaurants yet'
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content('KFC')
      expect(current_path).to eq '/restaurants'
    end

    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  # context 'viewing restaurants' do
  #
  #   let!(:kfc){ Restaurant.find_by(name: 'KFC')}
  #
  #   scenario 'let a user view a restaurant' do
  #     visit '/restaurants'
  #     click_link 'KFC'
  #     expect(page).to have_content 'KFC'
  #     expect(current_path).to eq "/restaurants/#{kfc.id}"
  #   end
  # end

  context 'editing restaurants' do
    scenario 'let a user edit a restaurant' do
      add_restaurant
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'Deep fried goodness'
      expect(current_path).to eq '/'
    end
  end

  context 'deleting restaurants' do
    scenario 'removes a restaurant when the user clicks a delete link' do
      add_restaurant
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content('KFC')
      expect(page).to have_content('Restaurant deleted successfully')
    end
  end

  context 'not being logged in' do
    scenario 'does not allow for creation of new restaurant' do
      visit '/restaurants'
      click_link 'Sign Out'
      click_link 'Add a restaurant'
      expect(page).to have_content('You need to sign in or sign up before continuing.')
      expect(page).not_to have_content('Create Restaurant')
    end
  end
end
