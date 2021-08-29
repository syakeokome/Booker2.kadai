class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
    @book = Book.new
    @user = current_user
    @books = Book.all
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end


  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = "You have updated book successfully"
      redirect_to book_path(@book.id)
    else
      flash.now[:danger] = "It's error"
      render :edit
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = "You have created book successfully"
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all

      render :index
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
