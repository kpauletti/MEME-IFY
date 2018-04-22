class Meme < ApplicationRecord
  mount_uploader :image, ImageUploader
  include Magick
  def write_meme
    img = ImageList.new(self.image.url.prepend('public'))
    txt = Draw.new
    img.annotate(txt, 0,0,0,0, self.description){
      txt.gravity = Magick::SouthGravity
      txt.pointsize = 50
      txt.stroke = '#000000'
      txt.fill = '#ffffff'
      txt.font_weight = Magick::BoldWeight
    }
    img.format = 'jpeg'
    img.write(self.image.file.file)
  end
end
