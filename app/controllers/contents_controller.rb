class ContentsController < ApplicationController
	
	def start
		@chapter = Chapter.find(params[:chapter_id])
		@@contents = @chapter.contents
		@@current_content = 0
		redirect_to chapter_contents_management_path(@chapter)
		session[:current_points] = 0
	end
	
	def contents_management
		if @@contents[@@current_content]
			render_contents
		else
			done_contents
		end
	end

	def click_content
		@@current_content = params[:content_position].to_i - 1
		@chapter = @@contents.first.chapter
		redirect_to chapter_contents_management_path(@chapter)
	end

	def next_content
		@@current_content += 1
		@chapter = @@contents.first.chapter
		redirect_to chapter_contents_management_path(@chapter)
	end

	def done_contents
		redirect_to @@contents.first.chapter.course, notice: "Parabéns você concluiu o chapter #{@@contents.first.chapter.title}!"
	end

	def collect_score_content
		performace = current_user.performace
    if params[:question]
    	session[:current_points] += 10
    elsif params[:text]
      text = Text.find(params[:text][:id])
      performace.update_attributes( total_experience: performace.total_experience + text.experience )
    	session[:current_points] += text.experience
    else
      video = Video.find(params[:video][:id])
      performace.update_attributes( total_experience: performace.total_experience + video.experience )
    	session[:current_points] += video.experience
    end  

    next_content
  end
	
	private
		def render_contents
			@partial_content = "contents/#{@@contents[@@current_content].type.downcase}"
			@content = @@contents[@@current_content]
			render :contents_management
		end  

		def content_params
      if params[:question]
        params[:question][:alternative_attributes] = params[:question][:alternative_attributes].map {|attrs| attrs.last } 
      end
      #params.require(:attempt).permit(:experience, :ending_time, :approved, :done)
      #params.require(:question)
    end
end