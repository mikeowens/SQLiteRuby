module SQLite

class Database
  
  def replace(table, hash)
    keys   = []
    values = []
    params = []
    
    hash.each { |k,v| keys << k; params << '?'; values << v }
    
    self.exec %Q{ replace into #{table}
                  (#{keys.join(',')})
                  values (#{params.join(",")}) }, values
  end

  def field(table, field, where)
    stmt = prepare %Q{ select #{field} from #{table} where #{where} }
    
    if stmt.step() != SQLITE_ROW
      finalize stmt
      return nil
    end

    value = stmt[0]
    finalize stmt
    
    return value
  end
  
  def delete(table, where)
    self.exec %Q{ delete from #{table} where #{where} }
  end
  
  def exists?(table, where)    
    res = prepare %Q{ select count(*) from #{table} where #{where} }

    if stmt.step() != SQLITE_ROW
      finalize stmt
      return false
    end

    value = stmt[0].to_i
    finalize stmt
        
    return value == 0 ? false : true
  end
  
end # class SQLite

end # module Database

class TestDatabase < MiniTest::Test

  def setup()
    @db = SQLite::Database.new()
    rc = @db.open("#{$test_dir}/files/foods.db")
    
    if rc != SQLITE_OK
      puts @db.error()
    end    
  end

  def teardown()  
    
  end

  def test_replace()
    # TODO
  end

  def test_field()
    # TODO
  end

  def test_delete()
    # TODO
  end

  def test_exit()
    # TODO
  end
  
end # class TestRecordset
