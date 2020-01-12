class Book < ApplicationRecord
	belongs_to :user
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
	has_many :favorites, dependent: :destroy
        def favorited_by?(user)
          favorites.where(user_id: user.id).exists?
        end
    has_many :book_comments, dependent: :destroy

    def self.search(search)
    	if search
    		title = Book.where(['title LIKE ?', "%#{search}%"])
    		body = Book.where(['body LIKE ?', "%#{search}%"])
    		title | body
    	else
    		Book.all
    	end
    end
end
