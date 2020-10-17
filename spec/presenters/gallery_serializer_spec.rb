require 'rails_helper'


RSpec.describe GallerySerializer do
  let!(:empty_gallery) { FactoryGirl.create :gallery }
  let!(:empty_attributes_hash) { { 'name': empty_gallery.name, 'description': empty_gallery.description,
                                         'pictures': [] } }

  let!(:gallery) { FactoryGirl.create :gallery_with_pictures }
  let!(:attributes_hash) { { 'name': gallery.name, 'description': gallery.description,
                                   'pictures': [] } }


  describe 'from_gallery' do
    context 'when pictures do not exist' do
      it { expect(described_class.new.from_gallery(empty_gallery).serializable_hash).to eq(empty_attributes_hash) }
      it { ap(described_class.new.from_gallery(empty_gallery).serializable_hash) }
    end

    context 'when pictures exist' do
      it { expect(described_class.new.from_gallery(gallery).serializable_hash[:pictures].count).to eq(2) }
      it { expect(described_class.new.from_gallery(gallery).
          serializable_hash[:pictures].include?(PictureSerializer.new.
                                                from_picture(gallery.pictures.first).
                                                serializable_hash)).to eq(true) }

      it { ap(described_class.new.from_gallery(gallery).serializable_hash) }
    end
  end
end