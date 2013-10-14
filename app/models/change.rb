class Change < ActiveRecord::Base

  belongs_to :place

    def created_at
	self[:created_at].strftime(" %d/%m/%Y o godz. %H:%M ") unless self[:created_at].blank?
    end

  validates_presence_of :description, :message => "Wymagany opis miejsca."
  validates_length_of :description, :within => 10...255,  :too_short => "Za krótki opis (min. 10)", :too_long => "Za długi opis (max. 255 znaków)"

  validates_presence_of :email, :message => "Wpisz swój email."
  validates_format_of :email, :with => /^[^@][a-z0-9-\.\+]+@[a-z0-9-\.]+[.][a-z]{2,4}$/, :message => "Nieprawidłowy format email."

  validates_presence_of :author, :message => "Podpisz się."
  validates_length_of :author, :within => 2..20, :too_short => "Podpis za krótki.", :too_long => "Podpis za długi."
 

end
