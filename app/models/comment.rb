class Comment < ActiveRecord::Base
  belongs_to :place
  
     def created_at
	self[:created_at].strftime(" %d/%m/%Y o godz. %H:%M ") unless self[:created_at].blank?
    end

  validates_presence_of :contents, :message => "Wpisz treść komentarza."
  validates_length_of :contents, :minimum => 5, :message => "Za krótka treść komentarza."

  validates_presence_of :autor, :message => "Podpisz się."
  validates_length_of :autor, :within => 2..20, :too_short => "Podpis za krótki.", :too_long => "Podpis za długi."
  
  validates_presence_of :email, :message => "Wpisz swój email."
  validates_format_of :email, :with => /^[^@][a-z0-9-\.\+]+@[a-z0-9-\.]+[.][a-z]{2,4}$/, :message => "Nieprawidłowy format email."



 end
