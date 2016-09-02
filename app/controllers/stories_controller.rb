class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /stories
  # GET /stories.json
  
  def index
    @stories = Story.all.order(cached_votes_score => :desc)
  end
  
  def index
    @stories = Story.all.order.reverse.order
  end
  
  def index
    @stories = Story.where(["content LIKE ?", "%#{params[:search]}%"])
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
  end

  # GET /stories/new
  def new
    @story = current_user.stories.build
  end

  # GET /stories/1/edit
  def edit
  end

  # story /stories
  # story /stories.json
  def create
    @story = current_user.stories.build(story_params)

    respond_to do |format|
      if @story.save
        format.html { redirect_to stories_path, notice: 'Story was successfully created.' }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { render :new }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to @story, notice: 'Story was successfully updated.' }
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story.destroy
    respond_to do |format|
      format.html { redirect_to stories_url, notice: 'Story was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  #upvote_from user
  #downvote_from user
  def upvote
    @story.upvote_from current_user
    redirect_to stories_path
  end
  
  def downvote
    @story.downvote_from current_user
    redirect_to stories_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      params.require(:story).permit(:title, :description, :content)
    end
    def correct_user
      @story = current_user.stories.find_by(id: params[:id])
      redirect_to stories_path, notice: "Ah! You can't touch this. This is not your story" if @story.nil?
    end
end
