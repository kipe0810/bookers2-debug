class ContactMailer < ApplicationMailer

	def send_admin_reply(user)
		@user = user
		mail to: @user.email, subject: '【Bookers2】ご登録ありがとうございます'
	end
end
