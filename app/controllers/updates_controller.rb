class UpdatesController < ApplicationController
  before_filter :check_init
  before_filter :load_campaign
  before_filter :check_published
  before_filter :set_compact_header

  after_filter :check_update_published, :only => [:show]

  def show
    @update = @campaign.updates.find(params[:update_id])
    render 'theme/views/update'
  end

  private


  def set_compact_header
    @compact_header = true
  end

  def load_campaign
    @campaign = Campaign.find(params[:id])
  end

  def check_published
    if !@campaign.published_flag
      unless user_signed_in? && current_user.admin?
        redirect_to root_url, :flash => { :error => "Campaign is no longer available" }
      end
    end
  end

  def check_update_published
    if !@update.published_flag
      unless user_signed_in? && current_user.admin?
        redirect_to campaign_home_url(@campaign)
      end
    end
  end

end
