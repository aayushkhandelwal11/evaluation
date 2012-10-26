class TodoListsController < ApplicationController
  
  def index
    @todolists = current_user.todo_lists

    respond_to do |format|
      format.html 
      format.json { render json: @todolists }
    end
  end

  def show
    @todolist = TodoList.find(params[:id])

    respond_to do |format|
      format.html 
      format.json { render json: @todolist }
    end
  end

  def new
    @todolist = TodoList.new

    respond_to do |format|
      format.html
      format.json { render json: @todolist }
    end
  end

  def edit
    @todolist = TodoList.find(params[:id])
  end

  def create
    @todolist = current_user.todo_lists.build(params[:todolist])

    respond_to do |format|
      if @todolist.save
        format.html { redirect_to @todolist, notice: 'List was successfully created.' }
        format.json { render json: @todolist, status: :created, location: @todolist }
      else
        format.html { render action: "new" }
        format.json { render json: @todolist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @todolist = Post.find(params[:id])

    respond_to do |format|
      if @todolist.update_attributes(params[:post])
        format.html { redirect_to @todolist, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @todolist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @todolist = Post.find(params[:id])
    @todolist.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
