class History < ActiveRecord::Base

  belongs_to :place
  belongs_to :editor

    def created_at
	self[:created_at].strftime(" %d/%m/%Y o godz. %H:%M ") unless self[:created_at].blank?
    end

end
