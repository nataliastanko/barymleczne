class Tag < ActiveRecord::Base
  has_and_belongs_to_many :places, :join_table => "places_tags"

  validates_presence_of :name, :message => "Proszę wpisać nazwę taga" 
  validates_length_of :name, :within => 3..20, :message => "Długość taga musi wynosić od 2 do 20 znaków"
  validates_format_of :name, :with => /^[\w\. -]+$/, :message => "Nazwa taga zawiera nieprawidłowe znaki."

  def name
     self[:name].downcase unless self[:name].nil?
    end

end
