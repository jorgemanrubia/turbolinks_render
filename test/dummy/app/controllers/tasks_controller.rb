class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  def show; end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit; end

  # POST /tasks
  def create
    raise 'OMG this is a 500 error' if task_params[:title] == 'force error 500'

    case task_params[:title]
    when 'force error 500'
      raise 'OMG this is a 500 error'
    when 'force script response'
      render 'response_with_script_tags'
    when 'force empty response'
      head :ok, content_type: 'text/html'
    else
      @task = Task.new(task_params)

      if @task.save
        redirect_to @task, notice: 'Task was successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  def update_with_turbolinks; end

  def update_with_turbolinks_forcing_it
    render turbolinks: true
  end

  def update_without_turbolinks
    render turbolinks: false
  end

  def update_with_json_response
    render json: { result: 'ok' }
  end

  def update_with_500_error
    raise 'OMG this is a 500 error'
  end

  def update_ignored; end

  def update_ignored_subpath
    render action: 'update_ignored'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def task_params
    params.require(:task).permit(:title)
  end
end
