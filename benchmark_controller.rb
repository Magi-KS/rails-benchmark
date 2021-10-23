class BenchmarkController < ApplicationController
  def hello_world
    render plain: 'hello world'
  end

  def simulated_io
    sleep params[:delay].to_i
    render plain: 'simulated io'
  end
end
