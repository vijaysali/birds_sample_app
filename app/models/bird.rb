class Bird
  include Mongoid::Document
  field :name       , type: String
  field :family     , type: String
  field :continents , type: Array
  field :added      , type: DateTime, default: DateTime.now
  field :visible    , type: Boolean , default: false

  # validations for attributes
  validates :name, :presence => true, uniqueness: true
  validates :family, :presence => true
  validates :continents, :presence => true

  # scope to fetch all visible birds
  scope :visible, -> { where(visible: true)}
end
