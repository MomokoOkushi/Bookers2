class BooksController < ApplicationController
before_action :authenticate_user!
before_action :is_matching_login_user, only: [:edit, :update]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "created successfully"
      redirect_to "/books/#{@book.id}"
    else
      @user = current_user
      @books = Book.all
      render "index"
    end
  end

  def index
    @book_new = Book.new
    @user = current_user

    @books = Book.most_favorited

  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    @booknew = @book
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
       byebug
       flash[:notice] = "updated successfully"
       redirect_to book_path(book.id)
    else
       @book = book
       @booknew = book
       @user = @booknew.user
       render "edit"
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  def is_matching_login_user
    book = Book.find(params[:id])
    user = book.user
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
end
