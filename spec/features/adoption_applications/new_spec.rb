require 'rails_helper'

RSpec.describe "New adoption application", type: :feature do
  it "Completed application" do
    shelter = Shelter.create(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
    pet1 = Pet.create(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")
    pet2 = Pet.create(name: "George", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "11", sex: "Male", shelter_id: shelter.id, status: "Adoptable")

    visit "/pets/#{pet1.id}"
    click_on 'Favorite'

    visit "/pets/#{pet2.id}"
    click_on 'Favorite'

    visit "/favorites"

    click_on 'Apply to adopt your favorite pets'

    expect(current_path).to eq("/adoption_applications/new")

    expect(page).to have_content("Bonnie")
    expect(page).to have_content("George")

    select("#{pet1.name}")

    fill_in :name, with: "Ruthie R"
    fill_in :address, with: "1245 Turing Ave"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80250"
    fill_in :phone_number, with: "253-555-1843"
    fill_in :description, with: "I love animals and I want them all."

    click_on 'Submit Application'

    expect(page).to have_content("Your adoption application has been submitted!")

    expect(current_path).to eq("/favorites")
    # expect(page).to_not have_content("Bonnie") - Bonnie now shows up due to User Story 18
  end

  it "Incomplete application" do
    shelter = Shelter.create(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
    pet1 = Pet.create(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")

    visit "/pets/#{pet1.id}"
    click_on 'Favorite'

    visit "/adoption_applications/new"

    select("#{pet1.name}")

    fill_in :name, with: "Ruthie R"

    click_on 'Submit Application'

    expect(page).to have_content("Unsuccessful application submission: please fill in all application fields.")

    expect(current_path).to eq("/adoption_applications/new")
  end
end
