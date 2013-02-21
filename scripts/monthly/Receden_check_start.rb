#!/usr/bin/ruby

require "monthly/receden_check"

$KCODE = "UTF-8"

class Receden_check_start
	def start_batch(_param)
		receden_check = Receden_check.new
		receden_check.main(_param)
	end
end
