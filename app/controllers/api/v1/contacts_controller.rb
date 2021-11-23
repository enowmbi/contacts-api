module Api
  module V1
    class ContactsController < ApplicationController
      def index
        render json: Contact.all
      end

      def create

      end
    end
  end
end
