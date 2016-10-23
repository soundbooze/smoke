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

	.file	"blowfish.s"
	.section	.rodata
.LC0:
	.string	"Blowfish Password: "
	.text
	.globl	blowfish_init
	.type	blowfish_init, @function
blowfish_init:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$36, %esp
	call	__i686.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	ctx@GOT(%ebx), %eax
	movl	%eax, (%esp)
	call	Blowfish_initstate@PLT
	leal	.LC0@GOTOFF(%ebx), %eax
	movl	%eax, (%esp)
	call	getpass@PLT
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	strlen@PLT
	movzwl	%ax, %eax
	movl	-12(%ebp), %edx
	movl	%eax, 8(%esp)
	movl	%edx, 4(%esp)
	movl	ctx@GOT(%ebx), %eax
	movl	%eax, (%esp)
	call	blf_key@PLT
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	strlen@PLT
	movl	-12(%ebp), %edx
	movl	$0, 8(%esp)
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	MD5Data@PLT
	addl	$36, %esp
	popl	%ebx
	popl	%ebp
	ret
	.size	blowfish_init, .-blowfish_init
	.globl	blowfish_encrypt
	.type	blowfish_encrypt, @function
blowfish_encrypt:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$36, %esp
	call	__i686.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	ctx@GOT(%ebx), %eax
	movl	%eax, (%esp)
	call	blf_ecb_encrypt@PLT
	movl	12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	ctx@GOT(%ebx), %eax
	movl	%eax, (%esp)
	call	blf_ecb_encrypt@PLT
	movl	12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	ctx@GOT(%ebx), %eax
	movl	%eax, (%esp)
	call	blf_ecb_encrypt@PLT
	movl	12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	ctx@GOT(%ebx), %eax
	movl	%eax, (%esp)
	call	blf_ecb_encrypt@PLT
	addl	$36, %esp
	popl	%ebx
	popl	%ebp
	ret
	.size	blowfish_encrypt, .-blowfish_encrypt
	.globl	blowfish_decrypt
	.type	blowfish_decrypt, @function
blowfish_decrypt:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$36, %esp
	call	__i686.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	ctx@GOT(%ebx), %eax
	movl	%eax, (%esp)
	call	blf_ecb_decrypt@PLT
	movl	12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	ctx@GOT(%ebx), %eax
	movl	%eax, (%esp)
	call	blf_ecb_decrypt@PLT
	movl	12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	ctx@GOT(%ebx), %eax
	movl	%eax, (%esp)
	call	blf_ecb_decrypt@PLT
	movl	12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	ctx@GOT(%ebx), %eax
	movl	%eax, (%esp)
	call	blf_ecb_decrypt@PLT
	addl	$36, %esp
	popl	%ebx
	popl	%ebp
	ret
	.size	blowfish_decrypt, .-blowfish_decrypt
	.comm	ctx,4168,32
	.section	.gnu.linkonce.t.__i686.get_pc_thunk.bx,"ax",@progbits
	.globl	__i686.get_pc_thunk.bx
	.hidden	__i686.get_pc_thunk.bx
	.type	__i686.get_pc_thunk.bx, @function
__i686.get_pc_thunk.bx:
	movl	(%esp), %ebx
	ret
