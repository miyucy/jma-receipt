#!/usr/bin/ruby # print_parent2.rb �Υץ�ӥ塼���б� 
# ʸ����β��Զ��ڤ������ˤ��ơ����������Υץ������Ϥ����� 
# (2002/03/07 ���Ļ��ɲð���) 
# ��������Τ�Τ򡢰���data�ե�����˴ޤ��褦���ѹ�(2002/04/16 :���Ļ���� :�����б�) 
# 
# red2ps�б��Ѥ� 
# site-lib��ʬ�б� (2002/10/16) 
#   woody�ǤǤϡ�site-lib��dia/red�ե�����⸫�ʤ���Фʤ�ʤ��Τǡ�����˴ؤ����б� 
#   ���ǥ��쥯�ȥ���ɲä��뤳�Ȥ��б� 
#   data�ե�����ե����ޥåȤ���(LP̾�Τ��Ȥˡ�site��ʬ���ɲ�) 
# �ǥ��쥯�ȥ�����б� (2002/11/13)
#   ���ޥ�ɥ饤�����3��6�Υǥ��쥯�ȥ���־������Ѥ���褦�˽���
# �ץ�ӥ塼�б�
# (2003/01/20 ) ���Ϥ��ե�����Υ쥤�������ѹ�
# postscript�����б� (2003/03/03)
# (2004/12/05 ) ����������ߵ�ǽ�ɲ�
# (2007/05/09 ) ����饤��ư��������ɲ�(UUID)
# (2007/05/31 ) ���롼�׿����б�(hospnum�ɲ�)
# (2007/06/19 ) ϫ���Ȥʤ��б�
# (2007/12/27 ) patch-lib �б�
# (2008/07/30 ) ϫ�ҡ������Ȥʤ��б�
# (2008/11/12 ) �쥤�����ȥ��ץ�����б�
# (2011/11/14 ) ϫ����ͭ���б�
# (2012/04/11 ) �����б�
#

# ��ʣ���Υץ����μ¹ԤϤǤ��ʤ�


# ����������ˡ
# ����1  = ����ե�����̾
# ����2  = ��ư�ץ����
# ����3  = ����ɸ��쥻�ץ�form�ǥ��쥯�ȥ�
# ����4  = ����ɸ��쥻�ץ�record�ǥ��쥯�ȥ�
# ����5  = ����ɸ��쥻�ץ�site��ͭform�ǥ��쥯�ȥ�
# ����6  = ����ɸ��쥻�ץ�site��ͭrecord�ǥ��쥯�ȥ�
# ����7  = data�ե�����
# ����8  = ��ư�ѥ�����ץ�̾1
# ����9  = ��ư�ѥ�����ץ�̾2
# ����10 = ����ɸ��쥻�ץ�patch��ͭform�ǥ��쥯�ȥ�

# data�ե�����ե����ޥå�
# +------------------+------------+---------------+---------------+---------------+---------------+-----------------------+
# |�ե�����̾(30Byte)|LP̾(20Byte)|offset-x(5byte)|offset-y(5byte)|site��ʬ(1Byte)|���϶�ʬ(1Byte)|������ե����(165byte)|
# +------------------+------------+---------------+---------------+---------------+---------------+-----------------------+
# +------------------+-----------+----------------+-----------------+-------------+------------+--------------------------+
# |tbl_key����(8byte)|Ϣ��(4byte)|���롼��(14byte)|������Ϣ��(4byte)|�ڡ���(5byte)|UUID(36byte)|Ģɼ�ǡ���(Max20000�Х���)|
# +------------------+-----------+----------------+-----------------+-------------+------------+--------------------------+
# �ե�����̾�ˡ���ĥ�Ҥȥǥ��쥯�ȥ�̾���ղä�����Τ�ҥץ����ΰ������Ϥ�
#    site��ʬ
#      1 = orcaɸ��
#      2 = site-lib�Υ������ޥ���Ģɼ
#      3 = Postscript�ե�����ν���(�������᡼��ɽ���б�)
#
# ��LP̾�϶���ξ�硢�ҥץ����ΰ������ά����




#	puts '<temp>        = ����ե�����̾'

# ============================================================

# �إ��ɽ��

help_flg = 0

case	ARGV[0]
when	nil
	help_flg = 1
when	'-?', '/?', '-h', '/h', '--help'
	help_flg = 1
else
	help_flg = 0
end

