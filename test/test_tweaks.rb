require 'helper'

class TestArrayMapWithIndexTweak < Test::Unit::TestCase
  should "have map_with_index method." do
    abc = ['a', 'あ', 'z'].map_with_index { |it, idx| [it, idx]}
    assert_equal [['a',0], ['あ',1], ['z',2]], abc
    xyz = ['a', 'あ', 'z']
    xyz.map_with_index! { |it, idx| [it, idx]}
    assert_equal [['a',0], ['あ',1], ['z',2]], xyz
  end
end

class TestArrayRefmapTweak < Test::Unit::TestCase
  should "have refmmap method." do
    class Resp
      def initialize(name, desc)
        @name = name; @desc = desc
      end
      attr_reader :name, :desc
    end
    r0 = Resp.new('a', 'いろは'); r1 = Resp.new('xyz', 12345)
    array = [r0, r1]
    ref_names = array.refmap(&:name)
    assert_equal ['a', 'xyz'], ref_names.keys.sort
    assert_equal r1, ref_names['xyz']
  end
end

class TestHashFromJsonTweak < Test::Unit::TestCase
  should "have hash_from_json method." do
    h = {:a => 100, :b => {:c => 200, :d => 'abc'}}
    hr = {'a' => 100, 'b' => {'c' => 200, 'd' => 'abc'}}
    j = h.to_json
    h2 = Hash.from_json j
    assert_equal hr, h2
  end
end

class TestHashPathableTweak < Test::Unit::TestCase
  should "have path method." do
    h = { :a => { :b => { :c => 123, :d => [{ :e => 'val-e'}, { :f => 'val-f' }]}}}
    assert_equal 123, h.path('/a/b/c')
    assert_equal 123, h.path('a/b/c')
    assert_equal 'val-f', h.path('/a/b/d[1]/f')
    assert_equal 'val-e', h.path('a/b/d[0]/e')
    assert_nil h.path('/x/y/z')
  end
end

class MooMoo; end

class TestObjectClassConfigTweak < Test::Unit::TestCase
  should "read class_config from yaml." do
    ::RAILS_ROOT = "test/files/root1"
    assert_equal 'Test 01 Value', Object.class_config['test01']
    assert_equal 'http://www.google.co.jp/', MooMoo.class_config['test02']
  end
end
