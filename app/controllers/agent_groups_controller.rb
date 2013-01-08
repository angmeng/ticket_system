class AgentGroupsController < ApplicationController
  # GET /agent_groups
  # GET /agent_groups.json
  def index
    @search = AgentGroup.search(params[:search])
    @agent_groups = @search.page(params[:page]).per(25)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @agent_groups }
    end
  end

  # GET /agent_groups/1
  # GET /agent_groups/1.json
  def show
    @agent_group = AgentGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @agent_group }
    end
  end

  # GET /agent_groups/new
  # GET /agent_groups/new.json
  def new
    @agent_group = AgentGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @agent_group }
    end
  end

  # GET /agent_groups/1/edit
  def edit
    @agent_group = AgentGroup.find(params[:id])
  end

  # POST /agent_groups
  # POST /agent_groups.json
  def create
    @agent_group = AgentGroup.new(params[:agent_group])

    respond_to do |format|
      if @agent_group.save
        format.html { redirect_to @agent_group, notice: 'Agent group was successfully created.' }
        format.json { render json: @agent_group, status: :created, location: @agent_group }
      else
        format.html { render action: "new" }
        format.json { render json: @agent_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /agent_groups/1
  # PUT /agent_groups/1.json
  def update
    @agent_group = AgentGroup.find(params[:id])

    respond_to do |format|
      if @agent_group.update_attributes(params[:agent_group])
        format.html { redirect_to @agent_group, notice: 'Agent group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @agent_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agent_groups/1
  # DELETE /agent_groups/1.json
  def destroy
    @agent_group = AgentGroup.find(params[:id])
    @agent_group.destroy

    respond_to do |format|
      format.html { redirect_to agent_groups_url }
      format.json { head :no_content }
    end
  end
end
