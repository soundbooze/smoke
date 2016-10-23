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
	.type	__func__.3663, @object
	.size	__func__.3663, 12
__func__.3663:
	.string	"server_init"
.LC0:
	.string	"tls_init() failed"
.LC1:
	.string	"tls_server() failed"
.LC2:
	.string	"tls_config_new() failed"
	.align 4
.LC3:
	.string	"unable to set TLS certificate file %s\n"
	.align 4
.LC4:
	.string	"unable to set root CA file %s\n"
	.align 4
.LC5:
	.string	"unable to set TLS key file %s\n"
.LC6:
	.string	"secure"
.LC7:
	.string	"tls_configure() failed: %s\n"
.LC8:
	.string	"socket() failed: %s\n"
	.align 4
.LC9:
	.string	"setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof opt) == 0"
.LC10:
	.string	"server.c"
.LC11:
	.string	"bind()"
.LC12:
	.string	"listen()"
	.align 4
.LC13:
	.string	"[+] Waiting for valid connection\n"
.LC14:
	.string	"accept()"
	.align 4
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
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$132, %esp
	call	__i686.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	12(%ebp), %eax
	movl	%eax, -104(%ebp)
	movl	16(%ebp), %eax
	movl	%eax, -108(%ebp)
	movl	__guard_local@GOTOFF(%ebx), %eax
	movl	%eax, -8(%ebp)
	xorl	%eax, %eax
	movl	$16, -52(%ebp)
	call	blowfish_init@PLT
	movl	%eax, -60(%ebp)
	call	tls_init@PLT
	testl	%eax, %eax
	je	.L2
	leal	.LC0@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	puts@PLT
	movl	$-1, -112(%ebp)
	jmp	.L4
.L2:
	call	tls_server@PLT
	movl	%eax, %edx
	movl	tls@GOT(%ebx), %eax
	movl	%edx, (%eax)
	movl	tls@GOT(%ebx), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	jne	.L5
	leal	.LC1@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	puts@PLT
	movl	$-1, -112(%ebp)
	jmp	.L4
.L5:
	call	tls_config_new@PLT
	movl	%eax, %edx
	movl	tls_config@GOT(%ebx), %eax
	movl	%edx, (%eax)
	movl	tls_config@GOT(%ebx), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	jne	.L7
	leal	.LC2@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	puts@PLT
	movl	$-1, -112(%ebp)
	jmp	.L4
