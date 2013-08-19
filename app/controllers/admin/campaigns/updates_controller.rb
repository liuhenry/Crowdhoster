class Admin::Campaigns::UpdatesController < ApplicationController
  layout "admin"
  before_filter :authenticate_user!
  before_filter :verify_admin
  before_filter :load_campaign

  def index
    @updates = @campaign.updates.order("publish_date ASC").select("title, slug, publish_date, published_flag")
  end

  def new
    @update = Update.new
    render "edit"
  end

  def edit
    @update = Update.find(params[:id])
  end

  def create
    @update = @campaign.updates.new(params[:update])

    if !@update.valid?
      message = ''
      @update.errors.each do |key, error|
        message = message + key.to_s.humanize + ' ' + error.to_s + ', '
      end
      flash.now[:error] = message[0...-2]
      render "edit"
      return
    end

    @campaign.save

    redirect_to admin_campaign_updates_url(@campaign), :flash => { :notice => "Created!" }
    return
  end

  def update
    @update = @campaign.updates.find(params[:id])
    
    @update.assign_attributes(params[:update])

    if !@update.valid?
      message = ''
      @update.errors.each do |key, error|
        message = message + key.to_s.humanize + ' ' + error.to_s + ', '
      end
      flash.now[:error] = message[0...-2]
      render "edit"
      return
    end

    @update.save

    redirect_to admin_campaign_updates_url(@campaign), :flash => { :notice => "Updated!" }
    return
  end


  private

  def load_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

end
