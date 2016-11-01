require "rails_helper"
RSpec.describe ReviewsController, type: :controller do
  include Devise::TestHelpers
  let(:review) do
    mock_model Review,
      title: "review",
      content: "Good",
      category_review_id: "1"
  end
  before do
    user = FactoryGirl.create(:user)

    sign_in user
  end

  context "GET #index" do
    it "should render index" do
      get :index
      expect(response).to render_template "index"
    end
  end

  context "GET #show" do
    it "should render all comment on review" do
      get :show, id: review.id
      expect(response).to render_template "show"
    end
  end

  context "GET #new" do
    it "should render new" do
      get :new, id: review.id
      expect(response).to render_template "new"
    end
  end

  context "POST #create" do
    it "should create new review" do
      expect {post :create, review: {
        title: review.title,
        content: review.content,
        category_review_id: review.category_review_id}}.to change(Review, :count).by(1)
      expect(response).to redirect_to root_path
    end

    it "should render new if creating fails" do
      post :create, review: {title: ""}
      expect(response).to render_template "new"
    end
  end

  context "GET #edit" do
    it "should render edit" do
      get :edit, id: review.id
      expect(response).to render_template "edit"
    end
  end

  context "PATCH #update" do
    it "should update review" do
      patch :update, id: review.id, review: {title: "EDITED"}
      expect(response).to redirect_to reviews_path
    end

    it "should render edit if updating fails" do
      patch :update, id: review.id, review: {title: "", content: ""}
      expect(response).to render_template "edit"
    end
  end

  context "DELETE #destroy" do
    it "should delete review" do
      expect {delete :destroy, id: review.id}.to change(Review, :count).by(-1)
    end

    it "should flash danger if deleting fails" do
      delete :destroy, id: 0
      expect(flash[:notice]).to be_present
    end
  end
end
