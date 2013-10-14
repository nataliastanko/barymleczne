class Place < ActiveRecord::Base

# has_many  1 do wielu
# has_and_belongs_to_many - wiele do wielu
# has_one 1 do 1

  has_many :dishes
  has_and_belongs_to_many :tags , :join_table => "places_tags"
  belongs_to :category
  has_many :votes
  has_many :changes
  has_many :comments
  has_many :photos
  has_many :open_hours, :dependent => :destroy
  accepts_nested_attributes_for :open_hours, :allow_destroy => true
  has_many :histories
  has_many :editors, :through => :histories

    def created_at
	self[:created_at].strftime(" %d/%m/%Y o godz. %H:%M ") unless self[:created_at].blank?
    end

    def updated_at
	self[:updated_at].strftime(" %d/%m/%Y o godz. %H:%M ") unless self[:updated_at].blank?
    end

    def street
     self[:street].downcase.capitalize unless self[:street].blank?

    end

    def name
      self[:name].downcase.capitalize unless self[:name].blank?
    end

  validates_presence_of :name, :message => "Wpisz nazwę miejsca."
  validates_length_of :name, :within => 1..255, :too_short => "Za krótka nazwa", :too_long => "Za długa nazwa (max. 255 znaków)"
  validates_format_of :name, :with => /^[\wąćĆęłŁńŃóÓśŚżŻźŹ \.-]+$/, :message => "Nazwa zawiera nieprawidłowe znaki."

  validates_presence_of :street, :message => "Wpisz nazwę ulicy."
  validates_length_of :street, :within => 2..255, :too_short => "Za krótka nazwa", :too_long => "Za długa nazwa (max. 255 znaków)"
  validates_format_of :street, :with => /^[\wąćĆęłŁńŃóÓśŚżŻźŹ \.-]+$/, :message => "Nazwa zawiera nieprawidłowe znaki."

#  validates_format_of :street :with => /^[\s\w-]{2,}$/

  validates_presence_of :description, :message => "Wymagany opis miejsca."
  validates_length_of :description, :within => 10...255,  :too_short => "Za krótki opis (min. 10)", :too_long => "Za długi opis (max. 255 znaków)"

  validates_presence_of :category, :message => "Wybierz kategorię."

  validates_presence_of :latitude,  :message => "Koniecznie oznacz miejsce na mapie!"

end
