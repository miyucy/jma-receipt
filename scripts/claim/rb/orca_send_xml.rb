#!/usr/bin/env ruby
# orca xml send module by socket
#   method "xml_send"
#      IN 1: file_path_name
#         2: rmt_host (remort host name or ip)
#         3: rmt_port (port of remport host)
#      OUT : result
#             0: ok
#            -1: connect error
#            -2: data send error

require "socket"

$buf_size = 1000
$retry_cnt = 2
$soc_ack = 0x06
$soc_nak = 0x15

$rtn_ok = 0
$rtn_err1 = -1
$rtn_err2 = -2

#----- Define Classes ----------------------------------------

class FileSend
  def initialize(fl,s)
    @fl_path_name = fl
    @sckt = s
    @eot = 0x04
  end

  def infosend
    @sckt.puts File.basename(@fl_path_name)
    @sckt.puts String(File.size(@fl_path_name))
  end

  def start
    open(@fl_path_name,"rb") do |@f|
      while !@f.eof
        @buf = @f.read($buf_size)
#        print @buf
        @sckt << @buf
#        sleep 0.05
      end
    end
  end

  def end
    @sckt.puts @eot
  end
end

class RcvRsp
  def initialize(s)
    @sckt = s
    @ack = $soc_ack
    @nak = $soc_nak
  end

  def rcv
    @buf = @sckt.gets
    @ans = if @buf.to_i == @ack 
             "OK"
           elsif @buf.to_i == @nak
             "NG"
           else
             "N/A"
           end
  end
end

#----- Define Methods ----------------------------------------

def xml_send(fl_name, rmt_host, rmt_port)
  ret_cd = -1

  begin
    sock = TCPSocket.open(rmt_host, rmt_port)
    puts "Connected"

    flsnd = FileSend.new(fl_name, sock)
    resp = RcvRsp.new(sock)

    flsnd.infosend

    ans = resp.rcv
    print "   < " + ans + " >\n"
    raise "ERR: data error(-2)" if !(ans == "OK")

    print "Strat sending file [" + fl_name + "]\n"

    flsnd.start
    flsnd.end

    ans = resp.rcv
    print "   < " + ans + " >\n"
    raise "ERR: data error(-2)" if !(ans == "OK")

    sock.close
    print "Complete sending file [" + fl_name + "]\n"
    ret_cd = $rtn_ok
    
  rescue
    if sock
      sock.close ; $retry_cnt -= 1 ; puts $!
      retry if $retry_cnt > 0
      ret_cd = $rtn_err2
    else
      puts "ERR: Can't open socket to server(-1)"
      ret_cd = $rtn_err1
    end

  ensure
    "(nothing)"
  end
  ret_cd
end
