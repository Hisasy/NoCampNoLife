# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'userモデルのテスト', type: :model do
  before do
    @user = FactoryBot.build(:user)
    @user.image = fixture_file_upload('app/assets/images/no_image.jpg')
  end

  describe "フォローフォロワー" do
    it "フォロー" do
      @other_user = FactoryBot.create(:user, image: fixture_file_upload('app/assets/images/no_image.jpg'))
      @another_user = FactoryBot.create(:user, image: fixture_file_upload('app/assets/images/no_image.jpg'))
      Relationship.create(follower_id: @other_user.id, followed_id: @another_user.id)
      expect(@other_user.following_user.map(&:id)).to include @another_user.id
    end
  end

end