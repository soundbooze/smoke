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

	.file	"sio.s"
	.section	.rodata
.LC0:
	.string	"sio_stop(): failed\n"
	.text
	.globl	sio_close_all
	.type	sio_close_all, @function
sio_close_all:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$36, %esp
	call	__i686.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	state@GOT(%ebx), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	jne	.L2
	movl	hdl_play@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	sio_stop@PLT
	testl	%eax, %eax
	jne	.L4
	leal	.LC0@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	$1, (%esp)
	call	errx@PLT
.L4:
	movl	hdl_play@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	sio_close@PLT
	jmp	.L10
.L2:
	movl	state@GOT(%ebx), %eax
	movl	(%eax), %eax
	cmpl	$1, %eax
	jne	.L10
	movl	hdl_capture@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	sio_stop@PLT
	testl	%eax, %eax
	jne	.L8
	leal	.LC0@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	$1, (%esp)
	call	errx@PLT
.L8:
	movl	hdl_capture@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	sio_close@PLT
.L10:
	addl	$36, %esp
	popl	%ebx
	popl	%ebp
	ret
	.size	sio_close_all, .-sio_close_all
	.section	.rodata
.LC1:
	.string	"sio_open(): failed\n"
.LC2:
	.string	"sio_setpar(): failed\n"
.LC3:
	.string	"sio_getpar(): failed\n"
.LC4:
	.string	"sio_start(): failed\n"
	.text
	.globl	sio_init
	.type	sio_init, @function
sio_init:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$36, %esp
	call	__i686.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	32(%ebp), %eax
	movb	%al, -24(%ebp)
	movzbl	-24(%ebp), %edx
	movl	state@GOT(%ebx), %eax
	movl	%edx, (%eax)
	cmpb	$0, -24(%ebp)
	jne	.L12
	movl	par_play@GOT(%ebx), %eax
	movl	%eax, (%esp)
	call	sio_initpar@PLT
	movl	par_play@GOT(%ebx), %edx
	movl	8(%ebp), %eax
	movl	%eax, 8(%edx)
	movl	par_play@GOT(%ebx), %eax
	movl	$1, 12(%eax)
	movl	par_play@GOT(%ebx), %edx
	movl	12(%ebp), %eax
	movl	%eax, (%edx)
	movl	par_play@GOT(%ebx), %edx
	movl	16(%ebp), %eax
	movl	%eax, 24(%edx)
	movl	par_play@GOT(%ebx), %edx
	movl	20(%ebp), %eax
	movl	%eax, 28(%edx)
	movl	par_play@GOT(%ebx), %eax
	movl	$0, 36(%eax)
	movl	$0, 8(%esp)
	movl	$1, 4(%esp)
	movl	24(%ebp), %eax
	movl	%eax, (%esp)
	call	sio_open@PLT
	movl	%eax, %edx
	movl	hdl_play@GOT(%ebx), %eax
	movl	%edx, (%eax)
	movl	hdl_play@GOT(%ebx), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	jne	.L14
	leal	.LC1@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	$1, (%esp)
	call	errx@PLT
