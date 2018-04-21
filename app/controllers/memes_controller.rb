require 'rmagick'
class MemesController < ApplicationController
  include Magick
  before_action :set_meme, only: [:show, :edit, :update, :destroy]

  # GET /memes
  # GET /memes.json
  def index
    @memes = Meme.all


  end

  # GET /memes/1
  # GET /memes/1.json
  def show
    #memeify(@meme.image.url)
    #lolcat
  end

  # GET /memes/new
  def new
    @meme = Meme.new
  end

  # GET /memes/1/edit
  def edit
  end

  # POST /memes
  # POST /memes.json
  def create
    @meme = Meme.new(meme_params)
    respond_to do |format|
      if @meme.save
        format.html { redirect_to @meme, notice: 'Meme was successfully created.' }
        format.json { render :show, status: :created, location: @meme }
      else
        format.html { render :new }
        format.json { render json: @meme.errors, status: :unprocessable_entity }
      end
    end
    #lolcat("public/computer-cat.jpg", @meme.description)
  end

  # PATCH/PUT /memes/1
  # PATCH/PUT /memes/1.json
  def update
    respond_to do |format|
      if @meme.update(meme_params)
        format.html { redirect_to @meme, notice: 'Meme was successfully updated.' }
        format.json { render :show, status: :ok, location: @meme }
      else
        format.html { render :edit }
        format.json { render json: @meme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memes/1
  # DELETE /memes/1.json
  def destroy
    @meme.destroy
    respond_to do |format|
      format.html { redirect_to memes_url, notice: 'Meme was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def lolcat

      img = ImageList.new("public/computer-cat.jpg")
      txt = Draw.new
      img.annotate(txt, 0,0,0,0, "DOES THIS STILL WORK???"){
      txt.gravity = Magick::SouthGravity
      txt.pointsize = 25
      txt.stroke = '#000000'
      txt.fill = '#ffffff'
      txt.font_weight = Magick::BoldWeight
    }

    img.format = 'jpeg'
    send_data img.to_blob, :stream => 'false', :filename => 'test.jpg', :type => 'image/jpeg', :disposition => 'inline'

  end



  private
  # Use callbacks to share common setup or constraints between actions.
  def set_meme
    @meme = Meme.find(params[:id])
  end

  def memeify(source)
    img = MiniMagick::Image.open(source)
    img.combine_options do |c|
      c.gravity 'Southwest'
      c.draw 'text 10,10 "whatever"'
      #c.font '-*-helvetica-*-r-*-*-18-*-*-*-*-*-*-2'
      c.fill("#FFFFFF")
    end
    img.write("new.jpg")
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def meme_params
    params.require(:meme).permit(:name, :description, :image)
  end
end
