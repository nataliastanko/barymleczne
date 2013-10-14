class OpenHour < ActiveRecord::Base
  belongs_to :place
  public 

# zwraca godziny otwarcia w sformatowanej postaci 
    def from_hour
	self[:from_hour].strftime("%H:%M") unless self[:from_hour].blank?

    end

# zwraca godziny otwarcia w sformatowanej postaci 
    def to_hour
	self[:to_hour].strftime("%H:%M") unless self[:to_hour].blank?

    end

end
