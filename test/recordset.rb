module SQLite

class TestRecordset

  def initialize()
    @db = SQLite::Database.new()
    rc = @db.open("#{$test_dir}/files/foods.db")
    
    if rc != SQLITE_OK
      puts @db.error()
    end
  end

  # This tests the general C->Ruby MessagePack compatibility as well as formal
  # Recordset pack format.
  #
  # Receive a MessagePack binary Recordset. Unpack it with Ruby MessagePack gem
  # and verify contents.
  #
  # Serialize back with MessagePack gem. C++ Unit test will verify contents.
  def msgPackToRuby(binary)
    recordset = MessagePack.unpack(binary)
    puts recordset
    
    assert recordset.class == Array

    headers = recordset[0]
    types   = recordset[1]
    records = recordset[2]

    assert headers.class == Array

    types.each do |v|
      assert v == Type::STRING
    end

    assert headers.join('|') == 'firstname|lastname'

    assert records.size == 1

    records.each do |row|
      assert row.size == 2
      assert row.join('|') == 'mike|owens'
    end

    return recordset.to_msgpack
  end

  # This tests the SQLite::Recordset MesagePack methods for
  # serializing/deserializing data.
  #
  # Receive a MessagePack binary Recordset. Unpack it with
  # SQLite::Recordset::fromMsgPack().
  #
  # Verify contents and serialize back with SQLite::Recordset::toMsgPack().  C++
  # Unit test will verify contents.

  def msgPackToRubyRecordset(data)
    recordset = SQLite::Recordset.new()
    recordset.fromMsgPack(data)

    assert recordset.columns[0] == 'id'
    assert recordset.columns[1] == 'type_id'
    assert recordset.columns[2] == 'name'

    assert recordset.types[0]   == 2
    assert recordset.types[1]   == 2
    assert recordset.types[2]   == 10

    rows = recordset.data

    assert rows[0][0]           == '1'
    assert rows[0][1]           == '100'
    assert rows[0][2]           == 'Bagels'

    assert rows[1][0]           == '2'
    assert rows[1][1]           == '100'
    assert rows[1][2]           == 'Bagels, raisin'

    assert rows[2][0]           == '3'
    assert rows[2][1]           == '100'
    assert rows[2][2]           == 'Bavarian Cream Pie'

    assert rows[3][0]           == '4'
    assert rows[3][1]           == '100'
    assert rows[3][2]           == 'Bear Claws'

    assert rows[4][0]           == '5'
    assert rows[4][1]           == '100'
    assert rows[4][2]           == 'Black and White cookies'

    assert rows[5][0]           == '6'
    assert rows[5][1]           == '100'
    assert rows[5][2]           == 'Bread (with nuts)'

    assert rows[6][0]           == '7'
    assert rows[6][1]           == '100'
    assert rows[6][2]           == 'Butterfingers'

    return recordset.toMsgPack()
  end

end

end # module SQLite
