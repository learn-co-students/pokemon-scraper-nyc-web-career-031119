class Pokemon
  attr_accessor :id,:name,:type,:hp,:db

  def initialize(id:,name:,type:,hp:nil,db:)
    @id = id
    @name = name
    @type = type
    @hp = 60
    @db = db
  end

  def self.save(name,type,db)
    sql = <<-SQL
    INSERT INTO pokemon(name,type)
    VALUES (?,?)
    SQL
    db.execute(sql,[name,type])
  end

  def self.find(id,db)
    sql = <<-SQL
    SELECT *
    FROM pokemon
    WHERE id = ?
    SQL
    pokemon = db.execute(sql,id).first
    Pokemon.new(id:id,name:pokemon[1],type:pokemon[2],hp:pokemon[3],db:db)
  end

  def alter_hp(hp,db)
    sql = <<-SQL
    UPDATE pokemon
    SET hp = ?
    WHERE id = ?
    SQL
    db.execute(sql,[hp],[self.id])
  end
end
