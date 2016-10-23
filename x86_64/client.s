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

	.file	"client.s"
	.section	.rodata
.LC0:
	.string	"tls_init() failed"
.LC1:
	.string	"tls_client() failed"
.LC2:
	.string	"tls_config_new() failed"
.LC3:
	.string	"tls_configure() failed"
.LC4:
	.string	"error: %s\n"
.LC5:
	.string	"tls_write failed: %s\n"
	.text
	.globl	client_init
	.type	client_init, @function
client_init:
.LFB6:
	pushq	%rbp
.LCFI0:
	movq	%rsp, %rbp
.LCFI1:
	subq	$48, %rsp
.LCFI2:
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	call	blowfish_init@PLT
	movq	%rax, -16(%rbp)
	call	tls_init@PLT
	testl	%eax, %eax
	je	.L2
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	movl	$-1, -36(%rbp)
	jmp	.L4
.L2:
	call	tls_client@PLT
	movq	%rax, %rdx
	movq	tls@GOTPCREL(%rip), %rax
	movq	%rdx, (%rax)
	movq	tls@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L5
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	movl	$-1, -36(%rbp)
	jmp	.L4
.L5:
	call	tls_config_new@PLT
	movq	%rax, %rdx
	movq	tls_config@GOTPCREL(%rip), %rax
	movq	%rdx, (%rax)
	movq	tls_config@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L7
	leaq	.LC2(%rip), %rdi
	call	puts@PLT
	movl	$-1, -36(%rbp)
	jmp	.L4
.L7:
	movq	tls_config@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	tls_config_insecure_noverifycert@PLT
	movq	tls_config@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	tls_config_insecure_noverifyname@PLT
	movq	tls_config@GOTPCREL(%rip), %rax
	movq	(%rax), %rsi
	movq	tls@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	tls_configure@PLT
	testl	%eax, %eax
	je	.L9
	leaq	.LC3(%rip), %rdi
	call	puts@PLT
	movl	$-1, -36(%rbp)
	jmp	.L4
.L9:
	movq	tls@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rsi
	call	tls_connect@PLT
	testl	%eax, %eax
	je	.L11
	movq	tls@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	tls_error@PLT
	movq	%rax, %rsi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$-1, -36(%rbp)
	jmp	.L4
.L11:
	movq	tls@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	movq	-16(%rbp), %rsi
	movl	$33, %edx
	call	tls_write@PLT
	testq	%rax, %rax
	jns	.L13
	movq	tls@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	tls_error@PLT
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L13:
	movl	$0, -36(%rbp)
.L4:
	movl	-36(%rbp), %eax
	leave
	ret
.LFE6:
	.size	client_init, .-client_init
	.section	.rodata
.LC6:
	.string	"tls_read failed: %s\n"
	.align 16
	.type	.LSSH0, @object
	.size	.LSSH0, 17
.LSSH0:
	.string	"client_read_loop"
	.text
	.globl	client_read_loop
	.type	client_read_loop, @function
client_read_loop:
.LFB7:
	pushq	%rbp
.LCFI3:
	movq	%rsp, %rbp
.LCFI4:
	subq	$48, %rsp
.LCFI5:
	movq	%rdi, -40(%rbp)
	movq	__guard_local(%rip), %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	call	sio_getbufsz@PLT
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	addq	$15, %rax
	addq	$15, %rax
	shrq	$4, %rax
	salq	$4, %rax
	subq	%rax, %rsp
	movq	%rsp, -48(%rbp)
	movq	-48(%rbp), %rax
	addq	$15, %rax
	shrq	$4, %rax
	salq	$4, %rax
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	movq	%rax, -32(%rbp)
.L17:
	movq	-32(%rbp), %rsi
	movq	tls@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	movq	-16(%rbp), %rdx
	call	tls_read@PLT
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	jns	.L18
	movq	tls@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	tls_error@PLT
	movq	%rax, %rsi
	leaq	.LC6(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L18:
	movq	-24(%rbp), %rax
	movl	%eax, %esi
	movq	-32(%rbp), %rdi
	call	blowfish_decrypt@PLT
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdi
	call	sio_writep@PLT
	jmp	.L17
.LFE7:
	.size	client_read_loop, .-client_read_loop
	.globl	client_close
	.type	client_close, @function
client_close:
.LFB8:
	pushq	%rbp
.LCFI6:
	movq	%rsp, %rbp
.LCFI7:
	subq	$16, %rsp
.LCFI8:
	movq	tls@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	tls_close@PLT
	movq	tls@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	tls_free@PLT
	movq	tls_config@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	tls_config_free@PLT
	leave
	ret
.LFE8:
	.size	client_close, .-client_close
	.comm	tls,8,8
	.comm	tls_config,8,8
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
	.long	.LFB6-.
	.long	.LFE6-.LFB6
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI0-.LFB6
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
	.long	.LFB7-.
	.long	.LFE7-.LFB7
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI3-.LFB7
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
	.long	.LFB8-.
	.long	.LFE8-.LFB8
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI6-.LFB8
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
