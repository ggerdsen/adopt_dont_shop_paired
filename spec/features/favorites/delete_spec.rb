
require 'rails_helper'

RSpec.describe "Pet show page", type: :feature do
  it "Pet show pages will give a 'remove pet from favorites' option if animal is already favorited " do
    shelter = Shelter.create(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
    pet1 = Pet.create(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")

    visit "/pets/#{pet1.id}"
    
    expect(page).to have_content('Favorite')
    
    click_button 'Favorite'
    visit current_path
    # expect(page).to_not have_content('Favorite')
    expect(page).to have_button('Remove Pet From Favorites')
        save_and_open_page
    click_button 'Remove Pet From Favorites'
    
    within("navbar") do
      click_link "Favorites - 0"
    end
    
    expect(current_path).to eq("/favorites")
    expect(page).to_not have_content(pet1.name)
    expect(page).to_not have_xpath("//img[@src='#{pet1.image}']")

  end
end