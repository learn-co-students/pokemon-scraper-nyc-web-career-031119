require 'pry'

class Pokemon

  attr_accessor :name, :type, :db, :hp
  attr_reader :id

  def initialize(id: nil, name:, type:, db:, hp: nil)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
  end

  def self.save(name, type, db)
    pk = Pokemon.new(name: name, type: type, db: db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?);
    SQL

    db.execute(sql, pk.name, pk.type)
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?;
    SQL

    info = db.execute(sql, id)[0]
    Pokemon.new(id: id, name: info[1], type: info[2], db: db, hp: info[3])
  end

  def alter_hp(hp, db)
    sql = <<-SQL
      UPDATE pokemon
      SET hp = ?
      WHERE name = ?
    SQL

    db.execute(sql, hp, self.name)
  end
end
