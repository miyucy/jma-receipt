# generate "directory" file

BEGIN {
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
