class ArticlesController < ApplicationController
  before_action :set_article, only:[ :edit, :update, :show]
  before_action :require_user, expect:[:index, :show]
  before_action :require_same_user, only:[:edit,:update,:destroy]
def index
@articles = Article.paginate(page: params[:page], per_page: 2)
end
def new
@article = Article.new
end
def edit

end

def create
#render plain: params[:article].inspect
@article = Article.new(article_params)
@article.user= current_user
if @article.save
  flash[:notice]  ="Article was successfully created"
  redirect_to article_path(@article)
  #do something
else
  render "new"

  #@article.save
  #redirect_to articles_path(@article)
end

end
def update

  if @article.update(article_params)
    flash[:notic]="Article was successfully updated"
    redirect_to article_path(@article)
  else
    render "edit"
end
end
def show


end
def destroy

  @article.destroy
  flash[:notice] = "Article was successfully deleted"

end

private
def set_article
  @article =Article.find(params[:id])
end
def article_params
  params.require(:article).permit(:tittle, :description)
end
def require_same_user
if current_user != @article.user and !current_user.admin?
  flash[:danger]  = "you can only edit and delete own articles"
  redirect_to root_path
end
end
end
