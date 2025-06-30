class PhotosController < ApplicationController
  before_action :authenticate_user! # Requiert une connexion pour toutes les actions
  before_action :set_photo, only: %i[ show edit update destroy ]
  before_action :check_owner, only: %i[ edit update destroy ] # Vérifie la propriété

  # GET /photos or /photos.json
  def index
     @photos = current_user.photos.with_attached_image.order(created_at: :desc)
  end

  # GET /photos/1 or /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = current_user.photos.build
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos or /photos.json
  def create
   @photo = current_user.photos.build(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: "Photo was successfully created." }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1 or /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: "Photo was successfully updated." }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1 or /photos/1.json
  def destroy
    @photo.destroy!

    respond_to do |format|
      format.html { redirect_to photos_path, status: :see_other, notice: "Photo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def check_owner
      unless @photo.user == current_user
        redirect_to photos_path, alert: "Vous n'avez pas l'autorisation de faire cela."
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def photo_params
      params.require(:photo).permit(:title, :user_id, :image)
    end
end
