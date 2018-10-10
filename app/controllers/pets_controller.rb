class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    if !params[:owner][:name].empty?
      owner = Owner.create(name: params[:owner][:name])
      @pet = Pet.create(name: params[:pet_name], owner_id: owner.id)
    else

      @pet = Pet.create(name: params[:pet_name], owner_id: params[:owner][:id])
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end


  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    if !params["new_owner"]["name"].empty?
      owner = Owner.create(name: params["new_owner"]["name"])
      @pet.name = params["pet"]["pet_name"]
      @pet.owner_id = owner.id
      @pet.save
    else
      # binding.pry
      @pet.name = params["pet"]["pet_name"]
      @pet.owner_id = params["owner"]["name"].to_i
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end
end
