class Pokemon

attr_accessor :id, :name, :type, :db, :hp

  def initialize(id:, name:, type:, hp:nil, db:)
  @id = id
  @name = name
  @type = type
  @db = db
  @hp = hp
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon(name, type)
      VALUES (?, ?)
     SQL
     db.execute(sql, [name, type])
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?
    SQL
    poke_new = db.execute(sql, id).first
    Pokemon.new(id: poke_new[0], name: poke_new[1], type: poke_new[2], hp: poke_new[3], db:db)
  end

  def alter_hp(hp, db)
    sql = <<-SQL
    "UPDATE songs SET hp = ?
     WHERE id = ?;"
    SQL
    db.execute(sql,[hp],[self.id])
  end


end
