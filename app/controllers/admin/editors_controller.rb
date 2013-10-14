class Admin::EditorsController < ApplicationController

  layout "admin"
  before_filter :authenticate, :except => [:login]

  def login
    if request.post?
       if editor = Editor.authenticate(params[:editor][:login], params[:editor][:password])
         if !editor.active
           flash[:notice]= 'Twoje konto jest nieaktywne.'
         else
           session[:editor_id] = editor.id
            redirect_to :controller => "admin/news", :action => "index"
         end
      else
         flash[:notice]= 'Nieprawidłowe dane logowania.'
      end
    end
  end

  def logout
    session[:editor_id] = nil
    redirect_to :controller => "admin/editors", :action => "login"
    flash[:notice] = 'Wylogowałeś się.'
  end

# tylko admin
  def block 
    @editor = Editor.find(params[:id])
    @editor.active = false;
    @editor.save
    redirect_to(admin_editors_path)
  end

# tylko admin
 def unblock 
      @editor = Editor.find(params[:id])
      @editor.active = true;
      @editor.save
      redirect_to(admin_editors_path)
  end

  def index
    @editors = Editor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @editors }
    end
  end

#only logged in
  def showme
    @editor = Editor.find session[:editor_id]

  end

# only admin
  def new
    @editor = Editor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @editor }
    end
  end

# only admin
  def edit
    @editor = Editor.find(params[:id])
  end

#only logged in
  def editme
    @editor = Editor.find session[:editor_id]
  end

  def create
    @editor = Editor.new(params[:editor])
    @editor.active = true
    respond_to do |format|
      if @editor.save
      flash[:notice] = 'Dodano nowego edytora'
        format.html { redirect_to(admin_editors_path) }
        format.xml  { render :xml => @editor, :status => :created, :location => @editor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @editor.errors, :status => :unprocessable_entity }
      end
    end
  end

# only admin
  def update
    @editor = Editor.find(params[:id])

    respond_to do |format|
      if @editor.update_attributes(params[:editor])
        flash[:notice] = 'Zmieniono dane edytora.'
        format.html { redirect_to(admin_editors_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @editor.errors, :status => :unprocessable_entity }
      end
    end
  end

#only logged in
  def updateme
    @editor = Editor.find session[:editor_id]

    respond_to do |format|
      if @editor.update_attributes(params[:editor])
        flash[:notice] = 'Zmieniłeś swoje dane.'
        format.html { redirect_to(:controller => "admin/editors", :action => :showme) }
        format.xml  { head :ok }
      else
        format.html { render :action => "editme" }
        format.xml  { render :xml => @editor.errors, :status => :unprocessable_entity }
      end
    end
  end
  def destroy
    @editor = Editor.find(params[:id])
    @editor.destroy

    respond_to do |format|
      flash[:notice] = 'Usunięto edytora.'
      format.html { redirect_to(admin_editors_path) }
      format.xml  { head :ok }
    end
  end
end
