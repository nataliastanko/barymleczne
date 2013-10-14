require 'digest/sha1'

class Editor < ActiveRecord::Base

  attr_accessor :password

  has_many :histories
  has_many :places, :through => :histories

    def created_at
	self[:created_at].strftime(" %d/%m/%Y o godz. %H:%M ") unless self[:created_at].blank?
    end

  validates_length_of :name_surname, :if => :name_surname_required?, :within => 7..20, :too_short => "Wymagana większa ilość znaków (min. 7 znaków)", :too_long => "Za długa ilość znaków (max. 20 znaków)"
  validates_format_of :name_surname, :if => :name_surname_required?, :with => /^[A-Zz-ząćĆęłŁńŃóÓśŚżŻźŹ ]+$/, :message => "Imie i nazwisko zawierają nieprawidłowe znaki."
 
  validates_presence_of :login, :message => "Proszę wpisać login" 
  validates_length_of :login, :within => 3..20, :too_short => "Za krótki login (min. 2)", :too_long => "Za długi login (max. 20 znaków)"
  validates_uniqueness_of :login, :case_sensitive => true
  validates_format_of :login, :with => /^[\w\.-]+$/, :message => "Login zawiera nieprawidłowe znaki."
  
  validates_presence_of :email, :message => "Wpisz swój email."
  validates_format_of :email, :with => /^[^@][a-z0-9-\.\+]+@[a-z0-9-\.]+[.][a-z]{2,4}$/, :message => "Nieprawidłowy format email."

  validates_presence_of :password, :if => :password_required?, :message => "Hasło nie może być puste"
  validates_length_of :password, :within => 8..20, :if => :password_required?, :too_short => "Za krótkie haslo (min. 8 znaków)", :too_long => "Za długie hasło (max. 20 znaków)"

  validates_confirmation_of :password, :if => :password_required?

  before_save :encrypt_new_password

# logowanie
   def self.authenticate(login, password)
     editor = find_by_login(login)
     return editor if editor && editor.authenticated?(password)
   end

   def authenticated?(password)
     hashed_password == encrypt(password)
   end
  
 protected
   def encrypt_new_password
     return if password.blank?
     self.hashed_password = encrypt(password)
  end

 def name_surname_required?
   !name_surname.blank? 
 end

 def password_required?
   hashed_password.blank? || !password.blank? 
 end

 def encrypt (string)
   Digest::SHA1.hexdigest(string)
 end
end
