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
	.align 4
.LC0:
	.string	"usage: smoke [-p playback device] [-c capture device] [-x key.pem] [-y cert.pem] [-S server] [-P port]\n"
	.text
	.globl	usage
	.type	usage, @function
usage:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$36, %esp
	call	__i686.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	__sF@GOT(%ebx), %eax
	leal	176(%eax), %eax
	movl	%eax, 12(%esp)
	movl	$103, 8(%esp)
	movl	$1, 4(%esp)
	leal	.LC0@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	fwrite@PLT
	movl	$1, (%esp)
	call	exit@PLT
	.size	usage, .-usage
	.globl	main_signal_handler
	.type	main_signal_handler, @function
main_signal_handler:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$20, %esp
	call	__i686.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	call	sio_close_all@PLT
	leal	pth@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	pthread_exit@PLT
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
	leal	4(%esp), %ecx
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	pushl	%ecx
	subl	$96, %esp
	call	__i686.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	%ecx, -64(%ebp)
	movl	-64(%ebp), %edx
	movl	4(%edx), %eax
	movl	%eax, -60(%ebp)
	movl	__guard_local@GOTOFF(%ebx), %eax
	movl	%eax, -12(%ebp)
	xorl	%eax, %eax
	leal	.LC1@GOTOFF(%ebx), %eax
	movl	%eax, -32(%ebp)
	leal	.LC1@GOTOFF(%ebx), %eax
	movl	%eax, -36(%ebp)
	movl	$0, -40(%ebp)
	movl	$5150, -44(%ebp)
	leal	.LC2@GOTOFF(%ebx), %eax
	movl	%eax, -48(%ebp)
	leal	.LC3@GOTOFF(%ebx), %eax
	movl	%eax, -52(%ebp)
	jmp	.L6
.L7:
	movl	-56(%ebp), %edx
	subl	$80, %edx
	movl	%edx, -68(%ebp)
	cmpl	$41, -68(%ebp)
	ja	.L8
	movl	-68(%ebp), %eax
	sall	$2, %eax
	movl	.L15@GOTOFF(%eax,%ebx), %eax
	movl	%ebx, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	jmp	*%eax
	.p2align 2
	.align 4
.L15:
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L9]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L10]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L11]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L12]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L8]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L13]
	.long	_GLOBAL_OFFSET_TABLE_+[.-.L14]
.L12:
	movl	optarg@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, -32(%ebp)
	jmp	.L6
.L11:
	movl	optarg@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, -36(%ebp)
	jmp	.L6
.L13:
	movl	optarg@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, -48(%ebp)
	jmp	.L6
.L14:
	movl	optarg@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, -52(%ebp)
	jmp	.L6
.L10:
	movl	optarg@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, -40(%ebp)
	jmp	.L6
.L9:
	movl	optarg@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	atoi@PLT
	movl	%eax, -44(%ebp)
	jmp	.L6
.L8:
	call	usage
.L6:
	leal	.LC4@GOTOFF(%ebx), %eax
	movl	%eax, 8(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-64(%ebp), %edx
	movl	(%edx), %eax
	movl	%eax, (%esp)
	call	getopt@PLT
	movl	%eax, -56(%ebp)
	cmpl	$-1, -56(%ebp)
	jne	.L7
	movl	optind@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	-64(%ebp), %edx
	subl	%eax, (%edx)
	movl	optind@GOT(%ebx), %eax
	movl	(%eax), %eax
	sall	$2, %eax
	addl	%eax, -60(%ebp)
	leal	main_signal_handler@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	$2, (%esp)
	call	signal@PLT
	leal	main_signal_handler@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	$15, (%esp)
	call	signal@PLT
	leal	main_signal_handler@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	$3, (%esp)
	call	signal@PLT
	leal	main_signal_handler@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	$9, (%esp)
	call	signal@PLT
	leal	main_signal_handler@GOTOFF(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	$11, (%esp)
	call	signal@PLT
	cmpl	$0, -40(%ebp)
	jne	.L17
	movl	$1, 24(%esp)
	movl	-36(%ebp), %eax
	movl	%eax, 20(%esp)
	movl	-32(%ebp), %eax
	movl	%eax, 16(%esp)
	movl	$44100, 12(%esp)
	movl	$2, 8(%esp)
	movl	$16, 4(%esp)
	movl	$0, (%esp)
	call	sio_init@PLT
	movl	-52(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	-48(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-44(%ebp), %eax
	movl	%eax, (%esp)
	call	server_init@PLT
	cmpl	$-1, %eax
	jne	.L19
	movl	$1, (%esp)
	call	exit@PLT
.L19:
	movl	$0, 12(%esp)
	movl	server_write_loop@GOT(%ebx), %eax
	movl	%eax, 8(%esp)
	movl	$0, 4(%esp)
	leal	pth@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	pthread_create@PLT
	testl	%eax, %eax
	je	.L21
	movl	$23, (%esp)
	call	main_signal_handler
.L21:
	movl	pth@GOTOFF(%ebx), %eax
	movl	$0, 4(%esp)
	movl	%eax, (%esp)
	call	pthread_join@PLT
	jmp	.L23
.L17:
	movl	$0, -28(%ebp)
	movl	$0, -24(%ebp)
	movl	$0, -20(%ebp)
	movl	$0, -16(%ebp)
	movl	-44(%ebp), %eax
	movl	%eax, 12(%esp)
	leal	.LC5@GOTOFF(%ebx), %eax
	movl	%eax, 8(%esp)
	movl	$16, 4(%esp)
	leal	-28(%ebp), %eax
	movl	%eax, (%esp)
	call	snprintf@PLT
	movl	$0, 24(%esp)
	movl	-36(%ebp), %eax
	movl	%eax, 20(%esp)
	movl	-32(%ebp), %eax
	movl	%eax, 16(%esp)
	movl	$44100, 12(%esp)
	movl	$2, 8(%esp)
	movl	$16, 4(%esp)
	movl	$0, (%esp)
	call	sio_init@PLT
	leal	-28(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-40(%ebp), %eax
	movl	%eax, (%esp)
	call	client_init@PLT
	cmpl	$-1, %eax
	jne	.L24
	movl	$1, (%esp)
	call	exit@PLT
.L24:
	movl	$0, 12(%esp)
	movl	client_read_loop@GOT(%ebx), %eax
	movl	%eax, 8(%esp)
	movl	$0, 4(%esp)
	leal	pth@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	pthread_create@PLT
	testl	%eax, %eax
	je	.L26
	movl	$23, (%esp)
	call	main_signal_handler
.L26:
	movl	pth@GOTOFF(%ebx), %eax
	movl	$0, 4(%esp)
	movl	%eax, (%esp)
	call	pthread_join@PLT
.L23:
	movl	$0, %eax
	movl	-12(%ebp), %edx
	xorl	__guard_local@GOTOFF(%ebx), %edx
	je	.L29
	leal	.LSSH0@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	__stack_smash_handler@PLT
.L29:
	addl	$96, %esp
	popl	%ecx
	popl	%ebx
	popl	%ebp
	leal	-4(%ecx), %esp
	ret
	.size	main, .-main
	.local	pth
	.comm	pth,4,4
	.section	.gnu.linkonce.t.__i686.get_pc_thunk.bx,"ax",@progbits
	.globl	__i686.get_pc_thunk.bx
	.hidden	__i686.get_pc_thunk.bx
	.type	__i686.get_pc_thunk.bx, @function
__i686.get_pc_thunk.bx:
	movl	(%esp), %ebx
	ret
