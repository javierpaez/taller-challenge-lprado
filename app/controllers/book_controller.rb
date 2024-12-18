class BookController < ApplicationController

    def index
        render json: Book.order(rating: :desc, publication_date: :desc)
    end

    def create
        book = Book.new(create_params)

        if book.valid?
            book.save
            render json: { book: book }
        else
            render json: { errors: book.errors.messages }, status: 422
        end
    end


    def update
        book = Book.find_by(id: params[:id])

        unless book
            render json: { error: 'Book not found' }, status: 403
            return
        end


        book.rating = params[:rating]
        book.status = params[:status]

        if book.valid?
            book.save
            render json: { book: book }
        else
            render json: { errors: book.errors.messages }, status: 422
        end
    end

    def destroy
        book = Book.find_by(id: params[:id])

        if book
            book.destroy
            render status: 204
        else
            render json: { error: 'Book not found' }, status: 403
        end
    end

    def create_params
        params.permit(:title, :author, :publication_date)
    end


end
