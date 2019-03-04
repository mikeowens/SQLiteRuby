# Ruby SQLite C Extension

## About

This is a stripped-down Ruby C extension for SQLite. It compiles/embeds the
SQLite amalgamation in the extension and provides a very simple SQLite API and
higher level Query/Recordset API.

To install from the internets:

```
    gem install sqlite
```

To build/install from source:

```
    git clone git@github.com:mikeowens/SQLiteRuby.git
    cd SQLiteRuby
    gem install rake-compiler
    rake
    rake gem
    cd pkg
    gem install -l sqlite-*.gem
```

## Usage

```ruby
    @db = SQLite::Database.new()
    rc = @db.open("#{$test_dir}/files/foods.db")
    
    if rc != SQLITE_OK
      puts @db.error()
    end    

    # Low-level SQLite statement handle API
    query = @db.prepare('select * from foods')
    
    while query.step() == SQLITE_ROW
      # Step though each field in row.
      # k is column name, v is field value
      query.each do |k,v|
        puts "  #{k}: #{v}"
      end    
    end

    # High level Query/Recordset API
    query = SQLite::Query.new(@db)

    recordset = query.exec %Q{ select * from foods order by name }
    
    # Rows can key on both column ordinals and/or name.
    recordset.each do |row|
      puts "%3i %2i %-30s" % [row['id'], row[1], row[2]]
    end
```
