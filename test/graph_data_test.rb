require 'test/unit'
require File.expand_path('../../lib/graph_data', __FILE__)

class GraphDataTest < Test::Unit::TestCase

  test 'node starting at 0' do
    sut = GraphData.new([ObjectData.new('Foo', 1)])
    assert_equal [{name: 'Foo', group: 0}], sut.nodes.map(&:to_h)
  end

  test 'node with children' do
    objects = ObjectData.new('Foo', 1, [ObjectData.new('Bar', 2), ObjectData.new('Baz', 3)])
    sut = GraphData.new([objects])
    assert_equal [{name: 'Foo', group: 0}, {name: 'Bar', group: 1}, {name: 'Baz', group: 2}], sut.nodes.map(&:to_h)
  end

  test 'node with children and duplicate parent' do
    object_with_child = ObjectData.new('Foo', 1, [ObjectData.new('Bar', 2)])
    object = ObjectData.new('Bar', 2)
    sut = GraphData.new([object_with_child, object])
    assert_equal [{name: 'Foo', group: 0}, {name: 'Bar', group: 1}], sut.nodes.map(&:to_h)
  end

  test 'link to node with reference' do
    object = ObjectData.new('Foo', 1, [ObjectData.new('Bar', 2)])
    sut = GraphData.new([object])
    assert_equal [{source: 0, target: 1, value: 1}], sut.links.map(&:to_h)
  end

  test 'links to node with multiple references' do
    object = ObjectData.new('Foo', 1, [ObjectData.new('Bar', 2), ObjectData.new('Baz', 3)])
    sut = GraphData.new([object])
    assert_equal [{source: 0, target: 1, value: 1}, {source: 0, target: 2, value: 1}], sut.links.map(&:to_h)
  end

  test 'accumulates link values for n references' do
    object = ObjectData.new('Foo', 1, [ObjectData.new('Bar', 2)])
    object2 = ObjectData.new('Bar', 2, [ObjectData.new('Foo', 1), ObjectData.new('Baz', 3)])
    object3 = ObjectData.new('Bar', 3, [ObjectData.new('Foo', 1), ObjectData.new('Foobly', 2)])
    sut = GraphData.new([object, object2, object3])
    assert_equal [{source: 0, target: 1, value: 1}, {source: 1, target: 0, value: 2}, {source: 1, target: 2, value: 1},
                  {source: 1, target: 3, value: 1}], sut.links.map(&:to_h)
  end

end