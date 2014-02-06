#!/usr/bin/ruby 

require "monthly/rosai_receden_common"

class Receden_error < Receden_common

  class Erorr_info

    attr_accessor    :recenum,:receline,:filename,:ptnum,:name,:birthday,:sryym,:nyugaikbn,:tankinum,:chokinum,:shobyoymd,:ryostymd,:ryoedymd,:errcd,:recid,:line,:rownum,:label,:value,:msg,:header,:footer,:data

    def initialize
      @recenum=""
      @receline=0
      @filename=""
      @ptnum=""
      @name=""
      @birthday=""
      @sryym=""
      @nyugaikbn=""
      @tankinum=""
      @chokinum=""
      @shobyoymd=""
      @ryostymd=""
      @ryoedymd=""
      @errcd=""
      @recid=""
      @line=0
      @rownum=0
      @label=""
      @value=""
      @msg=""
      @header=""
      @footer=""
      @data=""
    end
  end

  def initialize(recefile)
    @info=Recinfo.new
    @errors=Array.new
    @filename=recefile
  end

  def empty?
    @errors.empty?
  end

  def push(errcd,*args)

    rece=args[0]
    csv=args[1]
    name=args[2]
    if csv && name && csv.hash.key?(name)
      key = csv[name].name
    end
    header=args[3]
    footer=args[4]
    info=nil

    err=Erorr_info.new

    if csv.nil?
    else
      err.line=csv.line
      err.receline=csv.receline
      err.data=csv.rows.join(",")
      if csv.hash.key?("RECID")
        err.recid=csv["RECID"].value
        id=csv["RECID"].value
        if @info.rec.key?(id)
          if @info[id].hash.key?(key)
            err.label =@info[id].hash[key].label
            err.value =csv[key].value
            err.rownum=@info[id].hash[key].rownum + 1
          end
        end
      end
    end

    if rece.nil?
    else
      rece.re.each{|re|

        err.ptnum   =re["PTNUM"].hankaku
        err.recenum =re["RECENUM"].hankaku
        err.name    =re["NAME"].zenkaku
        err.birthday=re["BIRTHDAY"].wYmdtos
        err.sryym   =wtos(rece.sryym)

        if rece.sbt.exists?
          err.nyugaikbn=rece.sbt.nyugai
        end

        rece.rr.each{|rr|
          err.tankinum =rr["TANKINUM"].hankaku
          err.chokinum=rr["CHOKINUM"].hankaku
          err.shobyoymd=rr["SHOBYOYMD"].wYmdtos
          err.ryostymd=rr["RYOSTYMD"].wYmdtos
          err.ryoedymd=rr["RYOEDYMD"].wYmdtos
          break
        }

        break
      }
    end

    if header.nil?
    else
       err.header = header
    end

    if footer.nil?
    else
       err.footer = footer
    end

    err.filename = @filename

    err.errcd=errcd
    case errcd
    when "10001"
      err.msg="ϫ�ҿ���������쥳���ɤ���Ͽ����Ƥ��ޤ���"
    when "10002"
      err.msg="ϫ�ҿ���������쥳���ɤ�ʣ����Ͽ����Ƥޤ���"
    when "10010"
      err.msg="ϫ�ҿ�����ñ������Ͽ����Ƥ��ޤ���"
    when "10020"
      err.msg="����Ǥ��ʤ�ϫ�ҿ�����ñ������Ͽ����Ƥ��ޤ���"
    when "10050"
      err.msg="�±������Ž�ζ�ʬ����Ͽ����Ƥ��ޤ���"
    when "10060"
      err.msg="����Ǥ��ʤ��±������Ž�ζ�ʬ����Ͽ����Ƥ��ޤ���"
    when "10090"
      err.msg="��������ǯ��������������ǯ�����ǵ�Ͽ����Ƥ��ޤ���"
    when "10100"
      err.msg="���ܴ��֡�����������������ǯ��������Ͽ����Ƥ��ޤ���"
    when "10130"
      err.msg="͹���ֹ椬��������Ͽ����Ƥ��ޤ���"
    when "10140"
      err.msg="���ŵ��ؽ���Ϥ���Ͽ����Ƥ��ޤ���"
    when "10150"
      err.msg="���ŵ�����Ǥ�Ի�̾����Ͽ����Ƥ��ޤ���"
    when "10170"
      err.msg="��ƻ�ܸ�ϫƯ�ɥ����ɤ���Ͽ����Ƥ��ޤ���"
    when "10180"
      err.msg="��ƻ�ܸ�ϫƯ�ɥ����ɤ˸�ä������ɤ���Ͽ����Ƥ��ޤ���"
    when "10190"
      err.msg="ϫƯ�����Ľ𥳡��ɤ˸�ä������ɤ���Ͽ����Ƥ��ޤ���"
    when "10200"
      err.msg="�����±������ֹ椬��Ͽ����Ƥ��ޤ���"
    when "10210"
      err.msg="�����±������ֹ�˿����ʳ�����Ͽ����Ƥ��ޤ���"
    when "10310"
      err.msg="�ƥ쥻�ץȤ�ϫ�ҥ쥻�ץȥ쥳���ɤι�׳ۤ�ϫ�ҿ����������������ۤ����פ��Ƥ��ޤ���"
    when "10320"
      err.msg="�ƥ쥻�ץȤη����ϫ�ҿ�����������������ź����������פ��Ƥ��ޤ���"
    when "10410"
      err.msg="ʿ������ǯ������������ܴ��֡ݽ�������Ͽ����Ƥ��ޤ���"
    when "19100"
      err.msg="�쥻�ץ��ֹ椬�������ο����ǤϤ���ޤ���"
    when "19230"
      err.msg="���ŵ��ؾ���쥳���ɤμ��쥳���ɤ����쥻�ץȶ��̥쥳���ɰʳ��Ǥ���"
    when "19281"
      err.msg="���ŵ��ؾ���쥳���ɤ���Ͽ����Ƥ��ޤ���"
    when "19282"
      err.msg="���ŵ��ؾ���쥳���ɤ�ʣ����Ͽ����Ƥ��ޤ���"
    when "19283"
      err.msg="�쥻�ץȶ��̥쥳���ɤ���Ͽ����Ƥ��ޤ���"
    when "19284"
      err.msg="����ǯ���������ǯ��ǤϤ���ޤ���"
    when "19170"
      err.msg="���ŵ���ñ�̤Υ쥻�ץ��ֹ椬�֣��פ���ξ���ǤϤ���ޤ���"
    when "20020"
      err.msg="ž����ͳ����Ͽ����Ƥ��ޤ���"
    when "20030"
      err.msg="����ǯ��������Ͽ����Ƥ��ޤ���"
    when "20040"
      err.msg="���Ѻ��̤���Ͽ����Ƥ��ޤ���"
    when "20050"
      err.msg="Ĺ���Υ쥻�ץȤǿ��Ѻ��̤ˡ֣��ס�ž��Ͽǡˤ���Ͽ����ޤ�����"
    when "20060"
      err.msg="Ĺ���Υ쥻�ץȤǽ���ǯ��������Ͽ����Ƥ��ޤ���"
    when "20070"
      err.msg="û���Υ쥻�ץȤǽ���ǯ��������Ͽ����Ƥ��ޤ���"
    when "20100"
      err.msg="ϫƯ�Ԥλ�̾�ʥ��ʡˤ���Ͽ����Ƥ��ޤ���"
    when "20120"
      err.msg="���ܴ��֡ݽ�������Ͽ����Ƥ��ޤ���"
    when "20130"
      err.msg="���ܴ��֡���������Ͽ����Ƥ��ޤ���"
    when "20140"
      err.msg="���¤ηв᤬��Ͽ����Ƥ��ޤ���"
    when "20150"
      err.msg="������������Ͽ����Ƥ��ޤ���"
    when "20170"
      err.msg="��̳�ҳ����̶кҳ��ζ�ʬ����Ͽ����Ƥ��ޤ���"
    when "20180"
      err.msg="��̳�ҳ����̶кҳ��ζ�ʬ�ε�Ͽ����äƤ��ޤ���"
    when "20190"
      err.msg="Ģɼ���̤���Ͽ����Ƥ��ޤ���"
    when "20200"
      err.msg="Ģɼ���̤ε�Ͽ����äƤ��ޤ���"
    when "20210"
      err.msg="���ι��ܤϵ�Ͽ��ɬ�ܤι��ܤǤ���"
    when "20220"
      err.msg="���ѤǤ��ʤ����Ų�̾����Ͽ����Ƥ��ޤ���"
    when "21590"
      err.msg="�������ܴ��֥쥻�ץȤϡ�����ʹߤ������ǽ�Ȥʤ�ޤ���"
    when "21600"
      err.msg="���ܴ��֡ݽ�������������ǯ�����ǤϤ���ޤ���"
    when "21610"
      err.msg="���ܴ��֡���������������ǯ�����ǤϤ���ޤ���"
    when "21611"
      err.msg="����ǯ���������ǯ��ǤϤ���ޤ���"
    when "21630"
      err.msg="���ܴ��֡ݽ��������ܴ��֡�������Ʊ��ǯ��ǤϤ���ޤ���"
    when "21660"
      err.msg="�����ʬ�η���������ܿ��ǤϤ���ޤ���"
    when "21680"
      err.msg="����̾�쥳���ɤν����쥳���ɤη���������ܿ��ǤϤ���ޤ���"
    when "22020"
      err.msg="���쥻�ץȤ��Ф��������쥳���ɰʾ�ν���̾�쥳���ɤ���Ͽ����Ƥ��ޤ��������쥳���ɤ�Ķ�������̾�쥳���ɤϵ�Ͽ�Ǥ��ޤ���"
    when "23040"
      err.msg="Ŭ�ѥ쥳���ɤ˵�Ͽ�Ǥ��ʤ������ɤ���Ͽ����Ƥ��ޤ���"
    when "23060"
      err.msg="���ż��̤�����˵�Ͽ����Ƥ��ޤ���"
    when "23070"
      err.msg="Ŭ�ѥ쥳���ɤ˵�Ͽ�Ǥ��ʤ������ȥ����ɤ���Ͽ����Ƥ��ޤ���"
    when "23110"
      err.msg="Ŭ�ѥ쥳���ɤβ������Ͽ����Ƥ��ʤ������ϣ�����Ͽ����Ƥ��ޤ���"
    when "23120"
      err.msg="�������������ñ�̡ʺޡ���β�������פ��Ƥ��ޤ���"
    when "23130"
      err.msg="Ŭ�ѥ쥳���ɤλ���������ʲ���ˤˣ�����Ͽ����Ƥ��ޤ���"
    when "23170"
      err.msg="����������ʲ���ˤ������������˵�Ͽ����Ƥ��ޤ���"
    when "23190"
      err.msg="Ŧ�ץ쥳���ɤ˻���������ʲ���ˤ���Ͽ����Ƥ��ޤ���"
    when "23800"
      err.msg="�����ȥǡ����ν����쥳���ɤη���������ܿ��ǤϤ���ޤ���"
    when "23810"
      err.msg="�����ȥ쥳���ɰʳ��ǿ��ż��̡֣����ס֣����פ˵�Ͽ����Ƥ��ޤ���"
    when "23820"
      err.msg="���쥻�ץ���ˣ��������쥳���ɰʾ�ξɾ��ܵ��쥳���ɤ���Ͽ����Ƥ��ޤ����������쥳���ɤ�Ķ����ɾ��ܵ��쥳���ɤϵ�Ͽ�Ǥ��ޤ���"
    when "23830"
      err.msg="�쥻�ץ������Ƭ�ξɾ��ܵ��쥳���ɤ˾ɾ��ܵ���ʬ����Ͽ����Ƥ��ޤ���"
    when "23840"
      err.msg="���ѤǤ��ʤ��ɾ��ܵ���ʬ����Ͽ����Ƥ��ޤ���"
    when "23860"
      err.msg="Ŭ�Ѿ���쥳���ɤΥ����ȥǡ����ν����쥳���ɤη���������ܿ��ǤϤ���ޤ���"
    when "23870"
      err.msg="Ŭ�Ѿ���쥳���ɤΥ����ȥǡ����ν����쥳���ɿ������ʾ嵭Ͽ����Ƥ��ޤ����������ɤ�Ķ���뽤���쥳���ɤϵ�Ͽ�Ǥ��ޤ���"
    when "23880"
      err.msg="Ŭ�Ѿ���쥳���ɤΥ����ȥ����ɤ���Ͽ����Ƥ��ޤ���"
    when "23950"
      err.msg="���ѤǤ��ʤ������ʥ����ɤ���Ͽ����Ƥ��ޤ���"
    when "25390"
      err.msg="���ι��ܤˡ���Ͽ��ǽ�ʷ����Ķ����ǡ�������Ͽ����Ƥ��ޤ���"
    when "25400"
      err.msg="�쥻�ץȾ����ϫ�ҥ쥻�ץȥ쥳���ɡˤ���Ͽ����Ƥ��ޤ���"
    when "25420"
      err.msg="�쥳���ɤι��ܿ����쥳���ɼ��̾���Ȱ��פ��ޤ���"
    when "25430"
      err.msg="���ι��ܤε�Ͽ�⡼�ɤ���äƤ��ޤ���"
    when "25441"
      err.msg="���ι��ܤ˳�������Ͽ����Ƥ��ޤ���"
    when "25470"
      err.msg="ϫ�ҥ쥻�ץȥ쥳���ɤ�ʣ����Ͽ����Ƥ��ޤ���"
    when "25530"
      err.msg="�������ܤη������­���Ƥ��ޤ���"
    when "25540"
      err.msg="����̾�쥳���ɤ���Ͽ����Ƥ��ޤ���"
    when "25550"
      err.msg="Ŭ�ѥ쥳���ɤ���Ͽ����Ƥ��ޤ���"
    when "26510"
      err.msg="������쥻�ץȤ��Ż����������ֹ椬��Ͽ����Ƥ��ޤ���"
    when "30010"
      err.msg="ϫƯ�Ԥλ�̾����Ͽ����Ƥ��ޤ���"
    when "30210"
      err.msg="����ǯ��������������ǯ�����ǵ�Ͽ����Ƥ��ޤ���"
    when "30220"
      err.msg="���ܴ��֡������������ǯ��������Ͽ����Ƥ��ޤ���"
    when "30230"
      err.msg="��ǯ��������������ǯ��������Ͽ����Ƥ��ޤ���"
    when "31190"
      err.msg="�����ʬ�˸�ä������ɤ���Ͽ����Ƥ��ޤ���"
    when "31330"
      err.msg="�˽���ʬ�˸�ä������ɤ���Ͽ����Ƥ��ޤ���"
    when "31450"
      err.msg="��ǯ��������������ǯ�����ǵ�Ͽ����Ƥ��ޤ���"
    when "32010"
      err.msg="���ż��������������ܴ��֤�������Ķ���Ƥ��ޤ���"
    when "32040"
      err.msg="¸�ߤ��ʤ�����̾�����ɤ���Ͽ����Ƥ��ޤ���"
    when "32050"
      err.msg="¸�ߤ��ʤ������쥳���ɤ���Ͽ����Ƥ��ޤ���"
    when "32060"
      err.msg="���ܴ��֡ݽ�����ο��ų���������Ͽ����Ƥ��ޤ���"
    when "32070"
      err.msg="���ų���������������ǯ�����ǵ�Ͽ����Ƥ��ޤ���"
    when "32090"
      err.msg="̤�����ɲ�����̾�ν���̾�Τ���Ͽ����Ƥ��ޤ���"
    when "32200"
      err.msg="����¥����ɤ˸�ä������ɤ���Ͽ����Ƥ��ޤ���"
    when "32210"
      err.msg="��ǯ���������ο��ų���������Ͽ����Ƥ��ޤ���"
    when "33031"
      err.msg="¸�ߤ��ʤ������ϸ���ͭ���Ǥʤ�Ŭ�ѥ����ɡʿ��ť����ɡ������ʥ����ɡ������ॳ�������ϥ����ȥ����ɡˤ���Ͽ����Ƥ��ޤ���"
    when "33040"
      err.msg="�����߷׻����Ź԰٤ο��̥ǡ������Ф������Ͼ�ά�ʥ��ڡ����ˤ���Ͽ����ޤ�����"
    when "33060"
      err.msg="���������ʤθ�����������Ͽ����Ƥ��ޤ���"
    when "33070"
      err.msg="�����ε�Ͽ��ɬ�פʲս�Ǥ�������������������Ͽ����Ƥ��ޤ���"
    when "33071"
      err.msg="�����ε�Ͽ��ɬ�פʲս�Ǥ�������������Ͽ����Ƥ��ޤ���"
    when "33090"
      err.msg="�����ʤλ����̤��Ф������Ͼ�ά�ʥ��ڡ����ˤ���Ͽ����ޤ�����"
    when "33110"
      err.msg="������λ����̤��Ф������Ͼ�ά�ʥ��ڡ����ˤ���Ͽ����ޤ�����"
    when "33130"
      err.msg="�������ñ������Ͽ����Ƥ��ޤ���"
    when "33160"
      err.msg="̤�����ɲ�������Ǥ���������̾�Ρ�����̾�ڤӵ������ϥ������Τɤ��餫��Ͽ���Ƥ���������"
    when "33170"
      err.msg="��Ͽ���줿���̥ǡ����������Ͱʲ��Τ��������׻����Ǥ��ޤ���"
    when "33190"
      err.msg="���������ʤΥ����ɤΤߤǵ�Ͽ���Ƥ���������"
    when "33930"
      err.msg="¸�ߤ��ʤ������쥳���ɤ������Ȥ˵�Ͽ����Ƥ��ޤ���"
    when "34380"
      err.msg="ʸ���ǡ����ε�Ͽ��ɬ�פʥ����ȥ����ɤǤ�����ʸ���ǡ�������Ͽ����Ƥ��ޤ���"
    when "34390"
      err.msg="ʸ���ǡ����������Τ�ͭ���Υ����ȥ����ɤǤ�����ʸ���ǡ����˿����ʳ����ޤޤ�Ƥ��ޤ���"
    when "34400"
      err.msg="��Ͽ���줿ʸ���ǡ����η���������������Ȥ˵�Ͽ���٤�ʸ���ǡ����η���Ȱ��פ��ʤ����ᡢ�����Ȥ������������Ǥ��ޤ���"
    when "34410"
      err.msg="Ŭ�ѥ쥳���ɥ����ȤΥ����ȥ����ɤ�ʸ���ǡ����ε�Ͽ��ɬ�פǤ�����ʸ���ǡ�������Ͽ����Ƥ��ޤ���"
    when "34440"
      err.msg="Ŭ�ѥ쥳���ɥ����ȤΥ����ȥ����ɤ�ʸ���ǡ����������Τ�ͭ���Ǥ�����ʸ���ǡ����˿����ʳ����ޤޤ�Ƥ��ޤ���"
    when "34470"
      err.msg="Ŭ�ѥ쥳���ɥ����Ȥ˵�Ͽ���줿ʸ���ǡ����η���������������Ȥ˵�Ͽ���٤�ʸ���ǡ����η���Ȱ��פ��ʤ����ᡢ�����Ȥ������������Ǥ��ޤ���"
    when "34500"
      err.msg="Ŭ�ѥ쥳���ɥ����Ȥ�¸�ߤ��ʤ������ȥ����ɤ���Ͽ����Ƥ��ޤ���"
    when "34590"
      err.msg="¸�ߤ��ʤ������쥳���ɤ�Ŭ�ѥ쥳���ɥ����Ȥ˵�Ͽ����Ƥ��ޤ���"
    when "34650"
      err.msg="�������ñ�̥����ɤ˸�ä������ɤ���Ͽ����Ƥ��ޤ���"
    when "34900"
      err.msg="������������ʳ��˿����������������Ϣ�Υ����ɤ���Ͽ����Ƥ��ޤ���"
    when "34910"
      err.msg="������������˿���������ʳ��ο��Ź԰٤���Ͽ����ޤ�����"
    when "36390"
      err.msg="�¾����ε�Ͽ��ɬ�פǤ���"
    when "35310"
      err.msg="�������ܲ�������������ߣ���ʬ��Ķ���Ƥ��ޤ���"
    when "35340"
      err.msg="�������ܲ�������ż������ߣ���ʬ��Ķ���Ƥ��ޤ���"
    when "37650"
      err.msg="��ʣ�������ե�����¸�ߤ��ޤ���"
    when "38040"
      err.msg="����ǯ��������������ǯ�����ǵ�Ͽ����Ƥ��ޤ���"
    when "38050"
      err.msg="���ܴ��֡�������ν���ǯ��������Ͽ����Ƥ��ޤ���"
    when "38060"
      err.msg="��ǯ�������ν���ǯ��������Ͽ����Ƥ��ޤ���"
    when "38100"
      err.msg="��ǯ�����������ܴ��֡ݽ�������Ͽ����Ƥ��ޤ���"
    when "38110"
      err.msg="����ǯ�����������ܴ��֡ݽ�������Ͽ����Ƥ��ޤ���"
    when "38120"
      err.msg="���ܴ��֡�����������ܴ��֡ݽ�������Ͽ����Ƥ��ޤ���"
    when "38160"
      err.msg="��ǯ�����������ܴ��֡���������Ͽ����Ƥ��ޤ���"
    when "38200"
      err.msg="��Ͽ�Ǥ��ʤ�ž����ͳ����Ͽ����Ƥ��ޤ���"
    when "38210"
      err.msg="��Ͽ�Ǥ��ʤ����Ѻ��̤���Ͽ����Ƥ��ޤ���"
    when "38230"
      err.msg="Ĺ���Υ쥻�ץȤ�ϫƯ�ݸ��ֹ椬��Ͽ����Ƥ��ޤ���"
    when "38240"
      err.msg="û���Υ쥻�ץȤ�ϫƯ�ݸ��ֹ椬��Ͽ����Ƥ��ޤ���"
    when "38250"
      err.msg="Ĺ���Υ쥻�ץȤ�ǯ��ڽ��ֹ椬��Ͽ����Ƥ��ޤ���"
    when "38260"
      err.msg="û���Υ쥻�ץȤ�ǯ��ڽ��ֹ椬��Ͽ����Ƥ��ޤ���"
    when "38270"
      err.msg="�������쥻�ץȤǿ������ܹ�ײ������Ͽ����Ƥ��ޤ���"
    when "38280"
      err.msg="�����쥻�ץȤǿ������ܹ�ײ������Ͽ����Ƥ��ޤ���"
    when "38290"
      err.msg="�������쥻�ץȤǿ������ܹ�׶�ۡʥϡˤ���Ͽ����Ƥ��ޤ���"
    when "38300"
      err.msg="�����쥻�ץȤǿ������ܹ�׶�ۡʥϡˤ���Ͽ����Ƥ��ޤ���"
    when "38350"
      err.msg="�����ο��Ź԰٤��Ф��ơ�������������������ϵ�Ͽ����Ƥ��ޤ���"
    when "38351"
      err.msg="�����ο��Ź԰٤��Ф��ơ����������������Ͽ����Ƥ��ޤ���"
    when "38380"
      err.msg="�����ο��Ź԰٤ˤ϶�ۤε�Ͽ��ɬ�פǤ�������ۤ��Ф������Ͼ�ά�ʥ��ڡ����ˤ���Ͽ����ޤ�����"
    when "38381"
      err.msg="�����ο��Ź԰٤ˤ϶�ۤε�Ͽ��ɬ�פǤ�������ۤ��Ф���ά�ʥ��ڡ����ˤ���Ͽ����ޤ�����"
    when "38380"
      err.msg="�����ο��Ź԰٤ˤ϶�ۤε�Ͽ��ɬ�פǤ�������ۤ��Ф������Ͼ�ά�ʥ��ڡ����ˤ���Ͽ����ޤ�����"
    when "38381"
      err.msg="�����ο��Ź԰٤ˤ϶�ۤε�Ͽ��ɬ�פǤ�������ۤ��Ф���ά�ʥ��ڡ����ˤ���Ͽ����ޤ�����"
    when "38390"
      err.msg="�����ο��Ź԰٤ˤ϶�ۤε�Ͽ�����פǤ�������ۤ���Ͽ����Ƥ��ޤ���"
    when "40070"
      err.msg="���������Ͽ����Ƥ��ޤ��������Ѻ��̤��֣��סʽ�ǡˤȤʤäƤ��ޤ���"
    when "40090"
      err.msg="�������Ԥ��Ф��ơ������ʤ���������Ͽ����Ƥ��뤬��Ĵ�����λ������ȿ��ż����������פ��Ƥ��ޤ���"
    when "40100"
      err.msg="���Ȥ�̾�Τ���Ͽ����Ƥ��ޤ���"
    when "40110"
      err.msg="���Ⱦ�ν���Ϥ���Ͽ����Ƥ��ޤ���"
    when "41190"
      err.msg="Ʊ�������ʬ�����İʾ嵭Ͽ����Ƥ��ޤ���"
    when "43230"
      err.msg="ñ�̥����ɤε�Ͽ��ɬ�פ�������Ǥ�����ñ�̥����ɤ���Ͽ����Ƥ��ޤ���"
    when "44240"
      err.msg="���Ž����Ѥο��Ź԰٤���Ͽ����Ƥ��ޤ���"
    when "44350"
      err.msg="��§�û�����Ͽ����ޤ����������ܼ굻����Ͽ����Ƥ��ޤ���"
    when "44360"
      err.msg="��§�û�����û��ε�Ͽ�礬��äƤ��ޤ���"
    when "44510"
      err.msg="��������ꤹ������������Ƥ��ޤ��󡣿��ų������ε�Ͽ���ǧ���Ƥ���������"
    when "44550"
      err.msg="���ܴ��֡ݽ������λ���������Ͽ����Ƥ��ޤ���"
    when "46030"
      err.msg="�±����Ѥο��Ź԰٤���Ͽ����Ƥ��ޤ���"
    when "46120"
      err.msg="Ʊ�������ԲĤ���û�����Ͽ����Ƥ��ޤ���"
    when "46340"
      err.msg="������λ������������ǽ�����Ķ���Ƥ��ޤ���"
    when "46410"
      err.msg="��û��ε�Ͽ�������äƤ��ޤ���"
    when "46411"
      err.msg="���ܹ��ܤ��Ф��ơ�����Ǥ��ʤ���û��Ǥ���"
    when "48410"
      err.msg="����������Ŧ�ץǡ����������ι�פȰ��פ��Ƥ��ޤ���"
    when "48420"
      err.msg="����������۴����ʥ��ˤ�����������ޤ���"
    when "48430"
      err.msg="���׶�ۡʥ�ˤ�Ŧ�ץǡ����ζ�ۤι�פȰ��פ��Ƥ��ޤ���"
    when "48440"
      err.msg="��׳ۡʥ��ˡܡʥ�ˡܡʥϡˤ��־���������۴����ʥ��ˡܾ��׶�ۡʥ�ˡܿ������ܹ�׶�ۡʥϡˡפȰ��פ��Ƥ��ޤ���"
    when "48450"
      err.msg="��׳ۡʥ��ˡܡʥ�ˡܡʥϡˤ��־���������۴����ʥ��ˡܾ��׶�ۡʥ�ˡפȰ��פ��Ƥ��ޤ���"
    when "48470"
      err.msg="�������ܹ�ײ����Ŧ�ץǡ����ι�ײ���Ȱ��פ��Ƥ��ޤ���"
    when "48480"
      err.msg="�������ܹ�׶�ۡʥϡˤ�Ŧ�ץǡ����ι�׶�ۤȰ��פ��Ƥ��ޤ���"

    end

    @errors << err

  end

  def write(outfile)
    open(outfile,"w"){|f|
      @errors.each_with_index{|err,i|
        errdata =  sprintf("<ERR_FILENAME>%s</ERR_FILENAME>",err.filename)
        errdata << sprintf("<ERR_RECENUM>%s</ERR_RECENUM>",err.recenum)
        errdata << sprintf("<ERR_PTNUM>%s</ERR_PTNUM>",err.ptnum)
        errdata << sprintf("<ERR_NAME>%s</ERR_NAME>",err.name)
        errdata << sprintf("<ERR_BIRTHDAY>%s</ERR_BIRTHDAY>",err.birthday)
        errdata << sprintf("<ERR_SRYYM>%s</ERR_SRYYM>",err.sryym)
        errdata << sprintf("<ERR_NYUGAIKBN>%s</ERR_NYUGAIKBN>",err.nyugaikbn)
        errdata << sprintf("<ERR_TANKINUM>%s</ERR_TANKINUM>",err.tankinum)
        errdata << sprintf("<ERR_CHOKINUM>%s</ERR_CHOKINUM>",err.chokinum)
        errdata << sprintf("<ERR_SHOBYOYMD>%s</ERR_SHOBYOYMD>",err.shobyoymd)
        errdata << sprintf("<ERR_RYOSTYMD>%s</ERR_RYOSTYMD>",err.ryostymd)
        errdata << sprintf("<ERR_RYOEDYMD>%s</ERR_RYOEDYMD>",err.ryoedymd)
        errdata << sprintf("<ERR_ERRCD>%s</ERR_ERRCD>",err.errcd)
        errdata << sprintf("<ERR_RECID>%s</ERR_RECID>",err.recid)
        errdata << sprintf("<ERR_RECELINE>%d</ERR_RECELINE>",err.receline)
        errdata << sprintf("<ERR_ROWNUM>%d</ERR_ROWNUM>",err.rownum)
        errdata << sprintf("<ERR_LABEL>%s</ERR_LABEL>",err.label)
        errdata << sprintf("<ERR_VALUE>%s</ERR_VALUE>",err.value)
        errdata << sprintf("<ERR_MSG>%s</ERR_MSG>",err.msg)
        errdata << sprintf("<ERR_HEADER>%s</ERR_HEADER>",err.header)
        errdata << sprintf("<ERR_FOOTER>%s</ERR_FOOTER>",err.footer)
        errdata << sprintf("<ERR_LINE>%d</ERR_LINE>",err.line)
        errdata << sprintf("<ERR_DATA>%s</ERR_DATA>",err.data)
        errdata << sprintf("\n",err.data)
        f.print errdata
      }
    }
  end

  def size
    @errors.size
  end

end
