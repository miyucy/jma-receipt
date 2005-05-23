#define	New(s)				(s *)malloc(sizeof(s))

#define TOZENKAKU  1
#define TOHANKAKU  2
#define TOKATAKANA 3
#define TOHIRAGANA 4

struct COBString {
	size_t len;
	size_t ptr;
	char *body;
};

extern int kanaconv (char *args);
extern int tozenkaku (int syori_flg, struct COBString *org, struct COBString *new );
extern void tokatakana (char *org_str, char *new_str);
extern void tohiragana (char *org_str, char *new_str);



