# generate "directory" file

BEGIN {
  start_port=9100;
  hosp=0;


  for (i = 2; i < ARGC; i++) {
    if (ARGV[i] == "hosp")
      hosp = 1;
    ARGV[i]="";
  }
}

{
  if ($0 ~ /ld[ |\t]*{/){
    do {
      # support hosp
      if (hosp || !($NF ~ /\#hosp/) ){
        print $0;
      }
      getline;
    } while ($0 !~ /}\;/)
  }
  print $0;
}
