class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]
  before_action :find_prototype ,only:[:show,:edit,:destroy,:update]

  def index
    @prototypes = Prototype.all.order("created_at DESC").page(params[:page]).per(8)
  end

  def show
    @likes = @prototype.likes
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def new
    @prototype = Prototype.new
    @prototype.prototype_images.build
  end

  def create
    @prototype = current_user.prototypes.new(prototype_params)
    if @prototype.save
       redirect_to root_path, notice: "Saved prototype Successfully"
     else
      render :new, alert: 'Save to failure'
    end
  end

  def edit
  end

  def update
    if @prototype.update(prototype_params)
       redirect_to root_path, notice: "Saved prototype Successfully"
      else
        render :update, alert: "Could not be updated"
    end
  end

  def destroy
    if @prototype.user_id == current_user.id
      @prototype.destroy
      redirect_to root_path, notice: "Deleted prototype Successfully"
    end
  end

  private
  def prototype_params
      params.require(:prototype).permit(:title, :catchcopy, :concept, prototype_images_attributes: [:id, :status, :content]).merge(tag_list: params[:prototype][:tag])
  end

  private
  def find_prototype
    @prototype = Prototype.find(params[:id])
  end

end

