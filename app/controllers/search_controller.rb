class SearchController < ApplicationController

	def search
		@book = Book.new
		@books = Book.all
		@users = User.all
		@model = params[:model]
		@sort = params[:sort]
		@search = params[:search]
		@searching = searching(@model, @search, @match)
	end

	private
	def searching(model, search, sort)
		if model == "User"
			if sort == "all"
				User.where(['name LIKE ?', "#{search}"])
			elsif sort == "front"
				User.where(['name LIKE ?', "#{search}%"])
			elsif sort == "back"
				User.where(['name LIKE ?', "%#{search}"])
			else
				User.where(['name LIKE ?', "%#{search}%"])
			end
		elsif model == "Book"
			if sort == "all"
				title = Book.where(['title LIKE ?', "#{search}"])
				body = Book.where(['body LIKE ?', "#{search}"])
				title | body
			elsif sort == "front"
				title = Book.where(['title LIKE ?', "#{search}%"])
				body = Book.where(['body LIKE ?', "#{search}%"])
				title | body
			elsif sort == "back"
				title = Book.where(['title LIKE ?', "%#{search}"])
				body = Book.where(['body LIKE ?', "%#{search}"])
				title | body
			else
				title = Book.where(['title LIKE ?', "%#{search}%"])
				body = Book.where(['body LIKE ?', "%#{search}%"])
	    		title | body
			end
		end
	end
end
