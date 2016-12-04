class BirdSerializer < ActiveModel::Serializer
  attributes :id, :name, :family, :continents, :added, :visible

  def id
    object.id.to_s
  end

  def added
    o = object.added
    "#{o.try(:year)}-#{o.try(:month)}-#{o.try(:day)}"
  end
end
