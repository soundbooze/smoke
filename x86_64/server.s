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

	.file	"server.s"
	.section	.rodata
	.type	__func__.4010, @object
	.size	__func__.4010, 12
__func__.4010:
	.string	"server_init"
.LC0:
	.string	"tls_init() failed"
.LC1:
	.string	"tls_server() failed"
.LC2:
	.string	"tls_config_new() failed"
	.align 8
.LC3:
	.string	"unable to set TLS certificate file %s\n"
	.align 8
.LC4:
	.string	"unable to set root CA file %s\n"
	.align 8
.LC5:
	.string	"unable to set TLS key file %s\n"
.LC6:
	.string	"secure"
.LC7:
	.string	"tls_configure() failed: %s\n"
.LC8:
	.string	"socket() failed: %s\n"
	.align 8
.LC9:
	.string	"setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof opt) == 0"
.LC10:
	.string	"server.c"
.LC11:
	.string	"bind()"
.LC12:
	.string	"listen()"
	.align 8
.LC13:
	.string	"[+] Waiting for valid connection\n"
.LC14:
	.string	"accept()"
	.align 8
.LC15:
	.string	"tls_accept_socket() failed: %s\n"
.LC16:
	.string	"tls_read failed: %s\n"
.LC17:
	.string	"[+] Authentication (%s)\n"
.LC18:
	.string	"[+] Starting conversation\n"
	.type	.LSSH0, @object
	.size	.LSSH0, 12
.LSSH0:
	.string	"server_init"
	.text
	.globl	server_init
	.type	server_init, @function
server_init:
.LFB6:
	pushq	%rbp
.LCFI0:
	movq	%rsp, %rbp
.LCFI1:
	subq	$144, %rsp
.LCFI2:
	movl	%edi, -116(%rbp)
	movq	%rsi, -128(%rbp)
	movq	%rdx, -136(%rbp)
	movq	__guard_local(%rip), %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$16, -56(%rbp)
	call	blowfish_init@PLT
	movq	%rax, -72(%rbp)
	call	tls_init@PLT
	testl	%eax, %eax
	je	.L2
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	movl	$-1, -140(%rbp)
	jmp	.L4
.L2:
	call	tls_server@PLT
	movq	%rax, %rdx
	movq	tls@GOTPCREL(%rip), %rax
	movq	%rdx, (%rax)
	movq	tls@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L5
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	movl	$-1, -140(%rbp)
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
	movl	$-1, -140(%rbp)
	jmp	.L4
.L7:
	movq	tls_config@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	tls_config_verify_client_optional@PLT
	movq	tls_config@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	movq	-136(%rbp), %rsi
	call	tls_config_set_cert_file@PLT
	cmpl	$-1, %eax
	jne	.L9
	movq	-136(%rbp), %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$-1, -140(%rbp)
	jmp	.L4
.L9:
	movq	tls_config@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	movq	-136(%rbp), %rsi
	call	tls_config_set_ca_file@PLT
	cmpl	$-1, %eax
	jne	.L11
	movq	-136(%rbp), %rsi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$-1, -140(%rbp)
	jmp	.L4
.L11:
	movq	tls_config@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	movq	-128(%rbp), %rsi
	call	tls_config_set_key_file@PLT
	cmpl	$-1, %eax
	jne	.L13
	movq	-128(%rbp), %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$-1, -140(%rbp)
	jmp	.L4
