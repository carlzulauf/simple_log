class NamespacesController < ApplicationController
  def index
  end

  def show
    @namespace = Namespace.find_by!(uuid: params[:id])
  end

  def create
    namespace = Namespace.find_or_create_by(name: params.dig(:namespace, :name))
    redirect_to namespace
  end
end
