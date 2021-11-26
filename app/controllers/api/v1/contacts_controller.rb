# frozen_string_literal: true

module Api
  module V1
    # handles CRUD operations on contacts
    class ContactsController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :display_error_message_when_record_not_found

      before_action :set_contact, only: [:show, :update, :destroy]

      def index
        contacts = Contact.all
        render json: contacts
      end

      def show
        render json: @contact
      end

      def create
        contact = Contact.new(contact_params)
        if contact.save!
          render json: contact, status: :created
        else
          render json: contact.errors.full_messages, status: :unprocessable_entity
        end
      end

      def update
        if @contact.update(contact_params)
          render json: @contact
        else
          render json: @contact.errors.full_messages, status: :unprocessable_entity
        end
      end

      def destroy
        if @contact.destroy
          head :no_content
        else
          render json: @contact.errors.full_messages, status: :unprocessable_entity
        end
      end

      private

      def set_contact
        @contact = Contact.find(params[:id])
      end

      def contact_params
        params.require(:contact).permit(:name, :email)
      end

      def display_error_message_when_record_not_found
        render json: { error: "Contact with specified ID(#{params[:id]}) Not found" }, status: :not_found
      end
    end
  end
end