if (help_flg != 0)
	puts '���Υ�����ץȤϡ����ԤǶ��ڤäơ������Υץ������Ϥ��ץ����Ǥ�'
	puts $0 + ' <temp> <exec> <form> <record> <site-form> <site-record> <data>'
	puts '<temp>        = ����ե�����̾'
	puts '<exec>        = ��ư�ץ����'
	puts '<form>        = ����ɸ��쥻�ץ�form�ǥ��쥯�ȥ�'
	puts '<record>      = ����ɸ��쥻�ץ�record�ǥ��쥯�ȥ�'
	puts '<site-form>   = ����ɸ��쥻�ץ�site��ͭform�ǥ��쥯�ȥ�'
	puts '<site-record> = ����ɸ��쥻�ץ�site��ͭrecord�ǥ��쥯�ȥ�'
	puts '<data>        = data�ե�����'
	exit 0
end


std_form = ''; std_record = ''; site_form = ''; site_record = ''; patch_form = ''

# ����λ���(�Ǹ�ˡ����ʤ餺��/�פ��դ������ˤ��Ƥ�������)
std_form = ARGV[2] + '/'   		# ���쥻ɸ��form�ǥ��쥯�ȥ�
std_record = ARGV[3] + '/' 		# ���쥻ɸ��record�ǥ��쥯�ȥ�
site_form = ARGV[4] + '/'  		# ���쥻site��ͭform�ǥ��쥯�ȥ�
site_record = ARGV[5] + '/'		# ���쥻site��ͭrecord�ǥ��쥯�ȥ�
patch_form = ARGV[9] + '/'  		# ���쥻site��ͭform�ǥ��쥯�ȥ�


# .red����ps�ե�������Ѵ�����ݤ˻��Ѥ���ץ����
RED_EXEC = 'red2ps'
# .red�ե�����ǡ�LP̾���ά���줿�ݤ˻��Ѥ���ץ��̾
DEFAULT_LP = 'lp1'



# ============================================================
# �ΰ�ν����

# �ե�����̾�ΰ�
temp_file = ''; exec_file = ''; dia_file = ''; def_file = ''; data_file = ''; lp_name = ''; offset_x = ''; offset_y = ''
temp_file2 = ''; exec_file2 = ''; dia_file2 = ''; def_file2 = ''; data_file2 = ''; lp_name2 = ''
site_flag = ''; base_dir = ''
#---- (2003/01/20 ) start
prt_flg = '';psfile_name = '';psfile_name_folder = '';exec_file_prv = '';exec_file_prv = ''
#---- (2003/01/20 ) end
# ʸ�����ΰ�
word1 = ''; word2 = []; word3 = ''
# exec��ʸ�����ΰ�
w_exec = ''
# fork���ΰ�
pid = []
# ���������ΰ�
li_cnt1 = 0
# ʸ����Ĺ���ΰ�
d2_len = 0


# ============================================================
# �����Υ��å�

# �����ο������å�
for li_cnt1 in 1..9 do
	if ARGV[li_cnt1] == nil
		puts '�����ο���­��ޤ���'
		exit 1
	end
end


# �������ΰ褫�顢ʸ����μ���
#temp_file = String(ARGV[0])		# ����ե�����
exec_file = String(ARGV[1])		# ��ư�ץ����ե�����
data_file = String(ARGV[6])		# data�ե�����̾
#---- (2003/07/03 ) add start
exec_file_prv = String(ARGV[7])		# ��ư�ץ����ե�����
RED_EXECPS = String(ARGV[8])		# ��ư�ץ����ե�����
#---- (2003/07/03 ) add end  


# ����ե�����Υե�����̾������
temp_file = data_file + '.tmp'


# ============================================================
# �ؿ������


