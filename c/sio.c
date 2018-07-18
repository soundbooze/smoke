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

#include <err.h>
#include <poll.h>
#include <sndio.h>

#include "sio.h"

struct sio_hdl *hdl_play;
struct sio_hdl *hdl_capture;

int state;

void
sio_close_all (void)
{
  if (state == SIO_PLAYBACK) {
    if (!sio_stop(hdl_play)) {
      errx(1, "sio_stop(): failed\n");
    }
    sio_close(hdl_play);
  }
  else if (state == SIO_CAPTURE) {
    if (!sio_stop(hdl_capture)) {
      errx(1, "sio_stop(): failed\n");
    }
    sio_close(hdl_capture);
  }
}

void
sio_init (const unsigned int sig, const unsigned int bits, 
          const unsigned int chan, const unsigned int rate, 
          const char *playback_device, const char *capture_device, u_int8_t mode)
{
  struct sio_par par_play;
  struct sio_par par_capture;

  state = mode;

  if (mode == SIO_PLAYBACK) {
    sio_initpar(&par_play);
    par_play.sig = sig;
    par_play.le = SIO_LE_NATIVE;
    par_play.bits = bits;
    par_play.pchan = chan;
    par_play.rate = rate;
    par_play.xrun = SIO_IGNORE;

    hdl_play = sio_open(playback_device, SIO_PLAY, 0);
    if (hdl_play == NULL) {
      errx(1, "sio_open(): failed\n");
    }

    if (!sio_setpar(hdl_play, &par_play)) {
      errx(1, "sio_setpar(): failed\n");
    }

    if (!sio_getpar(hdl_play, &par_play)) {
      errx(1, "sio_getpar(): failed\n");
    }

    if (!sio_start(hdl_play)) {
      errx(1, "sio_start(): failed\n");
    }
  }

  else if (mode == SIO_CAPTURE) {
    sio_initpar(&par_capture);
    par_capture.sig = sig;
    par_capture.le = SIO_LE_NATIVE;
    par_capture.bits = bits;
    par_capture.rchan = chan;
    par_capture.rate = rate;
    par_capture.xrun = SIO_IGNORE;

    hdl_capture = sio_open(capture_device, SIO_REC, 0);
    if (hdl_capture == NULL) {
      errx(1, "sio_open(): failed\n");
    }

    if (!sio_setpar(hdl_capture, &par_capture)) {
      errx(1, "sio_setpar(): failed\n");
    }

    if (!sio_getpar(hdl_capture, &par_capture)) {
      errx(1, "sio_getpar(): failed\n");
    }

    if (!sio_start(hdl_capture)) {
      errx(1, "sio_start(): failed\n");
    }
  }
}

size_t
sio_readp (u_int8_t *buf)
{
  size_t len_r = sio_read(hdl_capture, buf, sio_getbufsz());
  if (sio_eof(hdl_capture)) {
    errx(1, "sio_read(): failed\n");
  }
  return len_r;
}

size_t
sio_writep (u_int8_t *buf, size_t len)
{
  int len_w = sio_write(hdl_play, buf, len);
  if (sio_eof(hdl_play)) {
    errx(1, "sio_write(): failed\n");
  }
  return len_w;
}

size_t
sio_getbufsz (void)
{
  return 1024;
}
