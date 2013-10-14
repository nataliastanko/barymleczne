class Photo < ActiveRecord::Base
 belongs_to :place

 has_attachment :content_type => :image, 
                   :storage => :file_system, 
                   :max_size =>  5.megabytes,
                   :resize_to => '800x800>',
                   :size => 0..5.megabytes,
                   :thumbnails => {
                      :small => '90x90>',
                      :big => '300x300>'
                   },
                   :processor => :Rmagick;

  validates_as_attachment# nie ma chyba message :message => "Upewnij się, że Twoje zdjęcie ma mniej niż 2MB i ma format PNG, GIF lub JPG"
end
