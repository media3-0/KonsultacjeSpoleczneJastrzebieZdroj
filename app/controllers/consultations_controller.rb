class ConsultationsController < ApplicationController
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::TextHelper

  def index
    @index_page = true
  end

  def list
    ctype = params[:ctype]
    @consultations = Consultation.where(consultation_type: ctype).order('created_at DESC')
  end

  def show
    begin
      @consultation = Consultation.find(params[:id])
      @consultations = Consultation.where(consultation_type: @consultation.consultation_type).order('created_at DESC').limit(4)
      @oldc = @consultation.consultation_comments.where(user_id: current_user.id).first if current_user
    rescue => e
      logger.error(e)
      redirect_to :action => :list, :ctype => 0
    end
  end

  def add_comment
    respond_to do |format|
      consultation = Consultation.find(params[:consultation_id])
      unless consultation
        @message = 'Zły consultation id'
        format.js do
          return render js: <<-endjs
            alert('#{@message}');
          endjs
        end
        format.html do
          return
        end
      end

      unless current_user and current_user.uid != nil
        @message = 'Użytkownik niezalogowany'
        format.js do
          return render js: <<-endjs
            alert('#{@message}');
          endjs
        end
        format.html do
          return
        end
      end

      oldc = consultation.consultation_comments.where(user_id: current_user.id).first
      if oldc
        @message = 'Już skomentowałeś'
        format.js do
          return render js: <<-endjs
            alert('#{@message}');
          endjs
        end
        format.html do
          return
        end
      end

      comment = ConsultationComment.new()
      comment.content = params[:consultation_comment][:content]
      comment.user = current_user

      unless comment.valid?
        @message = 'Podaj treść komentarza'
        format.js do
          return render js: <<-endjs
            alert('#{@message}');
          endjs
        end
        format.html do
          return
        end
      end

      consultation.consultation_comments << comment

      comments_count = consultation.consultation_comments.length

      @message = 'Komentarz dodany'

      format.js do
        temp = "updateComment('#{comments_count}', '#{current_user.name}', '#{time_ago_in_words(Time.now)}', '#{Rack::Utils.escape_html(comment.content).gsub(/\r/, '').gsub(/\n/, '<br>')}', '#{comment.id}');"
        logger.error('wtf '+ temp)
        render js: temp
      end
      format.html do
        return
      end
    end
  end

  def get_subcomments
    comment = ConsultationComment.find(params[:id])
    unless comment
      @message = 'Komentarz nie istnieje'
      if request.xhr?
        return render js: <<-endjs
          alert('#{@message}');
        endjs
      else
        return
      end
    end
    if request.xhr?
      render partial: 'subcomments_list', locals: { subcomments: comment.get_subcomments, comment: comment}
    else
      @subcomments = comment.get_subcomments
      @comment = comment
    end
  end

  def add_subcomment
  parentcomment = ConsultationComment.find(params[:comment_id])
    unless parentcomment
      @message = 'Zły comment id'
      return render layout: false, status: 404
    end

    unless current_user and current_user.uid != nil
      @message = 'Użytkownik niezalogowany'
      return render layout: false, status: 404
    end

    comment = ConsultationComment.new()
    comment.content = params[:consultation_comment][:content]
    comment.user = current_user

    unless comment.valid?
      @message = 'Podaj treść komentarza'
      return render layout: false, status: 404
    end

    comment.parent_consultation_comment_id = parentcomment.id
    comment.save!

    @message = 'Komentarz dodany'

    if request.xhr?
      render partial: 'subcomment', locals: { subcomment: comment }
    end
  end
end
