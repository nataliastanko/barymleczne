class Category < ActiveRecord::Base
  has_many :places

  validates_presence_of :name, :message => "Proszę wpisać nazwę kategorii." 
  validates_length_of :name, :within => 3..20, :too_short => "Za krótka nazwa (min. 3 znaki)", :too_long => "Za długa nazwa (max. 20 znaków)."
  validates_format_of :name, :with => /^[\wąćĆęłŁńŃóÓśŚżŻźŹ \.-]+$/, :message => "Nazwa zawiera nieprawidłowe znaki."


  def name
     self[:name].downcase.capitalize 
    end

end
