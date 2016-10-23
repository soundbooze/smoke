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
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$36, %esp
	call	__i686.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	call	blowfish_init@PLT
	movl	%eax, -12(%ebp)
	call	tls_init@PLT
	testl	%eax, %eax
	je	.L2
	leal	.LC0@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	puts@PLT
	movl	$-1, -24(%ebp)
	jmp	.L4
.L2:
	call	tls_client@PLT
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
	movl	$-1, -24(%ebp)
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
	movl	$-1, -24(%ebp)
	jmp	.L4
.L7:
	movl	tls_config@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	tls_config_insecure_noverifycert@PLT
	movl	tls_config@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	tls_config_insecure_noverifyname@PLT
	movl	tls_config@GOT(%ebx), %eax
	movl	(%eax), %edx
	movl	tls@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	tls_configure@PLT
	testl	%eax, %eax
	je	.L9
	leal	.LC3@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	puts@PLT
	movl	$-1, -24(%ebp)
	jmp	.L4
.L9:
	movl	tls@GOT(%ebx), %eax
	movl	(%eax), %edx
	movl	12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	tls_connect@PLT
	testl	%eax, %eax
	je	.L11
	movl	tls@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	tls_error@PLT
	movl	%eax, 4(%esp)
	leal	.LC4@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	printf@PLT
	movl	$-1, -24(%ebp)
	jmp	.L4
.L11:
	movl	tls@GOT(%ebx), %eax
	movl	(%eax), %edx
	movl	$33, 8(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	tls_write@PLT
	testl	%eax, %eax
	jns	.L13
	movl	tls@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	tls_error@PLT
	movl	%eax, 4(%esp)
	leal	.LC5@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	printf@PLT
.L13:
	movl	$0, -24(%ebp)
.L4:
	movl	-24(%ebp), %eax
	addl	$36, %esp
	popl	%ebx
	popl	%ebp
	ret
	.size	client_init, .-client_init
	.section	.rodata
.LC6:
	.string	"tls_read failed: %s\n"
	.type	.LSSH0, @object
	.size	.LSSH0, 17
.LSSH0:
	.string	"client_read_loop"
	.text
	.globl	client_read_loop
	.type	client_read_loop, @function
client_read_loop:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$36, %esp
	call	__i686.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	8(%ebp), %eax
	movl	%eax, -24(%ebp)
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
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	addl	$15, %eax
	shrl	$4, %eax
	sall	$4, %eax
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, -20(%ebp)
.L17:
	movl	-20(%ebp), %edx
	movl	tls@GOT(%ebx), %eax
	movl	(%eax), %ecx
	movl	-12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%ecx, (%esp)
	call	tls_read@PLT
	movl	%eax, -16(%ebp)
	cmpl	$0, -16(%ebp)
	jns	.L18
	movl	tls@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	tls_error@PLT
	movl	%eax, 4(%esp)
	leal	.LC6@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	printf@PLT
.L18:
	movl	-16(%ebp), %eax
	movl	-20(%ebp), %edx
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	blowfish_decrypt@PLT
	movl	-16(%ebp), %eax
	movl	-20(%ebp), %edx
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	sio_writep@PLT
	jmp	.L17
	.size	client_read_loop, .-client_read_loop
	.globl	client_close
	.type	client_close, @function
client_close:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$20, %esp
	call	__i686.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
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
	.size	client_close, .-client_close
	.comm	tls,4,4
	.comm	tls_config,4,4
	.section	.gnu.linkonce.t.__i686.get_pc_thunk.bx,"ax",@progbits
	.globl	__i686.get_pc_thunk.bx
	.hidden	__i686.get_pc_thunk.bx
	.type	__i686.get_pc_thunk.bx, @function
__i686.get_pc_thunk.bx:
	movl	(%esp), %ebx
	ret
