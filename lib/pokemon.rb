class Pokemon

  attr_accessor :name, :type, :db, :id, :hp
  # attr_reader :id

  def initialize(attributes={})
    @name = attributes[:name]
    @type = attributes[:type]
    @db = attributes[:db]
    @hp = attributes[:hp]
    @id = attributes[:id]
  end


### INSTANCE METHODS ###

  def self.create(attributes={})
    new_pokemon = self.new({name: name, type: type, db: db})
    new_pokemon
  end

  def self.new_from_db(row, db)
    new_pokemon = self.new({id: row[0], name: row[1], type: row[2], hp: row[3], db: db})
    new_pokemon
  end

  def self.save(name, type, db)
    # new_pokemon = self.new({name: name, type: type, db: db})
    # if new_pokemon.id
    #
    # else
      sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?, ?)
      SQL
      # db.execute(sql, new_pokemon.name, new_pokemon.type)
      db.execute(sql, name, type)
      # new_pokemon.id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    # end
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon WHERE id = ?
    SQL
    results = db.execute(sql, [id]).first #.create(db.execute(sql, [id]).first)
    self.new_from_db(results, db)
  end

  def alter_hp(hp, db)
    sql = <<-SQL
      UPDATE pokemon SET hp = ? WHERE id = ?
    SQL
    db.execute(sql, [hp], [self.id])
  end
end
