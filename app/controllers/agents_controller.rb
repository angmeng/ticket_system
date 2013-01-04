class AgentsController < ApplicationController
  # GET /agents
  # GET /agents.json
  def index
    @branch = Branch.find params[:branch_id]
    @agents = @branch.agents

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @agents }
    end
  end

  # GET /agents/1
  # GET /agents/1.json
  def show
    @branch = Branch.find params[:branch_id]
    @agent = @branch.agents.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @agent }
    end
  end

  # GET /agents/new
  # GET /agents/new.json
  def new
    @branch = Branch.find params[:branch_id]
    @agent = @branch.agents.new({category_id: UserType::AGENT})
    #@agent.category_id = UserType::AGENT

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @agent }
    end
  end

  # GET /agents/1/edit
  def edit
    @branch = Branch.find params[:branch_id]
    @agent = @branch.agents.find(params[:id])
  end

  # POST /agents
  # POST /agents.json
  def create
    @branch = Branch.find params[:branch_id]
    @agent = @branch.agents.new(params[:agent])

    respond_to do |format|
      if @agent.save
        format.html { redirect_to branch_agent_path(@branch, @agent), notice: 'Agent was successfully created.' }
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
    @branch = Branch.find params[:branch_id]
    @agent = @branch.agents.find(params[:id])

    respond_to do |format|
      if @agent.update_attributes(params[:agent])
        format.html { redirect_to branch_agent_path(@branch, @agent), notice: 'Agent was successfully updated.' }
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
    @branch = Branch.find params[:branch_id]
    @agent = @branch.agents.find(params[:id])
    @agent.destroy

    respond_to do |format|
      format.html { redirect_to branch_agents_url(@branch) }
      format.json { head :no_content }
    end
  end
end
