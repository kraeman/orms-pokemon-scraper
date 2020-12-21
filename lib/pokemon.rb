class Pokemon
    attr_accessor :name, :type, :db
    attr_reader :id

    def initialize(id:, name:, type:, db:)
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

    def self.find(id, db)
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id = ?
            LIMIT 1
        SQL
        result = db.execute(sql, id)[0]
        hash = {id: result[0], name: result[1], type: result[2], db: db}
        self.new(hash)
    end

    def update
        sql = "UPDATE pokemon SET name = ?, type = ?, db = ? WHERE id = ?"
        @db.execute(sql, self.name, self.type, self.db, self.id)
    end
end
