class PredefinedTagsController < ApplicationController
  filter_resource_access :additional_collection => {:complete => :read}

  # GET /predefined_tags
  # GET /predefined_tags.json
  def index
    @predefined_tags = PredefinedTag.with_permissions_to

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @predefined_tags }
    end
  end

  # GET /predefined_tags/platforms.json
  def complete
    t = PredefinedTag.arel_table
    @predefined_tags = PredefinedTag.with_permissions_to.
        where(context: params[:context]).
        where(t[:name].matches("#{params[:term]}%"))

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @predefined_tags.map { |m|
        m.name
      } }
    end
  end

  # GET /predefined_tags/1
  # GET /predefined_tags/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @predefined_tag }
    end
  end

  # GET /predefined_tags/new
  # GET /predefined_tags/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @predefined_tag }
    end
  end

  # GET /predefined_tags/1/edit
  def edit
  end

  # POST /predefined_tags
  # POST /predefined_tags.json
  def create
    respond_to do |format|
      if @predefined_tag.save
        format.html { redirect_to @predefined_tag, notice: 'Predefined tag was successfully created.' }
        format.json { render json: @predefined_tag, status: :created, location: @predefined_tag }
      else
        format.html { render action: "new" }
        format.json { render json: @predefined_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /predefined_tags/1
  # PUT /predefined_tags/1.json
  def update
    respond_to do |format|
      if @predefined_tag.update_attributes(params[:predefined_tag])
        format.html { redirect_to @predefined_tag, notice: 'Predefined tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @predefined_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /predefined_tags/1
  # DELETE /predefined_tags/1.json
  def destroy
    @predefined_tag.destroy

    respond_to do |format|
      format.html { redirect_to predefined_tags_url }
      format.json { head :no_content }
    end
  end
end
