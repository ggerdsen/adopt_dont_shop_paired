require 'rails_helper'

RSpec.describe 'Pet adoption applications index page', type: :feature do
  it "A pets show page has a link to view all applications for the pet" do
    shelter = Shelter.create!(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
    pet = Pet.create!(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")
    adoption_application = AdoptionApplication.create!(name: "Ruthie R", address: "1245 Turing Ave", city: "Denver", state: "CO", zip: "80250", phone_number: "253-555-1843", description: "I love animals and I want them all.")

    PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet.id)

    visit "/pets/#{pet.id}"

    click_on "View all applications for #{pet.name}"

    expect(current_path).to eq("/pets/#{pet.id}/adoption_applications")
  end

  it "The pet adoption applications index page shows a list of all applicant names for the pet, each linking to that adoption application show page" do
    shelter = Shelter.create!(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
    pet1 = Pet.create!(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")
    pet2 = Pet.create!(name: "George", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "11", sex: "Male", shelter_id: shelter.id, status: "Adoptable")
    adoption_application1 = AdoptionApplication.create!(name: "Ruthie R", address: "1245 Turing Ave", city: "Denver", state: "CO", zip: "80250", phone_number: "253-555-1843", description: "I love animals and I want them all.")
    PetAdoptionApplication.create!(adoption_application_id: adoption_application1.id, pet_id: pet1.id)
    PetAdoptionApplication.create!(adoption_application_id: adoption_application1.id, pet_id: pet2.id)
    adoption_application2 = AdoptionApplication.create!(name: "Garret G", address: "2351 Colfax St", city: "Edgewater", state: "CO", zip: "81265", phone_number: "525-234-1234", description: "I also love animals and want them more.")
    PetAdoptionApplication.create!(adoption_application_id: adoption_application2.id, pet_id: pet1.id)

    visit "/pets/#{pet1.id}/adoption_applications"

    within("#adoption-applicants") do
      expect(page).to have_content("Applicants:")
      expect(page).to have_content(adoption_application1.name)
      expect(page).to have_xpath("//adoption_applications/#{adoption_application1}")
      expect(page).to have_content(adoption_application2.name)
      expect(page).to have_xpath("//adoption_applications/#{adoption_application2}")
    end
  end
end
