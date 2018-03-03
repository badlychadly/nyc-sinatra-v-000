class FiguresController < ApplicationController


  get '/figures' do
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.create(name: params[:figure][:name])
    @figure.title_ids = params[:figure][:title_ids]
    @figure.landmark_ids = params[:figure][:landmark_ids]
    @figure.titles.create(params[:title]) unless params[:title][:name].empty?
    @figure.landmarks.create(params[:landmark]) unless params[:landmark][:name].empty?
    @figure.save

    redirect to("/figures/#{@figure.id}")
  end

  get '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by(id: params[:id])
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    @figure.update(params[:figure])
    @figure.landmarks.create(params[:landmark]) unless params[:landmark][:name].empty?
    @figure.titles.create(params[:title]) unless params[:title][:name].empty?

    redirect to("/figures/#{@figure.id}")
  end

end
