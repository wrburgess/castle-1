require 'moses'

class PGap
  include Moses
  commands :foo

  def foo
    output.puts 'this is a command'
  end
end