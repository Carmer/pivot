class JobsController < ApplicationController
  def index
    @jobs = Job.active
  end

  def show
    @job = Job.find(params[:id])
  end
end
