# -*- encoding: utf-8 -*-
require 'helper'

require 'json'

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
  should "have refmap method." do
    class Resp
      def initialize(name, desc)
        @name = name; @desc = desc
      end
      attr_reader :name, :desc
    end
    class NullResp; end
    r0 = Resp.new('a', 'いろは'); r1 = Resp.new('xyz', 12345)
    array = [r0, r1]
    ref_names = array.refmap(NullResp.new, &:name)
    assert_equal ['a', 'xyz'], ref_names.keys.sort
    assert_equal r1, ref_names['xyz']
    assert_equal NullResp, ref_names['not-existent-key'].class
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

class TestHashRemapKeysTweak < Test::Unit::TestCase
  should "have remap_keys method" do
    h = {'a' => 1, 'b' => 2, 'c' => 3 }
    new_h = h.remap_keys do |key, value|
      "#{key}+"
    end
    expected = {'a+' => 1, 'b+' => 2, 'c+' => 3 }
    assert_equal expected, new_h
    h.remap_keys! do |key, value|
      "#{key}+"
    end
    assert_equal expected, h
  end
end

class TestHashWithDefaultTweak < Test::Unit::TestCase
  should 'have with_default method' do
    h = {'a' => 1, 'b' => 2, 'c' => 3 }.with_default :alpha
    assert_equal :alpha, h['not_existent_key']
  end
end

class MooMooClass; end
class MiiMiiClass; end
module MooMooModule; def to_s; ""; end; end
class TestObjectClassConfigTweak < Test::Unit::TestCase
  should "read class_config from yaml." do
    ::RAILS_ROOT = "test/files/root1"
    ::RAILS_ENV = 'test'
    assert_equal 'Test 01 Value', Object.class_config['test01']
    assert_equal 'http://www.google.co.jp/', MooMooClass.class_config['test02']
    assert_equal 'http://www.yahoo.co.jp/', MooMooModule.class_config['test03']

    ::RAILS_ROOT = "test/files/root2"
    ::RAILS_ENV = 'test'
    Object.send :____class_config_saver____, true
    assert_equal 'http://amazon.co.jp/', MooMooClass.class_config['test02']
    assert_equal 'http://openoffice.org/', MooMooModule.class_config['test03']

    assert_equal 30, MiiMiiClass.class_config.test10.min
  end
end

class TestFileDigestTweak < Test::Unit::TestCase
  should "calculate digest" do
    require 'digest/md5'
    digest = Digest::MD5.hexdigest(File.open('README.rdoc').read)
    assert_equal digest, File.md5('README.rdoc')
  end
end
