#include <stdio.h>
#include <syslog.h>

cobabort (char *message)
{
	fprintf(stderr, "cobabort: %s\n", message);
	syslog(LOG_ERR, message);
	exit(1);
}
