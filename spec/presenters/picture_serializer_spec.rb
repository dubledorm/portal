require 'rails_helper'


RSpec.describe PictureSerializer do
  let!(:empty_picture) { FactoryGirl.create :empty_picture }
  let!(:empty_attributes_hash) { { 'id': empty_picture.id, 'name': empty_picture.name,
                                         'description': empty_picture.description,
                                         'cover_image_url': empty_picture.decorate.image_for_cover,
                                         'image_url': empty_picture.decorate.image } }

  let!(:picture) { FactoryGirl.create :picture }
  let!(:attributes_hash) { { 'id': picture.id, 'name': picture.name, 'description': picture.description,
                                   'cover_image_url': picture.decorate.image_for_cover,
                                   'image_url': picture.decorate.image } }


  describe 'from_picture' do
    context 'when picture does not exist' do
      it { expect(described_class.new.from_picture(empty_picture).serializable_hash).to eq(empty_attributes_hash) }
      it { ap(described_class.new.from_picture(empty_picture).serializable_hash) }
    end

    context 'when picture exists' do
      it { expect(described_class.new.from_picture(picture).serializable_hash).to eq(attributes_hash) }
      it { ap(described_class.new.from_picture(picture).serializable_hash) }
    end
  end
end