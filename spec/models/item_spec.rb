require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :quantity }
  end

  describe 'relationships' do
    it { should belong_to :category }
    it { should belong_to :posting }
  end
end
