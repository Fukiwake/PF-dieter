class FindersController < ApplicationController

  def finder
    @q = Customer.ransack(params[:q])
    @customers = @q.result(distinct: true).page(params[:page]).per(20)
  end
end
