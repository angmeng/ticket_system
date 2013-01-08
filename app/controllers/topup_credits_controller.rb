class TopupCreditsController < ApplicationController
  # GET /topup_credits
  # GET /topup_credits.json
  def index
    @search = TopupCredit.search(params[:search])
    @topup_credits = @search.page(params[:page]).per(25)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topup_credits }
    end
  end

  # GET /topup_credits/1
  # GET /topup_credits/1.json
  def show
    @topup_credit = TopupCredit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topup_credit }
    end
  end

  # GET /topup_credits/new
  # GET /topup_credits/new.json
  def new
    @topup_credit = TopupCredit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topup_credit }
    end
  end

  # GET /topup_credits/1/edit
  # def edit
  #   @topup_credit = TopupCredit.find(params[:id])
  # end

  # POST /topup_credits
  # POST /topup_credits.json
  def create
    @topup_credit = TopupCredit.new(params[:topup_credit])

    respond_to do |format|
      if @topup_credit.save
        format.html { redirect_to topup_credits_url, notice: 'Topup credit was successfully created.' }
        format.json { render json: @topup_credit, status: :created, location: @topup_credit }
      else
        format.html { render action: "new" }
        format.json { render json: @topup_credit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topup_credits/1
  # PUT /topup_credits/1.json
  # def update
  #   @topup_credit = TopupCredit.find(params[:id])

  #   respond_to do |format|
  #     if @topup_credit.update_attributes(params[:topup_credit])
  #       format.html { redirect_to @topup_credit, notice: 'Topup credit was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @topup_credit.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /topup_credits/1
  # DELETE /topup_credits/1.json
  def destroy
    @topup_credit = TopupCredit.find(params[:id])
    @topup_credit.destroy

    respond_to do |format|
      format.html { redirect_to topup_credits_url }
      format.json { head :no_content }
    end
  end
end
