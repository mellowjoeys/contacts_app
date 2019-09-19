class Api::ContactsController < ApplicationController
  
  def index
    @contacts = Contact.all

    first_name_search = params[:first_name]
    midd_name_search = params[:middle_name]
    last_name_search = params[:last_name]
    email_search = params[:email]
    group_filter = params[:group]

    search_term = params[:search]

    if current_user && group_filter
      group = Group.find_by(name: group_filter)
      @contacts = group.contacts.where(user_id: current_user.id)
    elsif current_user
      @contacts = current_user.contacts
    else
      @contacts = Contact.all
    end

    if search_term
      @contacts = @contacts.where(
                                  "first_name iLIKE ? OR last_name iLIKE ? OR middle_name iLIKE ? OR email iLIKE ?",
                                  "%#{search_term}%", 
                                  "%#{search_term}%", 
                                  "%#{search_term}%", 
                                  "%#{search_term}%"
                                  )
    end

    render 'index.json.jb'
  end

  def create
    @contact = Contact.new(
                            first_name: params[:first_name],
                            middle_name: params[:middle_name],
                            last_name: params[:last_name],
                            email: params[:email],
                            phone_number: params[:phone_number],
                            bio: params[:bio]
                          )
    if @contact.save
      render 'show.json.jb'
    else
      render json: {errors: @contact.errors.full_messages, status: unprocessable_entity}
    end
  end

  def show
    @contact = Contact.find(params[:id])
    # @contact = Contact.find_by(id: params[:id]) long form syntax
    render 'show.json.jb'
  end

  def update
    @contact = Contact.find(params[:id])

    @contact.first_name = params[:first_name] || @contact.first_name
    @contact.middle_name = params[:middle_name] || @contact.middle_name
    @contact.last_name = params[:last_name] || @contact.last_name
    @contact.email = params[:email] || @contact.email
    @contact.phone_number = params[:phone_number] || @contact.phone_number

    if @contact.save
      render 'show.json.jb'
    else
      render json: {error: @contact.errors.full_messages, status: unprocessable_entity}
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    render json: {message: 'Contact has been deleted'}
  end

end
