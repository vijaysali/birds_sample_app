class Bird
  include Mongoid::Document
  field :name, type: String
  field :family, type: String
  field :continents, type: Array
  field :added, type: DateTime, default: DateTime.now
  field :visible, type: Boolean, default: false

  validates :name, :presence => true, uniqueness: true
  validates :family, :presence => true
  validates :continents, :presence => true

  scope :visible, -> { where(visible: true)}
end
