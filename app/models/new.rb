class New < ActiveRecord::Base
  belongs_to :editor
    def created_at
	self[:created_at].strftime(" %d/%m/%Y o godz. %H:%M ") unless self[:created_at].blank?
    end

    def updated_at
	self[:updated_at].strftime(" %d/%m/%Y o godz. %H:%M ") unless self[:updated_at].blank?
    end

    def title
      self[:title].downcase.capitalize unless self[:title].blank?
    end

  validates_presence_of :title, :message => "Wpisz tytuł."
  validates_length_of :title, :within => 1..255, :too_short => "Za krótki tytuł.", :too_long => "Za długa nazwa (max. 255 znaków)."
  validates_format_of :title, :with => /^[\wąćĆęłŁńŃóÓśŚżŻźŹ \.-]+$/, :message => "Tytuł zawiera nieprawidłowe znaki."

  validates_presence_of :contents, :message => "Wymagana treść."

  validate :at_least_one_checkbox_was_ticked

  def at_least_one_checkbox_was_ticked
    #lets say that the checkboxes are used to set field1, field2 and field3, true or false
    unless for_editors || for_guests
      errors.add_to_base "Musisz zaznaczyć choć jeden checkbox."
    end
  end

end
