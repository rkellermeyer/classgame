class Attempt < ActiveRecord::Base
	belongs_to :user

	def final_experience_question(alternatives, user)
		exercise = 1
		points = 0 
		approved = true
		alternatives.each do |alternative| 
			if alternative.correct? 
				points += alternative.question.experience; approved = true 
			else; approved = false
			end 
		end
		update_attempt(points, user, approved)
		update_performance(user, points, exercise)
	end

	private
		def update_performance(user, points, exercise = 0)
			performace = user.performace
      		performace.update_attributes(total_experience: performace.total_experience + points, 
      								     amount_exercises: performace.amount_exercises + exercise)
		end

		def update_attempt(points, user, approved)
			self.update_attributes(experience: points, user:user, approved:approved)
		end
end