# �ե�����̾������Ρ�'�ס�"�פ����������
def filename_change(name)
	filename_change = name.gsub /\A[\'\"]([\s\S]*?)[\'\"][\s]*?\z/, '\1'
end


# �ե�����̾�˶��򤬤����硢����ˡ�"�פ򥻥åȤ������
def filename_unchange(name)
	if name =~ / /
		filename_unchange = "\"" + name + "\""
	else
		filename_unchange = name
	end
end


# slash���դ���
def add_slash(str)
	if str =~ /[^\/]$/
		return (str += '/')
	else
		return str
	end
end

# �ե�����̾������ŵ����ֹ���������
def get_hospnum(str)
  b = str.split(/\//)
  return b[b.size-1][0,2].strip
#  return str.scan(/\/\S\S/).last.sub(/\//, "")
end



# ============================================================
# �����βù�����

# �ؿ���ƤӽФ��ơ�����Ρ�'�ס�"�פ���
temp_file = filename_change(temp_file)
exec_file = filename_change(exec_file)
data_file = filename_change(data_file)
#---- (2003/07/03 ) add start
exec_file_prv = filename_change(exec_file_prv)
#---- (2003/07/03 ) add end  
#---- (2007/05/30 ) add start
hospnum = get_hospnum(data_file)
puts "���ŵ����ֹ�   = [" + hospnum + "]"
#---- (2007/05/30 ) add end


# �դˡ��֤˶��򤬤���ʸ����ˡ���"�פ��ɲä�����Τ��Ѱ�
temp_file2 = filename_unchange(temp_file)
#exec_file2 = filename_unchange(exec_file_prv)
data_file2 = filename_unchange(data_file)


# ���ޥ�ɰ�����form��record�Υǥ��쥯�ȥ�̾�ˡ�/�פ��ʤ���硢��/�פ��դ������
std_form = add_slash(std_form)
std_record = add_slash(std_record)
site_form = add_slash(site_form)
site_record = add_slash(site_record)
patch_form = add_slash(patch_form)




# �ǥХå��Ѥ�ɽ��
puts "����ե�����   = [" + temp_file + "]"
puts "��ư�ץ���� = [" + exec_file + "]"
puts "data�ե�����   = [" + data_file + "]"


# ============================================================

# ����ե�����¸�ߥ����å�
begin
	if nil != File.size(temp_file)
		puts '����ե����뤬¸�ߤ���ΤǺ�����ޤ�'
		puts '�ե�����̾ = [' + temp_file + ']'
		# ����ե�����κ��
		File.delete(temp_file)
		puts '������ޤ���'
#		puts '����ե����뤬¸�ߤ��뤿�ᡢ�񤭹��ߤǤ��ޤ���'
#		puts '�ե�����̾ = [' + temp_file + ']'
#		exit 2
	end
rescue
# �㳰��ȯ������С�����ե����뤬¸�ߤ��ʤ��Τǡ��ϣ�
end


# data�ե������¸�ߥ����å�
begin
	if nil == File.size(data_file)
		puts 'data�ե����뤬¸�ߤ��ޤ���'
		puts '�ե�����̾ = [' + data_file + ']'
		exit 3
	end
rescue
# �㳰��ȯ������С�data�ե����뤬¸�ߤ��ʤ�
	puts 'data�ե����뤬¸�ߤ��ޤ���'
	puts '�ե�����̾ = [' + data_file + ']'
	exit 3
end


# ============================================================

# data�ե�������ɤ߹���
# ���ϥե�������ɤ߹��߽���
open(data_file, "r") do |fp|
	word1 = fp.read
end

# LAYEROPTION ����


# -----------------------------------

# ���Զ��ڤ����
#word2 = word1.split(/\s*\n\s*/)
word2 = word1.split(/\n/)


# -----------------------------------

# ������������ѥե���������
stop_file = ''
stop_file_1 = ''
stop_file_2 = ''


li_cnt1 = 0

# �¹Խ���
	puts '[start ' + `date` + ']'
word2.each do |d2|
  d2.scan(/MonpeLayerIn(.*)MonpeLayerOut/)
  LAYEROPTION = $1.to_s
#  puts  'layer = '
#  puts  LAYEROPTION
# ���������¹Բ�ǽȽ��
stop_file_1 = d2[227, 8].strip		# key����μ���
stop_file_2 = d2[239, 14].strip		# group����μ���
puts stop_file_1
puts stop_file_2
stop_file = '/tmp/' + stop_file_1 + stop_file_2 + '.tmp'
#stop_file = '/tmp/take.stop'
puts '[' + stop_file + ']'
if FileTest::exists?(stop_file)
        puts '�����������'
        File.delete(stop_file)
        if FileTest::exists?(temp_file)
           puts 'temp�ե�����������ޤ�'
           File.delete(temp_file)
        end
	exit 3
else
   puts 'no file'
end
# �ǥХå��ѥ�����
#	puts '[' + d2 + ']'
	li_cnt1 = li_cnt1 + 1
	d2_len = d2.size	# ʸ�����Ĺ���μ���


	# ��Ƭ30�Х��Ȥϡ�.dia��.def�ե�����Υե�����̾��ʬ
	# ���뤤�ϡ�.red�ե�����γ�ĥ�Ҥ�ޤ�ե�����̾
	dia_file = ''
	def_file = ''
	red_file = ''
	ls_w1 = ''	# �����ʸ�����ΰ�
	ls_w1 = d2[0, 30].strip	# �ե�����̾����ζ��������Ƽ���
	site_flag = d2[60, 1].strip		# site��ͭȽ��ե饰�μ���
#   dia�ե��������Ū��red���ѹ� by  take site�⸫��ɬ�פ�����
	if site_flag == '1'
#		if ls_w1 == 'HC06V01' || 'HC06V02'
		if ls_w1 == 'HC06V01'
			ls_w1 = ls_w1 + '.red'
   			puts 'dia hit!!'
		end
	end
#   dia�ե��������Ū��red���ѹ�
	if ls_w1 =~ /.red$/
		# .red�ե�����Ǥ���

		# Red�ե�����̾�Υ��å�
		case	site_flag
		when	'1'
			red_file = std_form + ls_w1
		when	'2'
			red_file = site_form + ls_w1
		else
			red_file = std_form + ls_w1
		end

		lp_name = d2[30, 20].strip				# LP̾�Υ��å�
		offset_x = d2[50, 5].strip				# offset-x�Υ��å�
		offset_y = d2[55, 5].strip				# offset-y�Υ��å�
#---- (2003/07/03 ) add start
		prt_flg = d2[61, 1].strip                       	# ���ϥե饰�Υ��å�
		psfile_name_folder = d2[62, 165].strip	                # PS�ե������Ǽ�ե�����Υ��å�
		psfile_name_folder = add_slash(psfile_name_folder) 	#/���ղ�
		psfile_name = psfile_name_folder.strip + hospnum + d2[227, 8].strip + d2[235, 4].strip \
		+ d2[239, 14].strip + d2[253, 4].strip + d2[257, 5].strip + d2[262,36].strip
									# PS�ե�����̾�Υ��å�
#		word3 = d2[51, (d2_len - 51)]				# ����ե�����ؽ��Ϥ������ƤΥ��å�
#		word3 = d2[262, (d2_len - 262)]				# ����ե�����ؽ��Ϥ������ƤΥ��å�
		word3 = d2[298, (d2_len - 298)]				# ����ե�����ؽ��Ϥ������ƤΥ��å�
#---- (2003/07/03 ) add end

		# ����ե�����ؤν񤭹���
		open(temp_file, "w") do |fp|
			fp.print word3
			fp.print ' ' * 20000
		end

# �ǥХå��Ѥ�ɽ��
		case	word3
		when	nil
			puts	'���ԤΤߤǤ�' + '[' + String(li_cnt1) + ']'
		when	''
			puts	'���ԤΤߤǤ�' + '[' + String(li_cnt1) + ']'
		else
			if d2 =~ /\A\s*\z/
				puts	'���򡦲��ԤǤ�' + '[' + String(li_cnt1) + ']'
#			else
#				puts	'OK [' + String(li_cnt1) + ']'
			end
		end
		# LP̾�����ꤵ��Ƥ��ʤ��ä��顢LP̾��lp1�ˤ���
		if lp_name == ''
			lp_name = DEFAULT_LP
		end
		# offset-x�����ꤵ��Ƥ��ʤ��ä��顢0�ˤ���
		if offset_x == ''
			offset_x = '0'
		end
		# offset-y�����ꤵ��Ƥ��ʤ��ä��顢0�ˤ���
		if offset_y == ''
			offset_y = '0'
		end

#---- (2003/01/20 ) start
#		w_exec = RED_EXEC + ' ' + red_file + ' ' + temp_file + ' -p ' + lp_name
#   ϫ�Ҥ��Ȥʤ�Ģɼ�򥹥��å����� st
	puts prt_flg
	puts ls_w1
	if prt_flg == '3' || prt_flg == '4'
		case	ls_w1
#   -----------> ϫ��ʬ
		when	'HCM22V04.red'
			ls_w1 = 'HCM22V04P.red'
			red_file = std_form + ls_w1
   			puts 'rousai hit!!'
		when	'HCM24V04.red'
			ls_w1 = 'HCM24V04P.red'
			red_file = std_form + ls_w1
   			puts 'rousai hit!!'
		when	'HCM21V04.red'
			ls_w1 = 'HCM21V04P.red'
			red_file = std_form + ls_w1
   			puts 'rousai hit!!'
		when	'HCM18V04.red'
			ls_w1 = 'HCM18V04P.red'
			red_file = std_form + ls_w1
   			puts 'rousai hit!!'
		when	'HCM20V04.red'
			ls_w1 = 'HCM20V04P.red'
			red_file = std_form + ls_w1
   			puts 'rousai hit!!'
		when	'HCN22V04.red'
			ls_w1 = 'HCN22V04P.red'
			red_file = std_form + ls_w1
   			puts 'rousai hit!!'
		when	'HCN21V04.red'
			ls_w1 = 'HCN21V04P.red'
			red_file = std_form + ls_w1
   			puts 'rousai hit!!'
		when	'HCN50.red'
			ls_w1 = 'HCN50P.red'
			red_file = std_form + ls_w1
   			puts 'rousai hit!!'
		when	'HCN51.red'
			ls_w1 = 'HCN51P.red'
			red_file = std_form + ls_w1
   			puts 'rousai hit!!'
#   -----------> ϫ��ʬ(2008/7/30)
		when	'HCM22V05.red'
			ls_w1 = 'HCM22V05P.red'
			red_file = std_form + ls_w1
		when	'HCM24V05.red'
			ls_w1 = 'HCM24V05P.red'
			red_file = std_form + ls_w1
		when	'HCM21V05.red'
			ls_w1 = 'HCM21V05P.red'
			red_file = std_form + ls_w1
		when	'HCM24V05.red'
			ls_w1 = 'HCM24V05P.red'
			red_file = std_form + ls_w1
		when	'HCM18V05.red'
			ls_w1 = 'HCM18V05P.red'
			red_file = std_form + ls_w1
		when	'HCM20V05.red'
			ls_w1 = 'HCM20V05P.red'
			red_file = std_form + ls_w1
		when	'HCN22V05.red'
			ls_w1 = 'HCN22V05P.red'
			red_file = std_form + ls_w1
		when	'HCM24V05.red'
			ls_w1 = 'HCM24V05P.red'
			red_file = std_form + ls_w1
		when	'HCN21V05.red'
			ls_w1 = 'HCN21V05P.red'
			red_file = std_form + ls_w1
		when	'HCM24V05.red'
			ls_w1 = 'HCM24V05P.red'
			red_file = std_form + ls_w1
		when	'HCN50V01.red'
			ls_w1 = 'HCN50V01P.red'
			red_file = std_form + ls_w1
		when	'HCM24V05.red'
			ls_w1 = 'HCM24V05P.red'
			red_file = std_form + ls_w1
		when	'HCN51V01.red'
			ls_w1 = 'HCN51V01P.red'
			red_file = std_form + ls_w1
		when	'HCM24V05.red'
			ls_w1 = 'HCM24V05P.red'
			red_file = std_form + ls_w1
#   -----------> ����ʬ
		when	'HCM23V04.red'
			ls_w1 = 'HCM48.red'
			red_file = std_form + ls_w1
   			puts 'jibai hit!!'
		when	'HCM29V02.red'
			ls_w1 = 'HCM49.red'
			red_file = std_form + ls_w1
   			puts 'jibai hit!!'
		when	'HCM53.red'
			ls_w1 = 'HCM54.red'
			red_file = std_form + ls_w1
   			puts 'jibai hit!!'
		when	'HCN23V04.red'
			ls_w1 = 'HCN48.red'
			red_file = std_form + ls_w1
   			puts 'jibai hit!!'
		when	'HCN53.red'
			ls_w1 = 'HCN54.red'
			red_file = std_form + ls_w1
   			puts 'jibai hit!!'
#   -----------> ����ʬ(2008/7/30)
		when	'HCN23V05.red'
			ls_w1 = 'HCN48V01.red'
			red_file = std_form + ls_w1
		when	'HCM29V03.red'
			ls_w1 = 'HCM49V01.red'
			red_file = std_form + ls_w1
		when	'HCM53V01.red'
			ls_w1 = 'HCM54V01.red'
			red_file = std_form + ls_w1
		when	'HCM29V03.red'
			ls_w1 = 'HCM49V01.red'
			red_file = std_form + ls_w1
		when	'HCM23V05.red'
			ls_w1 = 'HCM48V01.red'
			red_file = std_form + ls_w1
		when	'HCM29V03.red'
			ls_w1 = 'HCM49V01.red'
			red_file = std_form + ls_w1
		when	'HCN53V01.red'
			ls_w1 = 'HCN54V01.red'
			red_file = std_form + ls_w1
		when	'HCM29V03.red'
			ls_w1 = 'HCM49V01.red'
			red_file = std_form + ls_w1
#   -----------> ϫ��ʬ(2011/8/05)
                when    'HCM22V06.red'
                        ls_w1 = 'HCM22V06P.red'
                        red_file = std_form + ls_w1
                when    'HCN50V02.red'
                        ls_w1 = 'HCN50V02P.red'
                        red_file = std_form + ls_w1
                when    'HCM24V06.red'
                        ls_w1 = 'HCM24V06P.red'
                        red_file = std_form + ls_w1
                when    'HCM24V06.red'
                        ls_w1 = 'HCM24V06P.red'
                        red_file = std_form + ls_w1
                when    'HCM21V06.red'
                        ls_w1 = 'HCM21V06P.red'
                        red_file = std_form + ls_w1
                when    'HCN51V02.red'
                        ls_w1 = 'HCN51V02P.red'
                        red_file = std_form + ls_w1
                when    'HCM24V06.red'
                        ls_w1 = 'HCM24V06P.red'
                        red_file = std_form + ls_w1
                when    'HCM24V06.red'
                        ls_w1 = 'HCM24V06P.red'
                        red_file = std_form + ls_w1
                when    'HCM18V06.red'
                        ls_w1 = 'HCM18V06P.red'
                        red_file = std_form + ls_w1
                when    'HCM20V06.red'
                        ls_w1 = 'HCM20V06P.red'
                        red_file = std_form + ls_w1
#   -----------> ����ʬ(2011/8/05)
                when    'HCM23V06.red'
                        ls_w1 = 'HCM48V02.red'
                        red_file = std_form + ls_w1
                when    'HCN23V06.red'
                        ls_w1 = 'HCN48V02.red'
                        red_file = std_form + ls_w1
                when    'HCM29V04.red'
                        ls_w1 = 'HCM49V02.red'
                        red_file = std_form + ls_w1
                when    'HCM29V04.red'
                        ls_w1 = 'HCM49V02.red'
                        red_file = std_form + ls_w1
                when    'HCM53V02.red'
                        ls_w1 = 'HCM54V02.red'
                        red_file = std_form + ls_w1
                when    'HCN53V02.red'
                        ls_w1 = 'HCN54V02.red'
                        red_file = std_form + ls_w1
                when    'HCM29V04.red'
                        ls_w1 = 'HCM49V02.red'
                        red_file = std_form + ls_w1
                when    'HCM29V04.red'
                        ls_w1 = 'HCM49V02.red'
                        red_file = std_form + ls_w1
#   -----------> �����б�(2012/04/11)
                when    'HCN50V03.red'
                        ls_w1 = 'HCN50V03P.red'
                        red_file = std_form + ls_w1
                when    'HCN51V03.red'
                        ls_w1 = 'HCN51V03P.red'
                        red_file = std_form + ls_w1
                when    'HCN23V07.red'
                        ls_w1 = 'HCN48V03.red'
                        red_file = std_form + ls_w1
                when    'HCN53V03.red'
                        ls_w1 = 'HCN54V03.red'
                        red_file = std_form + ls_w1
		end
	end
#   ϫ�Ҥ��Ȥʤ�Ģɼ�򥹥��å����� ed

# take patch-lib ��form��¸�ߤ�����ϡ�path�����ؤ���
site_red_file = site_form + ls_w1
patch_red_file = patch_form + ls_w1
if File.exist?(site_red_file)
     puts 'Site  Hit!!' + ls_w1 + ' ' + site_form
else
  if File.exist?(patch_red_file)
     red_file = patch_red_file
     puts 'Patch Hit!!' + ls_w1 + ' ' + patch_form
  else
     puts 'Normal Hit!!' + ls_w1
  end
end

#---- (2003/07/03) start
		case	prt_flg
		when	nil
			puts	'���϶�ʬ̤����'
		when	''
			puts	'���϶�ʬ̤����'
		when	'1'     # �����Τߤλؼ�
		puts	'take1 Start [' + psfile_name + ']'
			w_exec = RED_EXEC + ' ' + red_file + ' ' + temp_file + ' -x ' + offset_x + ' -y ' + offset_y + ' -p ' + lp_name + ' ' + LAYEROPTION
		when	'2'     # ������PS�ե�������Ϥλؼ�
		puts	'take2 Start [' + psfile_name + ']'
			# ���ϥե�����̾�����ꤵ��Ƥ��ʤ��ä��顢�̾�ΰ���������Ԥ�
			if psfile_name == ''
				puts	'���ϥե�����̤̾����'
				w_exec = RED_EXEC + ' ' + red_file + ' ' + temp_file + ' -x ' + offset_x + ' -y ' + offset_y + ' -p ' + lp_name + ' ' + LAYEROPTION
			else
#				w_exec = RED_EXECPS + ' ' + red_file + ' ' + temp_file + ' -p ' + lp_name + ' -o ' + psfile_name
				w_exec = RED_EXEC + ' ' + red_file + ' ' + temp_file + ' -x ' + offset_x + ' -y ' + offset_y + ' -p ' + lp_name + ' -o ' + psfile_name + ' '  + LAYEROPTION
			end
		when	'3'     # PS�ե�������Ϥλؼ�
		puts	'take3 Start [' + psfile_name + ']'
			# ���ϥե�����̾�����ꤵ��Ƥ��ʤ��ä��顢�̾�ΰ���������Ԥ�
			if psfile_name == ''
				puts	'���ϥե�����̤̾����'
			else
				w_exec = RED_EXEC + ' ' + red_file + ' ' + temp_file + ' -o ' + psfile_name + ' ' + LAYEROPTION
			end
		when	'4'     # PS�ե�������Ϥλؼ�
			# ���ϥե�����̾�����ꤵ��Ƥ��ʤ��ä��顢�̾�ΰ���������Ԥ�
			if psfile_name == ''
				puts	'���ϥե�����̤̾����'
			else
				w_exec = RED_EXEC + ' ' + red_file + ' ' + temp_file + ' -o ' + psfile_name + ' ' + LAYEROPTION
			end
		else
			puts	'���϶�ʬ�������ꥨ�顼'
		end
#---- (2003/07/03) end  
#		if prt_flg == '3'
#			# ���ϥե�����̾�����ꤵ��Ƥ��ʤ��ä��顢�̾�ΰ���������Ԥ�
#			if psfile_name == ''
#				w_exec = RED_EXEC + ' ' + red_file + ' ' + temp_file + ' -p ' + lp_name
#			else
#				w_exec = RED_EXEC + ' ' + red_file + ' ' + temp_file + ' -o ' + psfile_name
#			end
#		else
#			w_exec = RED_EXEC + ' ' + red_file + ' ' + temp_file + ' -p ' + lp_name
#		end
#---- (2003/03/20) end
#---- (2003/01/20 ) end

# �ǥХå��Ѥ�ɽ��
#		puts w_exec
# **
		# �¹�����å���������
		puts	'Print Start [' + String(li_cnt1) + ']'
		# �ץ����μ¹�
		pid = fork do
			exec w_exec
		end
		sleep 0.01	# ͽ�����̥��顼�β���Τ��ᡢ�Ԥ�(�����Ԥ�ʤ��ȡ�ruby ver1.4��ǸƤӽФ��줿������ץȤ˥��顼��ȯ������)
		# �¹Ԥ����ץ���ब�����ޤ��Ԥ�(�����Σ����ܤϡ�1.4�ǤΥ��顼����Τ���)
		Process.waitpid(pid, 0)


	else
		# .red�ե�����ʳ��Ǥ���

		# Dia��def�ե�����̾�Υ��å�
		case	site_flag
		when	'1'
			dia_file = std_form + ls_w1 + '.dia'
			def_file = std_record + ls_w1 + '.def'
		when	'2'
			dia_file = site_form + ls_w1 + '.dia'
			def_file = site_record + ls_w1 + '.def'
		else
			dia_file = std_form + ls_w1 + '.dia'
			def_file = std_record + ls_w1 + '.def'
		end

		lp_name = d2[30, 20].strip	# LP̾�Υ��å�
#---- (2003/01/20 ) start
		prt_flg = d2[61, 1].strip                       	# ���ϥե饰�Υ��å�
#---- (2003/07/03 ) add start
		psfile_name_folder = d2[62, 165].strip	                # PS�ե������Ǽ�ե�����Υ��å�
		psfile_name_folder = add_slash(psfile_name_folder) 	#/���ղ�
		psfile_name = psfile_name_folder.strip + hospnum + d2[227, 8].strip + d2[235, 4].strip \
		+ d2[239, 14].strip + d2[253, 4].strip + d2[257, 5].strip + d2[262,36].strip
									# PS�ե�����̾�Υ��å�
#		word3 = d2[51, (d2_len - 51)]				# ����ե�����ؽ��Ϥ������ƤΥ��å�
#		word3 = d2[262, (d2_len - 262)]				# ����ե�����ؽ��Ϥ������ƤΥ��å�
		word3 = d2[298, (d2_len - 298)]				# ����ե�����ؽ��Ϥ������ƤΥ��å�
#---- (2003/07/03 ) add end
#---- (2003/01/20 ) end


		# ����ե�����ؤν񤭹���
		open(temp_file, "w") do |fp|
			fp.print word3
			fp.print ' ' * 20000
		end
# �ǥХå��Ѥ�ɽ��
		case	word3
		when	nil
			puts	'���ԤΤߤǤ�' + '[' + String(li_cnt1) + ']'
		when	''
			puts	'���ԤΤߤǤ�' + '[' + String(li_cnt1) + ']'
		else
			if d2 =~ /\A\s*\z/
				puts	'���򡦲��ԤǤ�' + '[' + String(li_cnt1) + ']'
#			else
#				puts	'OK [' + String(li_cnt1) + ']'
			end
		end
#---- (2003/01/20 ) start
#		w_exec = exec_file + ' ' + dia_file + ' ' + def_file + ' ' + temp_file
##		w_exec = exec_file + ' ' + dia_file2 + ' ' + def_file2 + ' ' + temp_file2

#---- (2003/07/03) start
		case	prt_flg
		when	nil
			puts	'���϶�ʬ̤����'
		when	''
			puts	'���϶�ʬ̤����'
		when	'1'     # �����Τߤλؼ�
			w_exec = exec_file + ' ' + dia_file + ' ' + def_file + ' ' + temp_file
			# LP̾�����ꤵ��Ƥ����顢�������ɲ�
			if lp_name != ''
				w_exec = w_exec + ' ' + lp_name
			end
			puts	'OKtake [' + w_exec + ']'
		when	'2'     # ������PS�ե�������Ϥλؼ�
			# ���ϥե�����̾�����ꤵ��Ƥ��ʤ��ä��顢�̾�ΰ���������Ԥ�
			if psfile_name == ''
				puts	'���ϥե�����̤̾����'
				w_exec = exec_file + ' ' + dia_file + ' ' + def_file + ' ' + temp_file
				# LP̾�����ꤵ��Ƥ����顢�������ɲ�
				if lp_name != ''
					w_exec = w_exec + ' ' + lp_name
				end
			else
				w_exec = exec_file_prv + ' ' + dia_file + ' ' + def_file + ' ' + temp_file + ' ' + psfile_name
				# LP̾�����ꤵ��Ƥ����顢�������ɲ�
				if lp_name != ''
					w_exec = w_exec + ' ' + lp_name
				end
			end
		when	'3'     # PS�ե�������Ϥλؼ�
			# ���ϥե�����̾�����ꤵ��Ƥ��ʤ��ä��顢�̾�ΰ���������Ԥ�
			if psfile_name == ''
				puts	'���ϥե�����̤̾����'
			else
				w_exec = exec_file_prv + ' ' + dia_file + ' ' + def_file + ' ' + temp_file + ' ' + psfile_name
				# LP̾�ϥ��ߡ�������(�������ʤ��⡼��)
				w_exec = w_exec + ' ' + '@@@@@@@@@@'
			end
		when	'4'     # PS�ե�������Ϥλؼ�
			# ���ϥե�����̾�����ꤵ��Ƥ��ʤ��ä��顢�̾�ΰ���������Ԥ�
			if psfile_name == ''
				puts	'���ϥե�����̤̾����'
			else
				w_exec = exec_file_prv + ' ' + dia_file + ' ' + def_file + ' ' + temp_file + ' ' + psfile_name
				# LP̾�ϥ��ߡ�������(�������ʤ��⡼��)
				w_exec = w_exec + ' ' + '@@@@@@@@@@'
			end
		else
			puts	'���϶�ʬ�������ꥨ�顼'
		end
#---- (2003/07/03) end  
#---- (2003/03/20) start
#		if prt_flg == '3'
#			# ���ϥե�����̾�����ꤵ��Ƥ��ʤ��ä��顢�̾�ΰ���������Ԥ�
#			if psfile_name == ''
#				w_exec = exec_file + ' ' + dia_file + ' ' + def_file + ' ' + temp_file
#			# LP̾�����ꤵ��Ƥ����顢�������ɲ�
#				if lp_name != ''
#					w_exec = w_exec + ' ' + lp_name
#				end
#			else
#				w_exec = exec_file + ' ' + dia_file + ' ' + def_file + ' ' + temp_file + ' -o ' + psfile_name
#			end
#		else
#			w_exec = exec_file + ' ' + dia_file + ' ' + def_file + ' ' + temp_file
#			# LP̾�����ꤵ��Ƥ����顢�������ɲ�
#			if lp_name != ''
#				w_exec = w_exec + ' ' + lp_name
#			end
#		end
#---- (2003/03/20) end
		# LP̾�����ꤵ��Ƥ����顢�������ɲ�
#		if lp_name != ''
#			w_exec = w_exec + ' ' + lp_name
#		end
#---- (2003/01/20 ) end
# �ǥХå��Ѥ�ɽ��
#		puts w_exec
# **
		# �¹�����å���������
		puts	'Print Start [' + String(li_cnt1) + ']'
		# �ץ����μ¹�
		pid = fork do
			exec w_exec
		end
		sleep 0.01	# ͽ�����̥��顼�β���Τ��ᡢ�Ԥ�(�����Ԥ�ʤ��ȡ�ruby ver1.4��ǸƤӽФ��줿������ץȤ˥��顼��ȯ������)
		# �¹Ԥ����ץ���ब�����ޤ��Ԥ�(�����Σ����ܤϡ�1.4�ǤΥ��顼����Τ���)
		Process.waitpid(pid, 0)

	end
end



	puts '[end ' + `date` + ']'
# ============================================================

# ����ե�������
begin
	if nil != File.size(temp_file)
		# ����ե����뤬¸�ߤ���
		# ����ե�����κ��
		File.delete(temp_file)
	end
rescue
# �㳰��ȯ������С�����ե����뤬¸�ߤ��ʤ�
end



# ============================================================


