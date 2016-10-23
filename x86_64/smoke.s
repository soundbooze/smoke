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

	.file	"smoke.s"
	.section	.rodata
	.align 8
.LC0:
	.string	"usage: smoke [-p playback device] [-c capture device] [-x key.pem] [-y cert.pem] [-S server] [-P port]\n"
	.text
	.globl	usage
	.type	usage, @function
usage:
.LFB11:
	pushq	%rbp
.LCFI0:
	movq	%rsp, %rbp
.LCFI1:
	subq	$16, %rsp
.LCFI2:
	movq	__sF@GOTPCREL(%rip), %rax
	leaq	304(%rax), %rcx
	movl	$103, %edx
	movl	$1, %esi
	leaq	.LC0(%rip), %rdi
	call	fwrite@PLT
	movl	$1, %edi
	call	exit@PLT
.LFE11:
	.size	usage, .-usage
	.globl	main_signal_handler
	.type	main_signal_handler, @function
main_signal_handler:
.LFB12:
	pushq	%rbp
.LCFI3:
	movq	%rsp, %rbp
.LCFI4:
	subq	$32, %rsp
.LCFI5:
	movl	%edi, -20(%rbp)
	call	sio_close_all@PLT
	leaq	pth(%rip), %rdi
	call	pthread_exit@PLT
.LFE12:
	.size	main_signal_handler, .-main_signal_handler
	.section	.rodata
.LC1:
	.string	"default"
.LC2:
	.string	"cert/smokekey.pem"
.LC3:
	.string	"cert/smokecert.pem"
.LC4:
	.string	"p:c:x:y:S:P:h"
.LC5:
	.string	"%d"
	.type	.LSSH0, @object
	.size	.LSSH0, 5
.LSSH0:
	.string	"main"
	.text
	.globl	main
	.type	main, @function
main:
.LFB13:
	pushq	%rbp
.LCFI6:
	movq	%rsp, %rbp
.LCFI7:
	addq	$-128, %rsp
.LCFI8:
	movl	%edi, -84(%rbp)
	movq	%rsi, -96(%rbp)
	movq	__guard_local(%rip), %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	.LC1(%rip), %rax
	movq	%rax, -48(%rbp)
	leaq	.LC1(%rip), %rax
	movq	%rax, -56(%rbp)
	movq	$0, -64(%rbp)
	movl	$5150, -36(%rbp)
	leaq	.LC2(%rip), %rax
	movq	%rax, -72(%rbp)
	leaq	.LC3(%rip), %rax
	movq	%rax, -80(%rbp)
	jmp	.L6
.L7:
	movl	-40(%rbp), %edx
	subl	$80, %edx
	movl	%edx, -100(%rbp)
	cmpl	$41, -100(%rbp)
	ja	.L8
	mov	-100(%rbp), %eax
	leaq	0(,%rax,4), %rdx
	leaq	.L15(%rip), %rax
	movl	(%rdx,%rax), %eax
	movslq	%eax,%rdx
	leaq	.L15(%rip), %rax
	leaq	(%rdx,%rax), %rax
	jmp	*%rax
	.p2align 2
	.align 4
.L15:
	.long	.L9-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L10-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L11-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L12-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L8-.L15
	.long	.L13-.L15
	.long	.L14-.L15
.L12:
	movq	optarg@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -48(%rbp)
	jmp	.L6
.L11:
	movq	optarg@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	jmp	.L6
.L13:
	movq	optarg@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -72(%rbp)
	jmp	.L6
.L14:
	movq	optarg@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -80(%rbp)
	jmp	.L6
.L10:
	movq	optarg@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -64(%rbp)
	jmp	.L6
.L9:
	movq	optarg@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	atoi@PLT
	movl	%eax, -36(%rbp)
	jmp	.L6
.L8:
	call	usage
