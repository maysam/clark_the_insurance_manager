class InvitationsController < ApplicationController
  def calculate_score
    file = params[:file]
    data = file.read.split("\n")
    user = {}
    points = {}
    data.each do |line|
      parts = line.split ' '
      subject = parts[2]
      action = parts[3]
      object = parts[4]
      if action == 'recommends'
        recommender = subject
        recommendee = object
        if user[object]
          # already recommended
        else
          user[object] = {
            recommender: subject,
            accepted: false
          }
        end
      elsif action == 'accepts'
        recommendee = subject
        if user[recommendee]
          user[recommendee][:accepted] = true

          last_recommender = recommendee
          last_point = 1.0
          while user[last_recommender]
            new_recommender = user[last_recommender][:recommender]
            if points[new_recommender]
              points[new_recommender] += last_point
            else
              points[new_recommender] = last_point
            end
            last_recommender = new_recommender
            last_point /= 2
          end
        else
          render json: {error: 'acception without invitation detected'}
        end
      end
    end

    render json: points
  end
end