.L7:
	movl	tls_config@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	tls_config_verify_client_optional@PLT
	movl	tls_config@GOT(%ebx), %eax
	movl	(%eax), %edx
	movl	-108(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	tls_config_set_cert_file@PLT
	cmpl	$-1, %eax
	jne	.L9
	movl	-108(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	.LC3@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	printf@PLT
	movl	$-1, -112(%ebp)
	jmp	.L4
.L9:
	movl	tls_config@GOT(%ebx), %eax
	movl	(%eax), %edx
	movl	-108(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	tls_config_set_ca_file@PLT
	cmpl	$-1, %eax
	jne	.L11
	movl	-108(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	.LC4@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	printf@PLT
	movl	$-1, -112(%ebp)
	jmp	.L4
.L11:
	movl	tls_config@GOT(%ebx), %eax
	movl	(%eax), %edx
	movl	-104(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	tls_config_set_key_file@PLT
	cmpl	$-1, %eax
	jne	.L13
	movl	-104(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	.LC5@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	printf@PLT
	movl	$-1, -112(%ebp)
	jmp	.L4
.L13:
	movl	tls_config@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	$14, 4(%esp)
	movl	%eax, (%esp)
	call	tls_config_set_protocols@PLT
	movl	tls_config@GOT(%ebx), %eax
	movl	(%eax), %edx
	leal	.LC6@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	tls_config_set_ciphers@PLT
	movl	tls_config@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	tls_config_insecure_noverifyname@PLT
	movl	tls_config@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	tls_config_insecure_noverifycert@PLT
	movl	tls_config@GOT(%ebx), %eax
	movl	(%eax), %edx
	movl	tls@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	tls_configure@PLT
	testl	%eax, %eax
	je	.L15
	movl	tls@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	tls_error@PLT
	movl	%eax, 4(%esp)
	leal	.LC7@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	printf@PLT
	movl	$-1, -112(%ebp)
	jmp	.L4
.L15:
	movl	$6, 8(%esp)
	movl	$1, 4(%esp)
	movl	$2, (%esp)
	call	socket@PLT
	movl	%eax, %edx
	movl	sockfd@GOT(%ebx), %eax
	movl	%edx, (%eax)
	movl	sockfd@GOT(%ebx), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	jns	.L17
	call	__errno@PLT
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	strerror@PLT
	movl	%eax, 4(%esp)
	leal	.LC8@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	printf@PLT
	movl	$-1, -112(%ebp)
	jmp	.L4
.L17:
	movl	$1, -56(%ebp)
	movl	$16, 4(%esp)
	leal	-80(%ebp), %eax
	movl	%eax, (%esp)
	call	bzero@PLT
	movl	$0, -76(%ebp)
	movb	$2, -79(%ebp)
	movl	8(%ebp), %eax
	movw	%ax, -44(%ebp)
	movzwl	-44(%ebp), %eax
	movw	%ax, -46(%ebp)
	movzwl	-46(%ebp), %eax
#APP
	rorw $8, %ax
#NO_APP
	movw	%ax, -46(%ebp)
	movzwl	-46(%ebp), %eax
	movzwl	%ax, %eax
	movw	%ax, -78(%ebp)
	movl	sockfd@GOT(%ebx), %eax
	movl	(%eax), %edx
	movl	$4, 16(%esp)
	leal	-56(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	$4, 8(%esp)
	movl	$65535, 4(%esp)
	movl	%edx, (%esp)
	call	setsockopt@PLT
	testl	%eax, %eax
	je	.L19
	leal	.LC9@GOTOFF(%ebx), %eax
	movl	%eax, 12(%esp)
	leal	__func__.3663@GOTOFF(%ebx), %eax
	movl	%eax, 8(%esp)
	movl	$110, 4(%esp)
	leal	.LC10@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	__assert2@PLT
.L19:
	leal	-80(%ebp), %edx
	movl	sockfd@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	$16, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	bind@PLT
	testl	%eax, %eax
	jns	.L21
	leal	.LC11@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	perror@PLT
	movl	$-1, -112(%ebp)
	jmp	.L4
.L21:
	movl	sockfd@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	$32, 4(%esp)
	movl	%eax, (%esp)
	call	listen@PLT
	testl	%eax, %eax
	jns	.L23
	leal	.LC12@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	perror@PLT
	movl	$-1, -112(%ebp)
	jmp	.L4
.L23:
	movl	__sF@GOT(%ebx), %eax
	leal	88(%eax), %eax
	movl	%eax, 12(%esp)
	movl	$33, 8(%esp)
	movl	$1, 4(%esp)
	leal	.LC13@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	fwrite@PLT
	leal	-96(%ebp), %edx
	movl	sockfd@GOT(%ebx), %eax
	movl	(%eax), %ecx
	leal	-52(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%ecx, (%esp)
	call	accept@PLT
	movl	%eax, -64(%ebp)
	cmpl	$0, -64(%ebp)
	jns	.L25
	leal	.LC14@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	perror@PLT
.L25:
	movl	tls@GOT(%ebx), %eax
	movl	(%eax), %edx
	movl	-64(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	tls_cctx@GOT(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	tls_accept_socket@PLT
	testl	%eax, %eax
	jns	.L27
	movl	tls@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	tls_error@PLT
	movl	%eax, 4(%esp)
	leal	.LC15@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	printf@PLT
	movl	tls_cctx@GOT(%ebx), %eax
	movl	$0, (%eax)
.L27:
	movl	tls_cctx@GOT(%ebx), %eax
	movl	(%eax), %edx
	movl	$33, 8(%esp)
	leal	-41(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	tls_read@PLT
	testl	%eax, %eax
	jns	.L29
	movl	tls_cctx@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	tls_error@PLT
	movl	%eax, 4(%esp)
	leal	.LC16@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	printf@PLT
.L29:
	movl	-92(%ebp), %eax
	movl	%eax, (%esp)
	call	inet_ntoa@PLT
	movl	%eax, %edx
	movl	__sF@GOT(%ebx), %eax
	leal	88(%eax), %ecx
	movl	%edx, 8(%esp)
	leal	.LC17@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	%ecx, (%esp)
	call	fprintf@PLT
	movl	$33, 8(%esp)
	leal	-41(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L23
	movl	__sF@GOT(%ebx), %eax
	leal	88(%eax), %eax
	movl	%eax, 12(%esp)
	movl	$26, 8(%esp)
	movl	$1, 4(%esp)
	leal	.LC18@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	fwrite@PLT
	movl	$0, -112(%ebp)
.L4:
	movl	-112(%ebp), %eax
	movl	-8(%ebp), %edx
	xorl	__guard_local@GOTOFF(%ebx), %edx
	je	.L34
	leal	.LSSH0@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	__stack_smash_handler@PLT
.L34:
	addl	$132, %esp
	popl	%ebx
	popl	%ebp
	ret
	.size	server_init, .-server_init
	.section	.rodata
.LC19:
	.string	"tls_write failed: %s\n"
	.type	.LSSH1, @object
	.size	.LSSH1, 18
.LSSH1:
	.string	"server_write_loop"
	.text
	.globl	server_write_loop
	.type	server_write_loop, @function
server_write_loop:
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
	call	sio_getbufsz@PLT
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	addl	$15, %eax
	addl	$15, %eax
	shrl	$4, %eax
	sall	$4, %eax
	subl	%eax, %esp
	leal	12(%esp), %eax
	movl	%eax, -44(%ebp)
	movl	-44(%ebp), %eax
	addl	$15, %eax
	shrl	$4, %eax
	sall	$4, %eax
	movl	%eax, -44(%ebp)
	movl	-44(%ebp), %eax
	movl	%eax, -24(%ebp)
.L36:
	movl	-24(%ebp), %eax
	movl	%eax, (%esp)
	call	sio_readp@PLT
	movl	%eax, -16(%ebp)
	movl	-24(%ebp), %edx
	movl	-16(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	blowfish_encrypt@PLT
	movl	-24(%ebp), %edx
	movl	tls_cctx@GOT(%ebx), %eax
	movl	(%eax), %ecx
	movl	-16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%ecx, (%esp)
	call	tls_write@PLT
	movl	%eax, -20(%ebp)
	cmpl	$0, -20(%ebp)
	jns	.L36
	movl	tls_cctx@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	tls_error@PLT
	movl	%eax, 4(%esp)
	leal	.LC19@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	printf@PLT
	jmp	.L36
	.size	server_write_loop, .-server_write_loop
	.globl	server_close
	.type	server_close, @function
server_close:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$20, %esp
	call	__i686.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	tls_cctx@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	tls_close@PLT
	movl	tls_cctx@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	tls_free@PLT
	movl	tls@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	tls_close@PLT
	movl	tls@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	tls_free@PLT
	movl	tls_config@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	tls_config_free@PLT
	addl	$20, %esp
	popl	%ebx
	popl	%ebp
	ret
	.size	server_close, .-server_close
	.comm	tls,4,4
	.comm	tls_cctx,4,4
	.comm	tls_config,4,4
	.comm	sockfd,4,4
	.section	.gnu.linkonce.t.__i686.get_pc_thunk.bx,"ax",@progbits
	.globl	__i686.get_pc_thunk.bx
	.hidden	__i686.get_pc_thunk.bx
	.type	__i686.get_pc_thunk.bx, @function
__i686.get_pc_thunk.bx:
	movl	(%esp), %ebx
	ret
