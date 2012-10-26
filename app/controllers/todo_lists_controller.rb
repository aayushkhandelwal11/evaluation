class TodoListsController < ApplicationController
  before_filter :check_owner, :only => [:edit, :update]
  def check_owner
     todolist = TodoList.find(params[:id])
   
     if todolist.user_id.to_s != current_user.id.to_s

       flash.alert = "You are not authorized fro this "
       redirect_to todo_lists_url
     end
  end  
    
  def index
    @todolists = current_user.todo_lists

    respond_to do |format|
      format.html 
      format.json { render json: @todolists }
    end
  end

  def show
    @todolist = TodoList.find(params[:id])
    @items = @todolist.items.order(:priority)
    respond_to do |format|
      format.html 
      format.json { render json: @todolist }
    end
  end

  def new
    @todolist = TodoList.new
    5.times {@todolist.items.build}
    respond_to do |format|
      format.html
      format.json { render json: @todolist }
    end
  end

  def edit
    @todolist = TodoList.find(params[:id])
    x = 5 - @todolist.items.count 
    x.times {@todolist.items.build}
  end

  def create
    @todolist = current_user.todo_lists.build(params[:todo_list])
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


  def update
    @todolist = TodoList.find(params[:id])

    respond_to do |format|
      if @todolist.update_attributes(params[:todo_list])
        format.html { redirect_to @todolist, notice: 'todolist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @todolist.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @todolist = TodoList.find(params[:id])
    @todolist.destroy

    respond_to do |format|
      format.html { redirect_to todo_lists_url }
      format.json { head :no_content }
    end
  end
end
