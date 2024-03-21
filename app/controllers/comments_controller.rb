# frozen_string_literal: true

class CommentsController < ApplicationController
  skip_before_action :authenticate, except: %i[index, show], if: -> { request.format.json? }
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :authenticate_account!, only: %i[new edit update destroy]
  before_action -> { check_owner Comment.find(params[:id]).account_id }, only: %i[edit update destroy]

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @practice = Practice.friendly.find(params[:practice_id])
    @comment.practice_id = @practice.id
    @comment.account_id = current_account.id

    respond_to do |format|
      if @comment.save
        # Send E-Mail to the User - Disabled to evaluate
        # subject = "[Agroecology Map] You have received a new comment on #{@comment.practice.name}"
        # body = "Comment: #{@comment.comment}"
        # body += "\r\n \r\n"
        # body += "Link to the Practice: " + location_practice_url(@comment.practice.location, @comment.practice)
        #
        # if @practice.account.id != current_account.id
        #   ActionMailer::Base.mail(from: '"Agroecology Map" <noreply@agroecologymap.org>', to: @practice.account.email, subject: subject,  body: body).deliver
        # end

        format.html { redirect_to @practice, notice: "A Comment was added." }
      else
        format.html { redirect_to @practice, notice: "Error when trying to send comment. Limit of 4096 characters." }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @practice = Practice.friendly.find(@comment.practice_id)

    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @practice, notice: "Comment was Removed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:comment, :account_id, :practice_id)
    end
end
