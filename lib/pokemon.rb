require 'pry'
class Pokemon
  attr_accessor :id, :name, :type, :db, :hp

  def initialize(id: nil, name: name, type: type, db: @db, hp: 60)
    @name = name
    @type = type
  end

  def self.save(name, type, db)
    new_pokemon = Pokemon.new
    new_pokemon.name = name
    new_pokemon.type = type
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
    SQL
    db.execute(sql, new_pokemon.name, new_pokemon.type)
    new_pokemon.id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.new_from_db(row)
    new_pokemon = Pokemon.new
    new_pokemon.name = row[1]
    new_pokemon.type = row[2]
    new_pokemon.id = row[0]
    new_pokemon.hp = row[3]
    new_pokemon
  end

  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE id = ?"
    result = db.execute(sql, id)[0]
    self.new_from_db(result)
  end

  def alter_hp(hp, db)
    sql = "UPDATE pokemon SET hp = ? WHERE name = ?"
    db.execute(sql, hp, self.name)
  end
end
