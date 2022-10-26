require 'recipe'
require 'recipe_repository'



RSpec.describe RecipeRepository do
  
  def reset_recipes_table
    seed_sql = File.read('spec/seeds_recipes.sql')
    connection = PG.connect({host: '127.0.0.1', dbname: 'recipes_directory'})
    connection.exec(seed_sql)
  end
  
  before(:each) do
    reset_recipes_table
  end  

  it 'returns the values of all recipes' do
    repo = RecipeRepository.new

    recipes = repo.all

    expect(recipes.length).to eq 2

    expect(recipes[0].id).to eq '1'
    expect(recipes[0].name).to eq 'Chili'
    expect(recipes[0].minutes).to eq '105'
    expect(recipes[0].rating).to eq '4'

    expect(recipes[1].id).to eq  '2'
    expect(recipes[1].name).to eq 'Lamb tagine'
    expect(recipes[1].minutes).to eq '240'
    expect(recipes[1].rating).to eq '5'
  end
  
  it 'finds a recipe by using a specific id' do
    repo = RecipeRepository.new

    recipe = repo.find(1)

    #expect(recipe.id).to eq '1'
    #expect(recipe.name).to eq 'Chili'
    expect(recipe.minutes).to eq '105'
    expect(recipe.rating).to eq '4'
  end  
end
