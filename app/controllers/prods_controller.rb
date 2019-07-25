class ProdsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @prod = Prod.new
  end

  def index
  end

  def show
    @prod = Prod.find_by_id(params[:id])
    if @prod.blank?
      render plain: 'Not found :(', status: :not_found
    end
  end

  def create
    @prod = current_user.prods.create(prod_params)
    if @prod.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def prod_params
    params.require(:prod).permit(:name, :description, :cost)
  end

end
