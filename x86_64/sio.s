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
.LFB5:
	pushq	%rbp
.LCFI0:
	movq	%rsp, %rbp
.LCFI1:
	subq	$16, %rsp
.LCFI2:
	movq	state@GOTPCREL(%rip), %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	jne	.L2
	movq	hdl_play@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	sio_stop@PLT
	testl	%eax, %eax
	jne	.L4
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	errx@PLT
.L4:
	movq	hdl_play@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	sio_close@PLT
	jmp	.L10
.L2:
	movq	state@GOTPCREL(%rip), %rax
	movl	(%rax), %eax
	cmpl	$1, %eax
	jne	.L10
	movq	hdl_capture@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	sio_stop@PLT
	testl	%eax, %eax
	jne	.L8
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	errx@PLT
.L8:
	movq	hdl_capture@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	sio_close@PLT
.L10:
	leave
	ret
.LFE5:
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
.LFB6:
	pushq	%rbp
.LCFI3:
	movq	%rsp, %rbp
.LCFI4:
	subq	$64, %rsp
.LCFI5:
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	%edx, -28(%rbp)
	movl	%ecx, -32(%rbp)
	movq	%r8, -40(%rbp)
	movq	%r9, -48(%rbp)
	movl	16(%rbp), %eax
	movb	%al, -52(%rbp)
	movzbl	-52(%rbp), %edx
	movq	state@GOTPCREL(%rip), %rax
	movl	%edx, (%rax)
	cmpb	$0, -52(%rbp)
	jne	.L12
	movq	par_play@GOTPCREL(%rip), %rdi
	call	sio_initpar@PLT
	movq	par_play@GOTPCREL(%rip), %rdx
	movl	-20(%rbp), %eax
	movl	%eax, 8(%rdx)
	movq	par_play@GOTPCREL(%rip), %rax
	movl	$1, 12(%rax)
	movq	par_play@GOTPCREL(%rip), %rdx
	movl	-24(%rbp), %eax
	movl	%eax, (%rdx)
	movq	par_play@GOTPCREL(%rip), %rdx
	movl	-28(%rbp), %eax
	movl	%eax, 24(%rdx)
	movq	par_play@GOTPCREL(%rip), %rdx
	movl	-32(%rbp), %eax
	movl	%eax, 28(%rdx)
	movq	par_play@GOTPCREL(%rip), %rax
	movl	$0, 36(%rax)
	movq	-40(%rbp), %rdi
	movl	$0, %edx
	movl	$1, %esi
	call	sio_open@PLT
	movq	%rax, %rdx
	movq	hdl_play@GOTPCREL(%rip), %rax
	movq	%rdx, (%rax)
	movq	hdl_play@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L14
	leaq	.LC1(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	errx@PLT
.L14:
	movq	hdl_play@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	movq	par_play@GOTPCREL(%rip), %rsi
	call	sio_setpar@PLT
	testl	%eax, %eax
	jne	.L16
	leaq	.LC2(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	errx@PLT
.L16:
	movq	hdl_play@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	movq	par_play@GOTPCREL(%rip), %rsi
	call	sio_getpar@PLT
	testl	%eax, %eax
	jne	.L18
	leaq	.LC3(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	errx@PLT
.L18:
	movq	hdl_play@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	sio_start@PLT
	testl	%eax, %eax
	jne	.L31
	leaq	.LC4(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	errx@PLT
.L12:
	cmpb	$1, -52(%rbp)
	jne	.L31
	movq	par_capture@GOTPCREL(%rip), %rdi
	call	sio_initpar@PLT
	movq	par_capture@GOTPCREL(%rip), %rdx
	movl	-20(%rbp), %eax
	movl	%eax, 8(%rdx)
	movq	par_capture@GOTPCREL(%rip), %rax
	movl	$1, 12(%rax)
	movq	par_capture@GOTPCREL(%rip), %rdx
	movl	-24(%rbp), %eax
	movl	%eax, (%rdx)
	movq	par_capture@GOTPCREL(%rip), %rdx
	movl	-28(%rbp), %eax
	movl	%eax, 20(%rdx)
	movq	par_capture@GOTPCREL(%rip), %rdx
	movl	-32(%rbp), %eax
	movl	%eax, 28(%rdx)
	movq	par_capture@GOTPCREL(%rip), %rax
	movl	$0, 36(%rax)
	movq	-48(%rbp), %rdi
	movl	$0, %edx
	movl	$2, %esi
	call	sio_open@PLT
	movq	%rax, %rdx
	movq	hdl_capture@GOTPCREL(%rip), %rax
	movq	%rdx, (%rax)
	movq	hdl_capture@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L24
	leaq	.LC1(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	errx@PLT
.L24:
	movq	hdl_capture@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	movq	par_capture@GOTPCREL(%rip), %rsi
	call	sio_setpar@PLT
	testl	%eax, %eax
	jne	.L26
	leaq	.LC2(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	errx@PLT
.L26:
	movq	hdl_capture@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	movq	par_capture@GOTPCREL(%rip), %rsi
	call	sio_getpar@PLT
	testl	%eax, %eax
	jne	.L28
	leaq	.LC3(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	errx@PLT
.L28:
	movq	hdl_capture@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	sio_start@PLT
	testl	%eax, %eax
	jne	.L31
	leaq	.LC4(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	errx@PLT
.L31:
	leave
	ret
.LFE6:
	.size	sio_init, .-sio_init
	.section	.rodata
.LC5:
	.string	"poll(): failed\n"
.LC6:
	.string	"poll(): device disappeared\n"
	.align 16
	.type	.LSSH0, @object
	.size	.LSSH0, 16
.LSSH0:
	.string	"_sio_poll_wait_"
	.text
	.globl	_sio_poll_wait_
	.type	_sio_poll_wait_, @function
_sio_poll_wait_:
.LFB7:
	pushq	%rbp
.LCFI6:
	movq	%rsp, %rbp
.LCFI7:
	subq	$48, %rsp
.LCFI8:
	movq	%rdi, -40(%rbp)
	movq	__guard_local(%rip), %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
.L33:
	leaq	-24(%rbp), %rsi
	movq	-40(%rbp), %rdi
	movl	$4, %edx
	call	sio_pollfd@PLT
	movl	%eax, -12(%rbp)
	cmpl	$0, -12(%rbp)
	jle	.L34
	movl	-12(%rbp), %esi
	leaq	-24(%rbp), %rdi
	movl	$-1, %edx
	call	poll@PLT
	testl	%eax, %eax
	jns	.L34
	leaq	.LC5(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	errx@PLT
.L34:
	leaq	-24(%rbp), %rsi
	movq	-40(%rbp), %rdi
	call	sio_revents@PLT
	movl	%eax, -16(%rbp)
	movl	-16(%rbp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	.L37
	leaq	.LC6(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	errx@PLT
.L37:
	movl	-16(%rbp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L33
	movq	-8(%rbp), %rax
	xorq	__guard_local(%rip), %rax
	je	.L41
	leaq	.LSSH0(%rip), %rdi
	call	__stack_smash_handler@PLT
.L41:
	leave
	ret
.LFE7:
	.size	_sio_poll_wait_, .-_sio_poll_wait_
	.section	.rodata
.LC7:
	.string	"sio_read(): failed\n"
	.text
	.globl	sio_readp
	.type	sio_readp, @function
sio_readp:
.LFB8:
	pushq	%rbp
.LCFI9:
	movq	%rsp, %rbp
.LCFI10:
	subq	$32, %rsp
.LCFI11:
	movq	%rdi, -24(%rbp)
	call	sio_getbufsz@PLT
	movq	%rax, %rdx
	movq	hdl_capture@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	movq	-24(%rbp), %rsi
	call	sio_read@PLT
	movq	%rax, -16(%rbp)
	movq	hdl_capture@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	sio_eof@PLT
	testl	%eax, %eax
	je	.L43
	leaq	.LC7(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	errx@PLT
.L43:
	movq	-16(%rbp), %rax
	leave
	ret
.LFE8:
	.size	sio_readp, .-sio_readp
	.section	.rodata
.LC8:
	.string	"sio_write(): failed\n"
	.text
	.globl	sio_writep
	.type	sio_writep, @function
sio_writep:
.LFB9:
	pushq	%rbp
.LCFI12:
	movq	%rsp, %rbp
.LCFI13:
	subq	$32, %rsp
.LCFI14:
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	hdl_play@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	_sio_poll_wait_
	movq	hdl_play@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rsi
	call	sio_write@PLT
	movl	%eax, -12(%rbp)
	movq	hdl_play@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	sio_eof@PLT
	testl	%eax, %eax
	je	.L47
	leaq	.LC8(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	errx@PLT
.L47:
	movl	-12(%rbp), %eax
	cltq
	leave
	ret
.LFE9:
	.size	sio_writep, .-sio_writep
	.globl	sio_getbufsz
	.type	sio_getbufsz, @function
sio_getbufsz:
.LFB10:
	pushq	%rbp
.LCFI15:
	movq	%rsp, %rbp
.LCFI16:
	movl	$1024, %eax
	leave
	ret
.LFE10:
	.size	sio_getbufsz, .-sio_getbufsz
	.comm	hdl_play,8,8
	.comm	hdl_capture,8,8
	.comm	par_play,64,32
	.comm	par_capture,64,32
	.comm	state,4,4
	.section	.eh_frame,"a",@progbits
.Lframe1:
	.long	.LECIE1-.LSCIE1
.LSCIE1:
	.long	0x0
	.byte	0x1
	.string	"zR"
	.uleb128 0x1
	.sleb128 -8
	.byte	0x10
	.uleb128 0x1
	.byte	0x1b
	.byte	0xc
	.uleb128 0x7
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x1
	.align 8
.LECIE1:
.LSFDE1:
	.long	.LEFDE1-.LASFDE1
.LASFDE1:
	.long	.LASFDE1-.Lframe1
	.long	.LFB5-.
	.long	.LFE5-.LFB5
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI0-.LFB5
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI1-.LCFI0
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE1:
.LSFDE3:
	.long	.LEFDE3-.LASFDE3
.LASFDE3:
	.long	.LASFDE3-.Lframe1
	.long	.LFB6-.
	.long	.LFE6-.LFB6
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI3-.LFB6
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI4-.LCFI3
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE3:
.LSFDE5:
	.long	.LEFDE5-.LASFDE5
.LASFDE5:
	.long	.LASFDE5-.Lframe1
	.long	.LFB7-.
	.long	.LFE7-.LFB7
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI6-.LFB7
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI7-.LCFI6
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE5:
.LSFDE7:
	.long	.LEFDE7-.LASFDE7
.LASFDE7:
	.long	.LASFDE7-.Lframe1
	.long	.LFB8-.
	.long	.LFE8-.LFB8
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI9-.LFB8
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI10-.LCFI9
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE7:
.LSFDE9:
	.long	.LEFDE9-.LASFDE9
.LASFDE9:
	.long	.LASFDE9-.Lframe1
	.long	.LFB9-.
	.long	.LFE9-.LFB9
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI12-.LFB9
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI13-.LCFI12
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE9:
.LSFDE11:
	.long	.LEFDE11-.LASFDE11
.LASFDE11:
	.long	.LASFDE11-.Lframe1
	.long	.LFB10-.
	.long	.LFE10-.LFB10
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI15-.LFB10
	.byte	0xe
	.uleb128 0x10
	.byte	0x86
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI16-.LCFI15
	.byte	0xd
	.uleb128 0x6
	.align 8
.LEFDE11:
