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
#include <signal.h>
#include <pthread.h>
#include <sndio.h>

#include "sio.h"
#include "server.h"
#include "client.h"

#define SIGNED       0
#define BITS         8
#define CHANNELS     2
#define RATE      9600

static pthread_t pth;

void main_usage (void);
void main_signal_handler (int);

void
main_usage(void)
{
  fprintf(stderr, "usage: smoke [-p playback device] [-c capture device] [-x key.pem] [-y cert.pem] [-S server] [-P port]\n");
  exit(EXIT_FAILURE);
}


void
main_signal_handler (int sig)
{
  sio_close_all();
  pthread_exit(&pth);
  fprintf(stderr, "[-] Abnormal program termination!\n");
  exit(EXIT_FAILURE);
}

int
main (int argc, char **argv)
{
  char *playback_device = SIO_DEVANY;
  char *capture_device = SIO_DEVANY;
  char *server = NULL;
  int port = 5150;
  char *key = "cert/smokekey.pem";
  char *cert = "cert/smokecert.pem";

  int ch;

  while ((ch = getopt(argc, argv, "p:c:x:y:S:P:h")) != -1) {
    switch (ch) {
      case 'p':
        playback_device = optarg;
        break;
      case 'c':
        capture_device = optarg;
        break;
      case 'x':
        key = optarg;
        break;
      case 'y':
        cert = optarg;
        break;
      case 'S':
        server = optarg;
        break;
      case 'P':
        port = atoi(optarg);
        break;
      case 'h':
      default:
        main_usage();
        break;
    }
  }

  argc -= optind;
  argv += optind;

  signal(SIGINT, main_signal_handler);
  signal(SIGTERM, main_signal_handler);
  signal(SIGQUIT, main_signal_handler);
  signal(SIGKILL, main_signal_handler);
  signal(SIGSEGV, main_signal_handler);

  if (!server) {
    sio_init(SIGNED, BITS, CHANNELS, RATE, playback_device, capture_device, SIO_CAPTURE);

    if (server_init(port, key, cert) == -1) {
      exit(EXIT_FAILURE);
    }

    if (pthread_create(&pth, NULL, server_write_loop, NULL)) {
      main_signal_handler(SIGIO);
    }

    pthread_join(pth, NULL);
  }

  else {
    char pbuff[16] = {'\0'};
    snprintf(pbuff, 16, "%d", port);

    sio_init(SIGNED, BITS, CHANNELS, RATE, playback_device, capture_device, SIO_PLAYBACK);

    if (client_init(server, pbuff) == -1) {
      exit(EXIT_FAILURE);
    }

    if (pthread_create(&pth, NULL, client_read_loop, NULL)) {
      main_signal_handler(SIGIO);
    }

    pthread_join(pth, NULL);
  }

  return EXIT_SUCCESS;
}

