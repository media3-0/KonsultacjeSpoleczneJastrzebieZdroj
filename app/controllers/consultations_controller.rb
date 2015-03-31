class ConsultationsController < ApplicationController
  include ActionView::Helpers::DateHelper

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
      @oldc = @consultation.consultation_comments.where(user_id: current_user.id).first
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
        render js: <<-endjs
          $('#addmaincomment').remove();
          $('.commentscount').text('#{comments_count}');
          $('#whoandago').html('<strong>#{current_user.name}</strong> - #{time_ago_in_words(comment.created_at)} temu');
          $('#commenttext').text('#{comment.content}');
          $('#answerstext').text('pokaż odpowiedzi (#{comment.subcomments_count})');
          $('#mycomment').show();
        endjs
      end
      format.html do
        return
      end
    end
  end
end
