# generate "directory" file

BEGIN {
  start_port=9100;
  debug=0;
  hosp=0;


  for (i = 2; i < ARGC; i++) {
    if (ARGV[i] == "debug")
      debug = 1;
    else if (ARGV[i] == "hosp")
      hosp = 1;
    ARGV[i]="";
  }
}

{
  if ($0 ~ /ld[ |\t]*{/){
    do {
      # support hosp
      if (hosp || !($NF ~ /\#hosp/) ){
        # add port number
        if (debug){
  	  sub(/localhost/,"&:" substr($1,5)+start_port);
        }
        print $0;
      }
      getline;
    } while ($0 !~ /}\;/)
  }
  print $0;
}
