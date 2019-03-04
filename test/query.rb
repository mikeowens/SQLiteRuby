class TestQuery < MiniTest::Test

  def setup()
    @db = SQLite::Database.new()
    rc = @db.open("#{$test_dir}/files/foods.db")
    
    if rc != SQLITE_OK
      puts @db.error()
    end    
  end

  def teardown()  
    
  end

  def test_native_query()
    query = @db.prepare('select * from foods')
    
    while query.step() == SQLITE_ROW
      # Step though each field in row.
      # k is column name, v is field value
      query.each do |k,v|
        #puts "  #{k}: #{v}"
      end    
    end
  end

  def dont_test_row_query()
    # Create a query
    query = SQLite::Query.new(@db)
    
    # Select records
    sql = %Q{ select * from foods order by name }
    recordset = query.exec(sql)
    
    # Iterate and print
    recordset.each do |row|
      puts "%3i %2i %-30s" % [row['id'], row[1], row[2]]
    end
  end
  
end
