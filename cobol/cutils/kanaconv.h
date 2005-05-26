/*
 orca
*/

#define HKANA        1
#define HIRAGANA     2
#define KATAKANA     4
#define OTHER        8
#define ZENKAKU     15
#define NUMBER      16
#define ALPHA       32
#define KIGOU       64
#define ASCII      112
#define GAIJI      128
#define UNKNOWN    128

typedef struct {
	size_t  out_len;
	int in_type;
	int out_type;
	unsigned char out_char[2];

} ConvertChar;


void StringCobol2C(char	*str, size_t size);
void StringC2Cobol(char	*str,  size_t size);

int kanaconv (char *args);
int _kanaconv (int conv_flg, int char_type, size_t max_len, char *inchar, char *ouchar);



