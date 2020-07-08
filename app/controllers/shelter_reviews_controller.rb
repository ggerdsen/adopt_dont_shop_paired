class ShelterReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end
  
  def create

    shelter_review = ShelterReview.new({
              title: params[:title],
              rating: params[:rating],
              content: params[:content],
              picture: params[:picture],
              shelter_id: params[:id]
              })

    shelter_review.save
    redirect_to "/shelters/#{params[:id]}"
  end
  
  def edit
    @shelter = Shelter.find(params[:shelter_id])
    @shelter_review = ShelterReview.find(params[:review_id])
  end
  
  def update
    @shelter_review = ShelterReview.find(params[:review_id])
    @shelter_review.update(shelter_review_params)
    redirect_to "/shelters/#{params[:shelter_id]}"
  end
  
  private
  def shelter_review_params
    params.permit(:title, :rating, :content, :picture)
  end
  

end
