require "rails_helper"

RSpec.describe Comment, type: :model do
  context "relationship" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :review}
  end

  context "validation" do
    it {is_expected.to validate_presence_of(:content)}
  end
end
