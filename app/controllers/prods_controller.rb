class ProdsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def destroy
    @prod = Prod.find_by_id(params[:id])
    return render_not_found if @prod.blank?
    return render_not_found(:forbidden) if @prod.user != current_user
    @prod.destroy
    redirect_to root_path
  end

  def update
    @prod = Prod.find_by_id(params[:id])
    return render_not_found if @prod.blank?
    return render_not_found(:forbidden) if @prod.user != current_user

    @prod.update_attributes(prod_params)
    if @prod.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def new
    @prod = Prod.new
    @categories = Category.all
  end

  def index
    @prods = Prod.all
  end

  def show
    @prod = Prod.find_by_id(params[:id])
    if @prod.blank?
      return render_not_found if @prod.blank?
    end
  end

  def edit
    @prod = Prod.find_by_id(params[:id])
    return render_not_found if @prod.blank?
    return render_not_found(:forbidden) if @prod.user != current_user
  end

  def create
    @prod = current_user.prods.create(prod_params)
    if @prod.valid?
      redirect_to prods_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def prod_params
    params.require(:prod).permit(:name, :description, :cost, :category_id)
  end

  def render_not_found(status=:not_found)
    render plain: '#{status.to_s.titlesize} :(', status: status
  end

end