.L6:
	movq	-96(%rbp), %rsi
	movl	-84(%rbp), %edi
	leaq	.LC4(%rip), %rdx
	call	getopt@PLT
	movl	%eax, -40(%rbp)
	cmpl	$-1, -40(%rbp)
	jne	.L7
	movq	optind@GOTPCREL(%rip), %rax
	movl	(%rax), %eax
	subl	%eax, -84(%rbp)
	movq	optind@GOTPCREL(%rip), %rax
	movl	(%rax), %eax
	cltq
	salq	$3, %rax
	addq	%rax, -96(%rbp)
	leaq	main_signal_handler(%rip), %rsi
	movl	$2, %edi
	call	signal@PLT
	leaq	main_signal_handler(%rip), %rsi
	movl	$15, %edi
	call	signal@PLT
	leaq	main_signal_handler(%rip), %rsi
	movl	$3, %edi
	call	signal@PLT
	leaq	main_signal_handler(%rip), %rsi
	movl	$9, %edi
	call	signal@PLT
	leaq	main_signal_handler(%rip), %rsi
	movl	$11, %edi
	call	signal@PLT
	cmpq	$0, -64(%rbp)
	jne	.L17
	movq	-56(%rbp), %rax
	movq	-48(%rbp), %rdx
	movl	$1, (%rsp)
	movq	%rax, %r9
	movq	%rdx, %r8
	movl	$44100, %ecx
	movl	$2, %edx
	movl	$16, %esi
	movl	$0, %edi
	call	sio_init@PLT
	movq	-80(%rbp), %rdx
	movq	-72(%rbp), %rsi
	movl	-36(%rbp), %edi
	call	server_init@PLT
	cmpl	$-1, %eax
	jne	.L19
	movl	$1, %edi
	call	exit@PLT
.L19:
	movl	$0, %ecx
	movq	server_write_loop@GOTPCREL(%rip), %rdx
	movl	$0, %esi
	leaq	pth(%rip), %rdi
	call	pthread_create@PLT
	testl	%eax, %eax
	je	.L21
	movl	$23, %edi
	call	main_signal_handler
.L21:
	movq	pth(%rip), %rdi
	movl	$0, %esi
	call	pthread_join@PLT
	jmp	.L23
.L17:
	movq	$0, -32(%rbp)
	movq	$0, -24(%rbp)
	movl	-36(%rbp), %ecx
	leaq	-32(%rbp), %rdi
	leaq	.LC5(%rip), %rdx
	movl	$16, %esi
	movl	$0, %eax
	call	snprintf@PLT
	movq	-56(%rbp), %rax
	movq	-48(%rbp), %rdx
	movl	$0, (%rsp)
	movq	%rax, %r9
	movq	%rdx, %r8
	movl	$44100, %ecx
	movl	$2, %edx
	movl	$16, %esi
	movl	$0, %edi
	call	sio_init@PLT
	leaq	-32(%rbp), %rsi
	movq	-64(%rbp), %rdi
	call	client_init@PLT
	cmpl	$-1, %eax
	jne	.L24
	movl	$1, %edi
	call	exit@PLT
.L24:
	movl	$0, %ecx
	movq	client_read_loop@GOTPCREL(%rip), %rdx
	movl	$0, %esi
	leaq	pth(%rip), %rdi
	call	pthread_create@PLT
	testl	%eax, %eax
	je	.L26
	movl	$23, %edi
	call	main_signal_handler
.L26:
	movq	pth(%rip), %rdi
	movl	$0, %esi
	call	pthread_join@PLT
.L23:
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	xorq	__guard_local(%rip), %rdx
	je	.L29
	leaq	.LSSH0(%rip), %rdi
	call	__stack_smash_handler@PLT
.L29:
	leave
	ret
.LFE13:
	.size	main, .-main
	.local	pth
	.comm	pth,8,8
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
	.long	.LFB11-.
	.long	.LFE11-.LFB11
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI0-.LFB11
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
	.long	.LFB12-.
	.long	.LFE12-.LFB12
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI3-.LFB12
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
	.long	.LFB13-.
	.long	.LFE13-.LFB13
	.uleb128 0x0
	.byte	0x4
	.long	.LCFI6-.LFB13
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
