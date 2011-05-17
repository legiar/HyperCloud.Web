class QueueJobsController < ApplicationController

  def index
    @queue_jobs = QueueJob.current.order(:position)
  end

  def cancel
    @queue_job = QueueJob.find(params[:id])
    if @queue_job.cancel
      flash[:notice] = "Job '#{@queue_job.job.name}' canceled"
    else
      flash[:error] = "Can't cancel job '#{@queue_job.job.name}'"
    end
    redirect_to queue_jobs_path
  end

  def reorder
    items = QueueJob.order(:position).find(params[:ids])
    positions = items.collect{|item| item.position}
    new_items = []
    params[:ids].each_with_index do |id, index|
      new_items << items.select{|item| item.id == id.to_i}.first
    end
    logger.debug new_items.inspect
    new_items.each_with_index do |item,index|
      item.position = positions[index]
      item.save
    end
    render :nothing => true
  end

end
