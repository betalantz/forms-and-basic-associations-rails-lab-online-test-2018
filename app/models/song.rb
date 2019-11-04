class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes, dependent: :destroy

  # accepts_nested_attributes_for :notes

  def notes_attributes=(note_attr)
    note_attr.values.compact.each do |attr|
      self.notes.build(attr)
    end
  end

  def artist_name=(name)
    artist = Artist.find_or_create_by(name: name)
    self.artist = artist
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def genre_name=(name)
    genre = Genre.find_or_create_by(name: name)
    self.genre = genre 
  end

  def genre_name
    self.try(:genre).try(:name)
  end


end
