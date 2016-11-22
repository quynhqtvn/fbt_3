class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.order("created_at desc").paginate page: params[:page],
      per_page: Settings.per_page
  end
end
