class BirdSerializer < ActiveModel::Serializer
  attributes :id, :name, :family, :continents, :added, :visible

end
