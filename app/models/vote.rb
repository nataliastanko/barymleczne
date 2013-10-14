class Vote < ActiveRecord::Base

  belongs_to :place

  validates_presence_of :rate, :with => /[\d]/, :message => "Nie można oddać głosu." 
 
    # pobieranie średniej ocen dla miejsca
    def self.getMark (place_id)
      @votes = Vote.find(:all, :conditions => ['place_id = ?', place_id])
      if @votes.empty? 
         return "Brak ocen." 
      else 
       @sum = 0; i=0;
       @votes.each { |vote| 
            @sum += vote.rate 
            i+=1 }
       @sum = @sum.to_f / i
       @sum.round(2)
     end
   end
 
   # sprawdza czy w przeciagu ostatnich 15 minut oddano głos na miejsce z identycznego IP
   def check 
     @v = Vote.find(:first, :conditions => ['place_id = ? and ip = ?', self.place_id, self.ip], :order => ['id desc'])
     if @v.nil? or ( 15.minutes < ((Time.now)-(@v.created_at)) )         
      return true
     else
      return false
     end
   end

end
