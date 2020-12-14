class User < ApplicationRecord
  validates_presence_of :email, :password, :name
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8}

  before_validation do
    self.name = self.email if self.name.blank?
  end

  def odd_name
    self.name.length.odd?
  end
end
