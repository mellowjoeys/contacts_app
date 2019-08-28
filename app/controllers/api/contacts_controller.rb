class Api::ContactsController < ApplicationController
  def first_contact_action
    @contact = Contact.find(1) # Contact.find_by(id:1) or Contact.first works as well. 
    render 'first_view.json.jb'
  end

  def all_contacts_action
    @contacts = Contact.all
    render 'all_view.json.jb'
  end
end
