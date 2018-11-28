require('pg')

class Bounty

  attr_accessor :name, :bounty_value, :danger_level, :last_location, :homeworld, :weapon, :captured, :collected_by
  attr_reader :id
  def initialize(details)
    @id = details['id'].to_i if details['id']
    @name = details['name']
    @bounty_value = details['bounty_value'].to_i()
    @danger_level = details['danger_level']
    @last_location = details['last_location']
    @homeworld = details['homeworld']
    @weapon = details['weapon']
    @captured = (details['captured'] == 't')
    @collected_by = details['collected_by']
  end

  def save()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "INSERT INTO bounties (name, bounty_value, danger_level, last_location, homeworld, weapon, captured, collected_by)
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *;"
    values = [@name, @bounty_value, @danger_level, @last_location, @homeworld, @weapon, @captured, @collected_by]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i()
    db.close()
  end

  def Bounty.delete_all()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "DELETE FROM bounties;"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def Bounty.all()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "SELECT * FROM bounties;"
    db.prepare("all", sql)
    bounties = db.exec_prepared("all")
    db.close()
    return bounties.map { |bounty| Bounty.new(bounty) }
  end

  def delete()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "DELETE FROM bounties WHERE id = $1;"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def update()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "UPDATE bounties SET (name, bounty_value, danger_level, last_location, homeworld, weapon, captured, collected_by) = ($1, $2, $3, $4, $5, $6, $7, $8) WHERE id = $9;"
    values = [@name, @bounty_value, @danger_level, @last_location, @homeworld, @weapon, @captured, @collected_by, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def Bounty.find_by_name(name)
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "SELECT * FROM bounties WHERE name = $1;"
    values = [name]
    db.prepare("find_by_name", sql)
    bounty = db.exec_prepared("find_by_name", values)
    results = bounty.map { |bounty| Bounty.new(bounty) }
    db.close()
    if (results == [])
      return nil
    else
      return results
    end
  end

  def Bounty.find(id)
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "SELECT * FROM bounties WHERE id = $1;"
    values = [id]
    db.prepare("find", sql)
    bounty = db.exec_prepared("find", values)
    results = bounty.map { |bounty| Bounty.new(bounty) }
    db.close()
    if (results == [])
      return nil
    else
      return results
    end
  end

end
