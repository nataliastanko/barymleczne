class Dish < ActiveRecord::Base
  belongs_to :place

    def created_at
	self[:created_at].strftime(" %d/%m/%Y o godz. %H:%M ") unless self[:created_at].blank?
    end

    def updated_at
	self[:updated_at].strftime(" %d/%m/%Y o godz. %H:%M ") unless self[:updated_at].blank?
    end

    def price
	("%.2f" % self[:price]) unless self[:price].blank?
    end

    def name
     self[:name].downcase.capitalize unless self[:name].blank?

    end

#name
  validates_presence_of :name, :message => "Wpisz nazwę dania."
  validates_length_of :name, :within => 3.. 50, :too_short => "Za krótka nazwa (min 3 znaki)", :too_long => "Za długa nazwa (max. 50 znaków)"
  validates_format_of :name, :with => /[\wąćĆęłŁńŃóÓśŚżŻźŹ ()\.-]$/, :message => "Nazwa dania zawiera nieprawidłowe znaki."


#price
validates_numericality_of :price, :if => :price_required?, :only_integer => false, :message => "Wymagane cyfry. Max. 5 znaków z kropką.", :geather_than => "0", :less_than => 100
#  validates_format_of :price, :if => :price_required?, :with => /^[0-9]{1,2}\.[0-9]{,2}$/, :message => "Wymagane cyfry. Max. 5 znaków z kropką."


#weight
 validates_numericality_of :weight, :if => :weight_required?, :only_integer => true, :message => "Wymagane liczby całkowite. Max. 4 znaki.", :geather_than => "0", :less_than => 2000


#pieces
 validates_numericality_of :pieces, :if => :pieces_required?, :message => "Wymagane liczby całkowite.", :geather_than => "0", :less_than => 100 , :only_integer => true


#description
  validates_length_of :description, :if => :description_required?, :within => 1..50, :too_short => "Za okrótki opis (min. 1 znak)", :too_long => "Za długa ilość znaków (max. 50 znaków)"
  validates_format_of :description, :if => :description_required?, :with => /[\wąćĆęłŁńŃóÓśŚżŻźŹ ()\.\,]$/, :message => "Opis zawiera nieprawidłowe znaki."



protected
  def weight_required?
   !weight.blank? 
 end

  def pieces_required?
   !pieces.blank? 
 end
 
  def description_required?
   !description.blank? 
 end

  def price_required?
   !price.blank? 
 end

end
