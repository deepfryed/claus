require 'helper'

describe 'claus' do
  it 'should match simple AND conditions' do
    assert_equal true,  Claus.new(foo: 1).match?(foo: 1)
    assert_equal false, Claus.new(foo: 1).match?(foo: 2)
    assert_equal false, Claus.new(foo: 1).match?(bar: 2)
    assert_equal false, Claus.new(foo: 1).match?(2)
  end

  it 'should match multiple AND conditions' do
    assert_equal true,  Claus.new(foo: 1, bar: 2).match?(foo: 1, bar: 2)
    assert_equal false, Claus.new(foo: 1, bar: 2).match?(foo: 1, bar: 3)
    assert_equal false, Claus.new(foo: 1, bar: 2).match?(foo: 1)
  end

  it 'should match simple OR conditions' do
    assert_equal true,  Claus.new([1, 2]).match?(1)
    assert_equal true,  Claus.new(foo: [1, 2]).match?(foo: 1)
    assert_equal true,  Claus.new(foo: [1, 2]).match?(foo: 2)
    assert_equal true,  Claus.new(foo: 1..2).match?(foo: 1)
    assert_equal true,  Claus.new(foo: 1..2).match?(foo: 2)
    assert_equal false, Claus.new(foo: [1, 2]).match?(foo: 3)
  end

  it 'should match composite AND OR clauses' do
    assert_equal true,  Claus.new(foo: 1, bar: 1..2).match?(foo: 1, bar: 2)
    assert_equal false, Claus.new(foo: 1, bar: 1..2).match?(foo: 1, bar: 3)
    assert_equal false, Claus.new(foo: 1, bar: 1..2).match?(foo: 1)
    assert_equal true,  Claus.new([{foo: 1}, {bar: 1..2}]).match?(foo: 1)
    assert_equal true,  Claus.new([{foo: 1}, {bar: 1..2}]).match?(bar: 1)
    assert_equal false, Claus.new([{foo: 1}, {bar: 1..2}]).match?(foo: 2)
  end

  it 'should match some wickedly nested ones too' do
    claus = Claus.new(foo: 1, bar: [{baz: 2}, {bar: 1..2}])

    assert_equal true,  claus.match?(foo: 1, bar: {baz: 2})
    assert_equal true,  claus.match?(foo: 1, bar: {bar: 1})
    assert_equal false, claus.match?(foo: 1, bar: {baz: 3})
    assert_equal false, claus.match?(foo: 1)
  end
end
