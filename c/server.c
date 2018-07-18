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
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <assert.h>
#include <errno.h>
#include <md5.h>
#include <tls.h>

#include "server.h"
#include "sio.h"
#include "blowfish.h"

struct tls *tls;
struct tls *tls_cctx;
struct tls_config *tls_config;

int sockfd;

int
server_init (const int port, const char *key_file, const char *cacert_file)
{
  struct sockaddr_in server_addr;
  struct sockaddr_in client_addr;
  socklen_t len = sizeof client_addr;
  int opt;

  char auth[MD5_DIGEST_STRING_LENGTH];

  char *md5 = blowfish_init();

  if (tls_init() != 0) {
    printf("tls_init() failed\n");
    return -1;
  }

  if ((tls = tls_server()) == NULL) {
    printf("tls_server() failed\n");
    return -1;
  }

  if ((tls_config = tls_config_new()) == NULL) {
    printf("tls_config_new() failed\n");
    return -1;
  }

  tls_config_verify_client_optional(tls_config);

  if (tls_config_set_cert_file(tls_config, cacert_file) == -1) {
    printf("unable to set TLS certificate file %s\n", cacert_file);
    return -1;
  }

  if (tls_config_set_ca_file(tls_config, cacert_file) == -1) {
    printf("unable to set root CA file %s\n", cacert_file);
    return -1;
  }

  if (tls_config_set_key_file(tls_config, key_file) == -1) {
    printf("unable to set TLS key file %s\n", key_file);
    return -1;
  }

  tls_config_set_protocols(tls_config, TLS_PROTOCOLS_ALL);
  tls_config_set_ciphers(tls_config, "secure");
  tls_config_insecure_noverifyname(tls_config);
  tls_config_insecure_noverifycert(tls_config);

  if (tls_configure(tls, tls_config) != 0) {
    printf("tls_configure() failed: %s\n", tls_error(tls));
    return -1;
  }

  sockfd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
  if (sockfd < 0) {
    printf("socket() failed: %s\n", strerror(errno));
    return -1;
  }

  opt = 1;
  bzero(&server_addr, sizeof server_addr);
  server_addr.sin_addr.s_addr = INADDR_ANY;
  server_addr.sin_family = AF_INET;
  server_addr.sin_port = htons(port);
  assert(setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof opt) == 0);

  if (bind(sockfd, (struct sockaddr *) &server_addr, sizeof server_addr) < 0) {
    perror("bind()");
    return -1;
  }

  if (listen(sockfd, 32) < 0) {
    perror("listen()");
    return -1;
  }

  while (1) 
  {
  
    fprintf(stdout, "[+] Waiting for valid connection\n");

    int client_fd = accept(sockfd, (struct sockaddr *) &client_addr, &len);
    if (client_fd < 0) {
      perror("accept()");
    }

    if (tls_accept_socket(tls, &tls_cctx, client_fd) < 0) {
      printf("tls_accept_socket() failed: %s\n", tls_error(tls));
      tls_cctx = NULL;
    }

    if (tls_read(tls_cctx, auth, MD5_DIGEST_STRING_LENGTH) < 0) {
      printf("tls_read failed: %s\n", tls_error(tls_cctx));
    }

    fprintf(stdout, "[+] Authentication (%s)\n", inet_ntoa(client_addr.sin_addr));

    if (!strncmp(md5, auth, MD5_DIGEST_STRING_LENGTH)) {
      fprintf(stdout, "[+] Starting conversation\n");
      break;
    }

  }

  return 0;
}

void *
server_write_loop (void *arg)
{
  size_t bufsz = sio_getbufsz();
  u_int8_t buf_pcm_tls[bufsz];

  while(1) 
  {
    size_t len = sio_readp(buf_pcm_tls);
    blowfish_encrypt(buf_pcm_tls, (u_int32_t) len);
    ssize_t len_w = tls_write(tls_cctx, (const void *) buf_pcm_tls, len);
    if (len_w < 0) {
      printf("tls_write failed: %s\n", tls_error(tls_cctx));
    }
    else if (len_w == 0) {
      server_close();
      break;
    }
  }

  return NULL;
}

void
server_close (void)
{
  tls_close(tls_cctx);
  tls_free(tls_cctx);

  tls_close(tls);
  tls_free(tls);
  tls_config_free(tls_config);
}
