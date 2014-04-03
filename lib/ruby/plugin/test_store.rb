$:.unshift(File.expand_path(File.join(File.dirname(__FILE__),"..")))
require "test/unit"
require "plugin/store"

class JMA::Plugin::StoreTest < Test::Unit::TestCase
  include JMA::Plugin

  def setup
    @root = File.expand_path(File.join(File.dirname(__FILE__),"store"))
    FileUtils.rm_rf(@root) if File.exist?(@root)
    @linkprefix = File.join(@root,"linkprefix")
    FileUtils.rm_rf(@linkprefix) if File.exist?(@linkprefix)
    @config = {:root => @root, :linkprefix => @linkprefix}
    @store = Store.new(@config)
    @datadir = File.expand_path(File.join(File.dirname(__FILE__),"data"))
  end

  def dircmp(a,b)
    lista = Dir.glob(File.join(a,"*")).sort
    listb = Dir.glob(File.join(b,"*")).sort
    lista.each_with_index{|fa, i|
      case File.ftype(fa)
      when "file"
        return false unless FileUtils.cmp(fa,listb[i])
      when "directory"
        return false unless dircmp(fa,listb[i])
      end
    }
    return true
  end

  def teardown
  end

  def test_initialize
    assert_equal(JMA::Plugin::VERSION, File.read(File.join(@root,"version")))
  end

  def test_install
    assert_nothing_raised{
      @store.install("foo","1.0",File.join(@datadir,"foo-1.0.jpp"))
    }
    assert(dircmp(
      File.join(@root,"foo-1.0"),
      File.join(@datadir,"foo-1.0")
    ))
  end

  def test_uninstall
    assert_nothing_raised{
      @store.install("foo","1.0",File.join(@datadir,"foo-1.0.jpp"))
    }
    assert_equal(true, File.exist?(File.join(@root,"foo-1.0")))
    assert_nothing_raised{
      @store.uninstall("foo","1.0")
    }
    assert_equal(false, File.exist?(File.join(@root,"foo-1.0")))
  end

  def test_uninstall_ng
    assert_raise(RuntimeError) {
      @store.uninstall("bar","1.0")
    }
  end

  def test_link
    assert_nothing_raised{
      @store.install("foo","1.0",File.join(@datadir,"foo-1.0.jpp"))
    }
    assert_nothing_raised{
      @store.link("foo","1.0")
    }
    assert_equal("link", File.ftype(File.join(@linkprefix,"1.txt")))
    assert_equal("link", File.ftype(File.join(@linkprefix,"2.txt")))
    assert_equal("link", File.ftype(File.join(@linkprefix,"3.txt")))
    assert_equal("link", File.ftype(File.join(@linkprefix,"4.txt")))
    assert_equal(
      File.join(@root,"foo-1.0","data1","1.txt"), 
      File.readlink(File.join(@linkprefix,"1.txt")))
    assert_equal(
      File.join(@root,"foo-1.0","data1","2.txt"), 
      File.readlink(File.join(@linkprefix,"2.txt")))
    assert_equal(
      File.join(@root,"foo-1.0","data2","data3","3.txt"), 
      File.readlink(File.join(@linkprefix,"3.txt")))
    assert_equal(
      File.join(@root,"foo-1.0","data2","data3","4.txt"), 
      File.readlink(File.join(@linkprefix,"4.txt")))
    assert_equal(true,File.exist?(File.join(@root,"foo-1.0",".linked")))
  end

  def test_link_already
    assert_nothing_raised{
      @store.install("foo","1.0",File.join(@datadir,"foo-1.0.jpp"))
    }
    assert_nothing_raised{
      @store.link("foo","1.0")
    }
    assert_raise(RuntimeError){
      @store.link("foo","1.0")
    }
  end

  def test_link_ng
    assert_raise(RuntimeError) {
      @store.link("bar","1.0")
    }
  end

  def test_link_ng2
    assert_nothing_raised{
      @store.install("baz","1.0",File.join(@datadir,"baz-1.0.jpp"))
    }
    assert_nothing_raised{
      @store.link("baz","1.0")
    }
  end

  def test_unlink
    assert_nothing_raised{
      @store.install("foo","1.0",File.join(@datadir,"foo-1.0.jpp"))
    }
    assert_nothing_raised{
      @store.link("foo","1.0")
    }
    assert_nothing_raised{
      @store.unlink("foo","1.0")
    }
    assert_equal(false, File.exist?(File.join(@linkprefix,"1.txt")))
    assert_equal(false, File.exist?(File.join(@linkprefix,"2.txt")))
    assert_equal(false, File.exist?(File.join(@linkprefix,"3.txt")))
    assert_equal(false, File.exist?(File.join(@linkprefix,"4.txt")))
    assert(dircmp(
      File.join(@root,"foo-1.0"),
      File.join(@datadir,"foo-1.0")
    ))
    assert_equal(false,File.exist?(File.join(@root,"foo-1.0",".linked")))
  end

  def test_unlink_ng
    assert_raise(RuntimeError) {
      @store.unlink("bar","1.0")
    }
  end

  def test_unlink_ng2
    assert_nothing_raised{
      @store.install("foo","1.0",File.join(@datadir,"foo-1.0.jpp"))
    }
    assert_raise(RuntimeError){
      @store.unlink("foo","1.0")
    }
  end

end
