class AwardController < ApplicationController
    skip_before_action :verify_authenticity_token
    def add_comment_to_award
        @award = Award.find(params[:id])
        @award.final_verdict = params[:final_verdict_text]
        @award.save!
        render json: {message: "Final verdict added"}
    end
end
