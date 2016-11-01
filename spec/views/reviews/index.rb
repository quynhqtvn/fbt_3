require "rails_helper"

RSpec.describe "reviews/index", type: :view do
  include Devise::TestHelpers
  before do
    user = FactoryGirl.create(:user)
    sign_in user
  end
  let(:review) do
    stub_model Review,
      title: "review",
      content: "Good",
      category_review_id: 1,
      user_id: 1,
      created_at: "20/10/2016"
  end

  it "should show review" do
    allow(view).to receive_messages(:will_paginate => nil)
    assign :review, review
    assign :reviews, Review.all
    render
    expect(rendered).to include(review.title)
    expect(rendered).to include(review.category_review.title)
    expect(rendered).to include(review.user.name)
    expect(rendered).to include l review.created_at, format: :short
  end
end
