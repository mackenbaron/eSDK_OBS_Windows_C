/** **************************************************************************
 * testsimplexml.c
 * 
 * Copyright 2008 Bryan Ischo <bryan@ischo.com>
 * 
 * This file is part of libs3.
 * 
 * libs3 is free software: you can redistribute it and/or modify it under the
 * terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation, version 3 of the License.
 *
 * In addition, as a special exception, the copyright holders give
 * permission to link the code of this library and its programs with the
 * OpenSSL library, and distribute linked combinations including the two.
 *
 * libs3 is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * version 3 along with libs3, in a file named COPYING.  If not, see
 * <http://www.gnu.org/licenses/>.
 *
 ************************************************************************** **/

#include <stdio.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include "simplexml.h"
#include "securec.h"



#if defined __GNUC__ || defined LINUX
#include <fcntl.h>
#include <unistd.h> 
#endif

static S3Status simpleXmlCallback(const char *elementPath, const char *data,
                                  int dataLen, void *callbackData)
{
    (void) callbackData;

    printf("[%s]: [%.*s]\n", elementPath, dataLen, data);
    return S3StatusOK;
}

//lint -e550
// The only argument allowed is a specification of the random seed to use
int main(int argc, char **argv)
{
    if (argc > 1) {
        char *arg = argv[1];
        int seed = 0;
        while (*arg) {
            seed *= 10;
            seed += (*arg++ - '0');
        }
        
        srand(seed);
    }
    else {
        srand(time(0));
    }

    SimpleXml simpleXml;

    simplexml_initialize(&simpleXml, &simpleXmlCallback, 0);//lint !e546 !e64 !e119

    // Read chunks of 10K from stdin, and then feed them in random chunks
    // to simplexml_add
    char inbuf[10000];

    int amt_read;
    while ((amt_read = fread(inbuf, 1, sizeof(inbuf), stdin)) > 0) { //lint !e409 !e48 !e50
        char *buf = inbuf;
        while (amt_read) {

#if defined __GNUC__ || defined LINUX
		enum {LEN = 12};
		char SessionID[LEN + 1] = {0x00}; /* SessionID will hold the ID, starting with
										* the characters "ID" followed by a 
										* random integer */
		int r = 0;
		int num = 0;
		/* ...do something... */
		int fd;
		fd = open("/dev/random", O_RDONLY); /* 通过读取/dev/random来获取随机数 */
		if (fd > 0)
		{
			read (fd,&r,sizeof (int));
		}
		close (fd);
		num = sprintf_s(SessionID, sizeof(SessionID), "ID-%d", r);  /* generate the ID */

		int amt = (num % amt_read) + 1;
		S3Status status = simplexml_add(&simpleXml, buf, amt);
		if (status != S3StatusOK) {
			fprintf(stderr, "ERROR: Parse failure: %d\n", status);
			simplexml_deinitialize(&simpleXml);
			return -1;
		}
		buf += amt, amt_read -= amt;

		simplexml_deinitialize(&simpleXml);

#else
			HCRYPTPROV hCryptProv; //lint !e522
			union 
			{
				BYTE bs[sizeof(long int)];//lint !e601
				long int li;
			} rand_buf;

			if (!CryptGenRandom(hCryptProv, sizeof(rand_buf), &rand_buf))
			{
				printf_s("Error during CryptGenRandom.\n");
			} 
			else 
			{
				int amt = (rand_buf.li % amt_read) + 1;
				S3Status status = simplexml_add(&simpleXml, buf, amt);//lint !e522
				if (status != S3StatusOK) {
					fprintf_s(stderr, "ERROR: Parse failure: %d\n", status);//lint !e409 !e48 !e50
					simplexml_deinitialize(&simpleXml);
					return -1;
				}
				buf += amt, amt_read -= amt;
			}


	simplexml_deinitialize(&simpleXml); //lint !e525
#endif

		}
	}

    return 0;
}
//lint +e550