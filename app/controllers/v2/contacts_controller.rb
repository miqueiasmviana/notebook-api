module V2
  class ContactsController < ApplicationController
    before_action :set_contact, only: %i[ show update destroy ]
    
    # GET /contacts
    def index
      @contacts = Contact.last(10)
      render json: @contacts
    end

    # GET /contacts/1
    def show
      render json: @contact , include: [:kind, :address, :phones] #, meta: { author: "Eduardo Bolsonaro"} #,  #, include: [:kind, :phones, :address]
    end

    # POST /contacts
    def create
      @contact = Contact.new(contact_params)

      if @contact.save
        render json: @contact, include: [:kind, :phones, :address], status: :created, location: v2_contact_url(@contact)
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /contacts/1
    def update
      if @contact.update(contact_params)
        render json: @contact, include: [:kind, :phones, :address]
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    # DELETE /contacts/1
    def destroy
      @contact.destroy!
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_contact
        @contact = Contact.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def contact_params
      #   params.require(:contact).permit(
      #     :name, :email, :birthdate, :kind_id,
      #     phones_attributes: [:id, :number, :_destroy],
      #     address_attributes: [:id, :street, :city])
          ActiveModelSerializers::Deserialization.jsonapi_parse(params)

      end
  end
end