.L13:
	movq	tls_config@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	movl	$14, %esi
	call	tls_config_set_protocols@PLT
	movq	tls_config@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	leaq	.LC6(%rip), %rsi
	call	tls_config_set_ciphers@PLT
	movq	tls_config@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	tls_config_insecure_noverifyname@PLT
	movq	tls_config@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	tls_config_insecure_noverifycert@PLT
	movq	tls_config@GOTPCREL(%rip), %rax
	movq	(%rax), %rsi
	movq	tls@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	tls_configure@PLT
	testl	%eax, %eax
	je	.L15
	movq	tls@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	tls_error@PLT
	movq	%rax, %rsi
	leaq	.LC7(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$-1, -140(%rbp)
	jmp	.L4
.L15:
	movl	$6, %edx
	movl	$1, %esi
	movl	$2, %edi
	call	socket@PLT
	movl	%eax, %edx
	movq	sockfd@GOTPCREL(%rip), %rax
	movl	%edx, (%rax)
	movq	sockfd@GOTPCREL(%rip), %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	jns	.L17
	call	__errno@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%rax, %rsi
	leaq	.LC8(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$-1, -140(%rbp)
	jmp	.L4
.L17:
	movl	$1, -60(%rbp)
	leaq	-96(%rbp), %rdi
	movl	$16, %esi
	call	bzero@PLT
	movl	$0, -92(%rbp)
	movb	$2, -95(%rbp)
	movl	-116(%rbp), %eax
	movw	%ax, -50(%rbp)
	movzwl	-50(%rbp), %eax
	movw	%ax, -52(%rbp)
	movzwl	-52(%rbp), %eax
#APP
	rorw $8, %ax
#NO_APP
	movw	%ax, -52(%rbp)
	movzwl	-52(%rbp), %eax
	movzwl	%ax, %eax
	movw	%ax, -94(%rbp)
	movq	sockfd@GOTPCREL(%rip), %rax
	movl	(%rax), %edi
	leaq	-60(%rbp), %rcx
	movl	$4, %r8d
	movl	$4, %edx
	movl	$65535, %esi
	call	setsockopt@PLT
	testl	%eax, %eax
	je	.L19
	leaq	.LC9(%rip), %rcx
	leaq	__func__.4010(%rip), %rdx
	movl	$110, %esi
	leaq	.LC10(%rip), %rdi
	call	__assert2@PLT
.L19:
	leaq	-96(%rbp), %rsi
	movq	sockfd@GOTPCREL(%rip), %rax
	movl	(%rax), %edi
	movl	$16, %edx
	call	bind@PLT
	testl	%eax, %eax
	jns	.L21
	leaq	.LC11(%rip), %rdi
	call	perror@PLT
	movl	$-1, -140(%rbp)
	jmp	.L4
.L21:
	movq	sockfd@GOTPCREL(%rip), %rax
	movl	(%rax), %edi
	movl	$32, %esi
	call	listen@PLT
	testl	%eax, %eax
	jns	.L23
	leaq	.LC12(%rip), %rdi
	call	perror@PLT
	movl	$-1, -140(%rbp)
	jmp	.L4
.L23:
	movq	__sF@GOTPCREL(%rip), %rax
	leaq	152(%rax), %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC13(%rip), %rdi
	call	fwrite@PLT
	leaq	-112(%rbp), %rsi
	movq	sockfd@GOTPCREL(%rip), %rax
	movl	(%rax), %edi
	leaq	-56(%rbp), %rdx
	call	accept@PLT
	movl	%eax, -64(%rbp)
	cmpl	$0, -64(%rbp)
	jns	.L25
	leaq	.LC14(%rip), %rdi
	call	perror@PLT
.L25:
	movq	tls@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	movl	-64(%rbp), %edx
	movq	tls_cctx@GOTPCREL(%rip), %rsi
	call	tls_accept_socket@PLT
	testl	%eax, %eax
	jns	.L27
	movq	tls@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	tls_error@PLT
	movq	%rax, %rsi
	leaq	.LC15(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	tls_cctx@GOTPCREL(%rip), %rax
	movq	$0, (%rax)
.L27:
	movq	tls_cctx@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	leaq	-48(%rbp), %rsi
	movl	$33, %edx
	call	tls_read@PLT
	testq	%rax, %rax
	jns	.L29
	movq	tls_cctx@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	tls_error@PLT
	movq	%rax, %rsi
	leaq	.LC16(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L29:
	movl	-108(%rbp), %edi
	call	inet_ntoa@PLT
	movq	%rax, %rdx
	movq	__sF@GOTPCREL(%rip), %rax
	leaq	152(%rax), %rdi
	leaq	.LC17(%rip), %rsi
	movl	$0, %eax
	call	fprintf@PLT
	leaq	-48(%rbp), %rsi
	movq	-72(%rbp), %rdi
	movl	$33, %edx
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L23
	movq	__sF@GOTPCREL(%rip), %rax
	leaq	152(%rax), %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC18(%rip), %rdi
	call	fwrite@PLT
	movl	$0, -140(%rbp)
.L4:
	movl	-140(%rbp), %eax
	movq	-8(%rbp), %rdx
	xorq	__guard_local(%rip), %rdx
	je	.L34
	leaq	.LSSH0(%rip), %rdi
	call	__stack_smash_handler@PLT
.L34:
	leave
	ret
.LFE6:
	.size	server_init, .-server_init
	.section	.rodata
.LC19:
	.string	"tls_write failed: %s\n"
	.align 16
	.type	.LSSH1, @object
	.size	.LSSH1, 18
.LSSH1:
	.string	"server_write_loop"
	.text
	.globl	server_write_loop
	.type	server_write_loop, @function
server_write_loop:
.LFB7:
	pushq	%rbp
.LCFI3:
	movq	%rsp, %rbp
.LCFI4:
	subq	$64, %rsp
.LCFI5:
	movq	%rdi, -56(%rbp)
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
	movq	%rsp, -64(%rbp)
	movq	-64(%rbp), %rax
	addq	$15, %rax
	shrq	$4, %rax
	salq	$4, %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	movq	%rax, -40(%rbp)
.L36:
	movq	-40(%rbp), %rdi
	call	sio_readp@PLT
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movl	%eax, %esi
	movq	-40(%rbp), %rdi
	call	blowfish_encrypt@PLT
	movq	-40(%rbp), %rsi
	movq	tls_cctx@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	movq	-24(%rbp), %rdx
	call	tls_write@PLT
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jns	.L36
	movq	tls_cctx@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	tls_error@PLT
	movq	%rax, %rsi
	leaq	.LC19(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L36
.LFE7:
	.size	server_write_loop, .-server_write_loop
	.globl	server_close
	.type	server_close, @function
server_close:
.LFB8:
	pushq	%rbp
.LCFI6:
	movq	%rsp, %rbp
.LCFI7:
	subq	$16, %rsp
.LCFI8:
	movq	tls_cctx@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	tls_close@PLT
	movq	tls_cctx@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	call	tls_free@PLT
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
	.size	server_close, .-server_close
	.comm	tls,8,8
	.comm	tls_cctx,8,8
	.comm	tls_config,8,8
	.comm	sockfd,4,4
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
