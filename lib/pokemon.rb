class Pokemon
  attr_accessor :id, :name, :type, :db, :hp

  def initialize(id: nil, name:, type:, db: )
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)
      sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?, ?)
      SQL
      db.execute(sql, name, type)
  end

  def self.find(p_id, db)
    sql = <<-SQL
      SELECT *
      FROM pokemon as p
      WHERE p.id = ?
      SQL
      result = db.execute(sql, p_id)[0]
      pok = Pokemon.new(id: result[0], name: result[1], type: result[2], db: db)
      pok.hp = result[3]
      pok
  end

  def alter_hp(hp, db)
    name = self.name
    if name == "Pikachu"
      sql = <<-SQL
      UPDATE pokemon
      SET hp = #{hp}
      WHERE name = 'Pikachu'
      SQL
    elsif name = "Magikarp"
      sql = <<-SQL
      UPDATE pokemon
      SET hp = #{hp}
      WHERE name = 'Magikarp'
      SQL
    end
    db.execute(sql)
  end
end
