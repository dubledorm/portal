require 'rails_helper'

RSpec.describe Gallery, type: :model do
  describe 'factory' do
    let!(:gallery) {FactoryGirl.create :gallery}
    let!(:gallery_with_pictures) {FactoryGirl.create :gallery_with_pictures}

    # Factories
    it { expect(gallery).to be_valid }
    it { expect(gallery_with_pictures).to be_valid }

    it { should belong_to(:user) }
    it { should have_many(:pictures) }

    it { should validate_presence_of(:state) }
  end

  describe 'delete' do
    let!(:gallery_with_pictures) {FactoryGirl.create :gallery_with_pictures}

    it { expect(gallery_with_pictures.pictures.count).to eq(2) }
    it { expect{ gallery_with_pictures.destroy }.to change(Gallery, :count).by(-1) }
    it { expect{ gallery_with_pictures.destroy }.to change(Picture, :count).by(-2) }
  end
end
