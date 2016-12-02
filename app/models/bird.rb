class Bird
  include Mongoid::Document
  field :name, type: String
  field :family, type: String
  field :continents, type: Array
  field :added, type: String
  field :visible, type: Boolean

  validates :name, :presence => true, uniqueness: true

  scope :visible, -> { where(visible: true)}
end
