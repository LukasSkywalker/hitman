require_relative '../../lagerverwaltung-server/api'
require 'minitest/autorun'
require 'hitman'

class HitmanTest < Minitest::Test
  def test_lvs
    t = Hitman::Target.new('lagerverwaltung-server', 'http://localhost:9292')
    t.postfix = { email: 'test@hitman.org', password: '12345678' }

    scanner = Hitman::Scanner.new
    target = scanner.scan_grape(t, API)

    fuzzer = Hitman::Fuzzer.new
    fuzzer.start(target)
  end
end
