class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
  if user_signed_in?
    # Affiche les articles publics OU les articles privés de l'utilisateur connecté
    @articles = Article.where(private: false).or(Article.where(user: current_user)).order(created_at: :desc)
  else
    # Affiche seulement les articles publics
    @articles = Article.where(private: false).order(created_at: :desc)
  end
end


  # GET /articles/1 or /articles/1.json
  def show
    # Un article est visible si:
  # - il n'est PAS privé
  # - OU l'utilisateur est connecté ET il est le propriétaire de l'article
  is_public = !@article.private?
  is_owner = user_signed_in? && @article.user == current_user

  unless is_public || is_owner
    redirect_to root_path, alert: "Vous n'êtes pas autorisé à voir cet article."
  end
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy!

    respond_to do |format|
      format.html { redirect_to articles_path, status: :see_other, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :private)
    end
end
