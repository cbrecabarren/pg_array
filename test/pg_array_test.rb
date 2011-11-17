require 'test_helper'

describe PgArray do
  it "must support one-dimensional arrays" do
    pg_array = PgArray.new('{one,two,three}')
    pg_array.to_a.must_equal ['one', 'two', 'three']
  end

  it "must support integer arrays" do
    pg_array = PgArray.new('{1,2,10000,555}')
    pg_array.to_a.must_equal ["1", "2", "10000", "555"]
  end

  it "must support quotes and commas" do
    pg_array = PgArray.new('{one,"two, three, four",five,six}')
    pg_array.to_a.must_equal ["one", "two, three, four", "five", "six"]
  end

  it "must support NULL as a special value" do
    pg_array = PgArray.new('{one,two,NULL,three,"NULL",four}')
    pg_array.to_a.must_equal ["one", "two", nil, "three", "NULL", "four"]
  end

  it "must support nested arrays" do
    pg_array = PgArray.new('{1,2,{3,4},5,{6,7},{8,9,{10,11,12}}}')
    pg_array.to_a.must_equal ["1", "2", ["3", "4"], "5", ["6", "7"], ["8", "9", ["10", "11", "12"]]]
  end
end

