class Pokemon
  attr_accessor :name, :type, :hp, :db
  attr_reader :id

  def initialize(id:, name:, type:, hp:nil, db:)
    @id = id
    @name = name
    @type = type
    @hp = hp
    @db = db
  end

  def self.save(name, type, db)
      db.execute("INSERT INTO pokemon(name, type) VALUES (?, ?)",[name, type])
  end

  def self.find(id_num, db)
    new_poke = db.execute("SELECT * FROM pokemon WHERE id = ?", id_num).flatten
    Pokemon.new(id: new_poke[0], name: new_poke[1], type: new_poke[2], hp: new_poke[3], db: db)
  end

  def alter_hp(new_hp, db)
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", new_hp, self.id)
  end
end
