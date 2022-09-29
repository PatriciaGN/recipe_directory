# Recipes Model and Repository Classes Design Recipe

1. Design and create the Table
If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.

In this template, we'll use an example table students

# EXAMPLE

Table: recipes

Columns:
id | name | average_cooking_time | rating

2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.
```sql
-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE recipes RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (name, average_cooking_time, rating) VALUES ("Lentil stew", 30, 4)
INSERT INTO recipes (name, average_cooking_time, rating) VALUES ("Spanish omelette", 45, 5)
INSERT INTO recipes (name, average_cooking_time, rating) VALUES ("Stir-fry", 20, 3)


psql -h 127.0.0.1 recipes_directory < seeds_recipes.sql
```

3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

# EXAMPLE
# Table name: recipes

# Model class
# (in lib/recipe.rb)
class Recipe
end



4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: recipes

# Model class
# (in lib/recipe.rb)

class Artist
  attr_accessor :id, :name, :average_cooking_time, :rating
end


5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# EXAMPLE
# Table name: recipes

# Model class
# (in lib/recipes.rb)
```ruby
class Recipe
  attr_accessor :id, :name, :average_cooking_time, :rating
end
```

# Repository class
# (in lib/recipes_repository.rb)
```ruby
class RecipesRepository

  # Selecting all artists
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, genre FROM artists;

    # Returns an array of Artist objects.
  end
  
  # Select a single record
  # Given the id in argument (a number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, genre FROM artists WHERE id = $1
    # Returns a single artist object
end
```

6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all recipes
```ruby
repo = RecipesRepository.new

recipes = repo.all

recipes.length #=> 3
recipes.first.name #=> "Lentil stew"
recipes.first.average_cooking_time #=> "30"
recipes.first.rating #=> "4"
```

# When there are no recipes in the DB
```ruby
repo = RecipesRepository.new

recipes = repo.all #=> []
# We would need a seed that only truncates the tables but doesn't add any data.



  # 2
  # Get a single recipe

  repo = RecipesRepository.new

  recipe = repo.find(1)
  recipe.name #=> "Lentil stew"
  recipe.average_cooking_time #=> "30"
  recipe.rating #=> "4"

```


# Add more examples for each method
Encode this example as a test.

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE
```ruby
# file: spec/recipes_repository_spec.rb

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
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
    expect(recipes.first.average_cooking_time).to eq 30 #=> "30"
    expect(recipes.first.rating).to eq 4 #=> "4"
  end

  it "gets a single recipe" do
    repo = RecipesRepository.new

    recipe = repo.find(1)
    expect(recipe.name).to eq "Lentil stew" #=> "Lentil stew"
    expect(recipe.average_cooking_time).to eq 30 #=> "30"
    expect(recipe.rating) to eq 4 #=> "4"
  end

  it "gets a single recipe" 
    repo = RecipesRepository.new

    recipe = repo.find(2)
    expect(recipe.name).to eq "Spanish omelette" #=> "Lentil stew"
    expect(recipe.average_cooking_time).to eq 45 #=> "30"
    expect(recipe.rating) to eq 5 #=> "4"
  end
```


end
8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.

