require_relative "../lib/recipes_repository.rb"

def reset_recipes_table
    seed_sql = File.read('spec/seeds_recipes.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory' })
    connection.exec(seed_sql)
end
  
describe RecipesRepository do
    before(:each) do 
      reset_recipes_table
    end
    
    it "gets all recipes" do
      repo = RecipesRepository.new
  
      recipes = repo.all
  
      expect(recipes.length).to eq 3 #=> 3
      expect(recipes.first.name).to eq "Lentil stew"  #=> "Lentil stew"
      expect(recipes.first.average_cooking_time).to eq "30" #=> "30"
      expect(recipes.first.rating).to eq "4" #=> "4"
    end
  
    it "gets a single recipe" do
      repo = RecipesRepository.new
  
      recipe = repo.find(1)
      expect(recipe.name).to eq "Lentil stew" #=> "Lentil stew"
      expect(recipe.average_cooking_time).to eq "30" #=> "30"
      expect(recipe.rating).to eq "4" #=> "4"
    end
  
    it "gets a single recipe" do
      repo = RecipesRepository.new
  
      recipe = repo.find(2)
      expect(recipe.name).to eq "Spanish omelette" #=> "Lentil stew"
      expect(recipe.average_cooking_time).to eq "45" #=> "30"
      expect(recipe.rating).to eq "5" #=> "4"
    end
end