.L14:
	movl	hdl_play@GOT(%ebx), %eax
	movl	(%eax), %edx
	movl	par_play@GOT(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	sio_setpar@PLT
	testl	%eax, %eax
	jne	.L16
	leal	.LC2@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	$1, (%esp)
	call	errx@PLT
.L16:
	movl	hdl_play@GOT(%ebx), %eax
	movl	(%eax), %edx
	movl	par_play@GOT(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	sio_getpar@PLT
	testl	%eax, %eax
	jne	.L18
	leal	.LC3@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	$1, (%esp)
	call	errx@PLT
.L18:
	movl	hdl_play@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	sio_start@PLT
	testl	%eax, %eax
	jne	.L31
	leal	.LC4@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	$1, (%esp)
	call	errx@PLT
.L12:
	cmpb	$1, -24(%ebp)
	jne	.L31
	movl	par_capture@GOT(%ebx), %eax
	movl	%eax, (%esp)
	call	sio_initpar@PLT
	movl	par_capture@GOT(%ebx), %edx
	movl	8(%ebp), %eax
	movl	%eax, 8(%edx)
	movl	par_capture@GOT(%ebx), %eax
	movl	$1, 12(%eax)
	movl	par_capture@GOT(%ebx), %edx
	movl	12(%ebp), %eax
	movl	%eax, (%edx)
	movl	par_capture@GOT(%ebx), %edx
	movl	16(%ebp), %eax
	movl	%eax, 20(%edx)
	movl	par_capture@GOT(%ebx), %edx
	movl	20(%ebp), %eax
	movl	%eax, 28(%edx)
	movl	par_capture@GOT(%ebx), %eax
	movl	$0, 36(%eax)
	movl	$0, 8(%esp)
	movl	$2, 4(%esp)
	movl	28(%ebp), %eax
	movl	%eax, (%esp)
	call	sio_open@PLT
	movl	%eax, %edx
	movl	hdl_capture@GOT(%ebx), %eax
	movl	%edx, (%eax)
	movl	hdl_capture@GOT(%ebx), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	jne	.L24
	leal	.LC1@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	$1, (%esp)
	call	errx@PLT
.L24:
	movl	hdl_capture@GOT(%ebx), %eax
	movl	(%eax), %edx
	movl	par_capture@GOT(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	sio_setpar@PLT
	testl	%eax, %eax
	jne	.L26
	leal	.LC2@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	$1, (%esp)
	call	errx@PLT
.L26:
	movl	hdl_capture@GOT(%ebx), %eax
	movl	(%eax), %edx
	movl	par_capture@GOT(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	sio_getpar@PLT
	testl	%eax, %eax
	jne	.L28
	leal	.LC3@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	$1, (%esp)
	call	errx@PLT
.L28:
	movl	hdl_capture@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	sio_start@PLT
	testl	%eax, %eax
	jne	.L31
	leal	.LC4@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	$1, (%esp)
	call	errx@PLT
.L31:
	addl	$36, %esp
	popl	%ebx
	popl	%ebp
	ret
	.size	sio_init, .-sio_init
	.section	.rodata
.LC5:
	.string	"poll(): failed\n"
.LC6:
	.string	"poll(): device disappeared\n"
	.type	.LSSH0, @object
	.size	.LSSH0, 16
.LSSH0:
	.string	"_sio_poll_wait_"
	.text
	.globl	_sio_poll_wait_
	.type	_sio_poll_wait_, @function
_sio_poll_wait_:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$52, %esp
	call	__i686.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	8(%ebp), %eax
	movl	%eax, -40(%ebp)
	movl	__guard_local@GOTOFF(%ebx), %eax
	movl	%eax, -8(%ebp)
	xorl	%eax, %eax
.L33:
	movl	$4, 8(%esp)
	leal	-24(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-40(%ebp), %eax
	movl	%eax, (%esp)
	call	sio_pollfd@PLT
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	jle	.L34
	movl	-12(%ebp), %eax
	movl	$-1, 8(%esp)
	movl	%eax, 4(%esp)
	leal	-24(%ebp), %eax
	movl	%eax, (%esp)
	call	poll@PLT
	testl	%eax, %eax
	jns	.L34
	leal	.LC5@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	$1, (%esp)
	call	errx@PLT
.L34:
	leal	-24(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-40(%ebp), %eax
	movl	%eax, (%esp)
	call	sio_revents@PLT
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	.L37
	leal	.LC6@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	$1, (%esp)
	call	errx@PLT
.L37:
	movl	-16(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L33
	movl	-8(%ebp), %eax
	xorl	__guard_local@GOTOFF(%ebx), %eax
	je	.L41
	leal	.LSSH0@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	__stack_smash_handler@PLT
.L41:
	addl	$52, %esp
	popl	%ebx
	popl	%ebp
	ret
	.size	_sio_poll_wait_, .-_sio_poll_wait_
	.section	.rodata
.LC7:
	.string	"sio_read(): failed\n"
	.text
	.globl	sio_readp
	.type	sio_readp, @function
sio_readp:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$36, %esp
	call	__i686.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	call	sio_getbufsz@PLT
	movl	%eax, %edx
	movl	hdl_capture@GOT(%ebx), %eax
	movl	(%eax), %ecx
	movl	%edx, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%ecx, (%esp)
	call	sio_read@PLT
	movl	%eax, -12(%ebp)
	movl	hdl_capture@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	sio_eof@PLT
	testl	%eax, %eax
	je	.L43
	leal	.LC7@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	$1, (%esp)
	call	errx@PLT
.L43:
	movl	-12(%ebp), %eax
	addl	$36, %esp
	popl	%ebx
	popl	%ebp
	ret
	.size	sio_readp, .-sio_readp
	.section	.rodata
.LC8:
	.string	"sio_write(): failed\n"
	.text
	.globl	sio_writep
	.type	sio_writep, @function
sio_writep:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$36, %esp
	call	__i686.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	hdl_play@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	_sio_poll_wait_
	movl	hdl_play@GOT(%ebx), %eax
	movl	(%eax), %edx
	movl	12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	sio_write@PLT
	movl	%eax, -12(%ebp)
	movl	hdl_play@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	sio_eof@PLT
	testl	%eax, %eax
	je	.L47
	leal	.LC8@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	$1, (%esp)
	call	errx@PLT
.L47:
	movl	-12(%ebp), %eax
	addl	$36, %esp
	popl	%ebx
	popl	%ebp
	ret
	.size	sio_writep, .-sio_writep
	.globl	sio_getbufsz
	.type	sio_getbufsz, @function
sio_getbufsz:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$1024, %eax
	leave
	ret
	.size	sio_getbufsz, .-sio_getbufsz
	.comm	hdl_play,4,4
	.comm	hdl_capture,4,4
	.comm	par_play,64,32
	.comm	par_capture,64,32
	.comm	state,4,4
	.section	.gnu.linkonce.t.__i686.get_pc_thunk.bx,"ax",@progbits
	.globl	__i686.get_pc_thunk.bx
	.hidden	__i686.get_pc_thunk.bx
	.type	__i686.get_pc_thunk.bx, @function
__i686.get_pc_thunk.bx:
	movl	(%esp), %ebx
	ret
