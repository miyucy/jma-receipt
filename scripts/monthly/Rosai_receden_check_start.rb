#!/usr/bin/ruby
# coding : utf-8
Encoding.default_external = "euc-jp"

require "monthly/rosai_receden_check"

$KCODE = "UTF-8"

class Rosai_receden_check_start
  def start_batch(_param)
    receden_check = Receden_check.new
    receden_check.main(_param)
  end
end
