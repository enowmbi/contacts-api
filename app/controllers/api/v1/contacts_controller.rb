module Api
  module V1
    class ContactsController < ApplicationController
      def index
        render json: Contact.all
      end

      def create
        contact = Contact.new(contact_params)
        if contact.save!
          render json: contact, status: :created
        else
          render json: contact.errors, status: :unprocessable_entity
        end
      end

      private

      def contact_params
        params.require(:contact).permit(:name, :email)
      end
    end
  end
end
