class ProdsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def destroy
    @prod = Prod.find_by_id(params[:id])
    return render_not_found if @prod.blank?
    @prod.destroy
    redirect_to root_path
  end

  def update
    @prod = Prod.find_by_id(params[:id])
    return render_not_found if @prod.blank?

    @prod.update_attributes(prod_params)

    if @prod.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def new
    @prod = Prod.new
  end

  def index
  end

  def show
    @prod = Prod.find_by_id(params[:id])
    if @prod.blank?
      return render_not_found if @prod.blank?
    end
  end

  def edit
    @prod = Prod.find_by_id(params[:id])
    if @prod.blank?
      return render_not_found if @prod.blank?
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

  def render_not_found
    render plain: 'Not Found :(', status: :not_found
  end
end
