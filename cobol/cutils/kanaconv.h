/*
 orca
*/

#define UNKNOWN      0
#define ZENKAKU      1
#define HIRAGANA     2
#define KATAKANA     4
#define HKANA        6
#define SONOTA       8
#define NUMBER      16
#define ALPHA       32
#define KIGOU       64
#define ASCII      112
#define GAIJI      128

typedef struct {
	size_t  out_len;
	int in_type;
	int out_type;
	unsigned char out_char[2];

} ConvertChar;


void StringCobol2C(char	*str, size_t size);
void StringC2Cobol(char	*str,  size_t size);

int kanaconv (char *args);
int _kanaconv (int conv_flg, size_t max_len, char *inchar, char *ouchar);



