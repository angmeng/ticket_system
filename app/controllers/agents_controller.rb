class AgentsController < ApplicationController
  # GET /agents
  # GET /agents.json
  def index
    if is_admin?
      @agents = Agent.all
    elsif is_agent?
      @agents = current_user.sub_agents
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @agents }
    end
  end

  # GET /agents/1
  # GET /agents/1.json
  def show
    if is_admin?
      @agent = Agent.find(params[:id])
    elsif is_agent?
      @agent = current_user.sub_agents.where("id = ?", params[:id]).first
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @agent }
    end
  end

  # GET /agents/new
  # GET /agents/new.json
  def new
    if is_admin?
      @agent = Agent.new({category_id: UserType::AGENT})
    elsif is_agent?
      @agent = Agent.new({category_id: UserType::SUB_AGENT})
    end
    #@agent.category_id = UserType::AGENT

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @agent }
    end
  end

  # GET /agents/1/edit
  def edit
    if is_admin?
      @agent = Agent.find(params[:id])
    elsif is_agent?
      @agent = current_user.sub_agents.where("id = ?", params[:id]).first
    end
  end

  # POST /agents
  # POST /agents.json
  def create
    @agent = Agent.new(params[:agent])

    respond_to do |format|
      if @agent.save
        format.html { redirect_to @agent, notice: 'Agent was successfully created.' }
        format.json { render json: @agent, status: :created, location: @agent }
      else
        format.html { render action: "new" }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /agents/1
  # PUT /agents/1.json
  def update
    if is_admin?
      @agent = Agent.find(params[:id])
    elsif is_agent?
      @agent = current_user.sub_agents.where("id = ?", params[:id]).first
    end

    respond_to do |format|
      if @agent.update_attributes(params[:agent])
        format.html { redirect_to @agent, notice: 'Agent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agents/1
  # DELETE /agents/1.json
  def destroy
    if is_admin?
      @agent = Agent.find(params[:id])
    elsif is_agent?
      @agent = current_user.sub_agents.where("id = ?", params[:id]).first
    end
    @agent.destroy

    respond_to do |format|
      format.html { redirect_to agents_url }
      format.json { head :no_content }
    end
  end
end
