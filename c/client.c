/*
 * Copyright (c) 2016 SoundBooze <soundbooze@gmail.com>
 *                            _ _                        
 *  ___  ___  _   _ _ __   __| | |__   ___   ___ _______ 
 * / __|/ _ \| | | | '_ \ / _` | '_ \ / _ \ / _ \_  / _ \
 * \__ \ (_) | |_| | | | | (_| | |_) | (_) | (_) / /  __/
 * |___/\___/ \__,_|_| |_|\__,_|_.__/ \___/ \___/___\___|
 *                                                     
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <assert.h>
#include <string.h>
#include <md5.h>
#include <tls.h>

#include "client.h"
#include "sio.h"
#include "blowfish.h"

struct tls *tls;
struct tls_config *tls_config;

int
client_init (const char *server, const char *port)
{
  char *md5 = blowfish_init();

  if (tls_init() != 0) {
    printf("tls_init() failed\n");
    return -1;
  }

  if ((tls = tls_client()) == NULL) {
    printf("tls_client() failed\n");
    return -1;
  }

  if ((tls_config = tls_config_new()) == NULL) {
    printf("tls_config_new() failed\n");
    return -1;
  }

  tls_config_insecure_noverifycert(tls_config);
  tls_config_insecure_noverifyname(tls_config);

  if (tls_configure(tls, tls_config) != 0) {
    printf("tls_configure() failed\n");
    return -1;
  }

  if (tls_connect(tls, server, port) != 0) {
    printf("error: %s\n", tls_error(tls));
    return -1;
  }

  if (tls_write(tls, (const void *) md5, MD5_DIGEST_STRING_LENGTH) < 0) {
    printf("tls_write failed: %s\n", tls_error(tls));
  }

  return 0;
}

void *
client_read_loop (void *arg)
{
  size_t bufsz = sio_getbufsz();
  u_int8_t buf_tls_pcm[bufsz];

  while(1)
  {
    ssize_t len_tr = tls_read(tls, buf_tls_pcm, bufsz);
    if (len_tr < 0) {
      printf("tls_read failed: %s\n", tls_error(tls));
    }
    else if (len_tr == 0) {
      client_close();
      break;
    }
    blowfish_decrypt(buf_tls_pcm, (u_int32_t) len_tr);
    sio_writep(buf_tls_pcm, len_tr);
  }

  return NULL;
}

void
client_close (void)
{
  tls_close(tls);
  tls_free(tls);
  tls_config_free(tls_config);
}
