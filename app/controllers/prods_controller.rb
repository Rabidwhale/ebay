class ProdsController < ApplicationController
  def new
    @prod = Prod.new
  end

  def index
  end

  def create
    @prod = Prod.create(prod_params)
    redirect_to root_path
  end

  private

  def prod_params
    params.require(:prod).permit(:name, :description, :cost)
  end

end
