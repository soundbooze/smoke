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
.LFB6:
	pushq	%rbp
.LCFI0:
	movq	%rsp, %rbp
.LCFI1:
	subq	$16, %rsp
.LCFI2:
	movq	ctx@GOTPCREL(%rip), %rdi
	call	Blowfish_initstate@PLT
	leaq	.LC0(%rip), %rdi
	call	getpass@PLT
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rdi
	call	strlen@PLT
	movzwl	%ax, %edx
	movq	-16(%rbp), %rsi
	movq	ctx@GOTPCREL(%rip), %rdi
	call	blf_key@PLT
	movq	-16(%rbp), %rdi
	call	strlen@PLT
	movq	%rax, %rsi
	movq	-16(%rbp), %rdi
	movl	$0, %edx
	call	MD5Data@PLT
	leave
	ret
.LFE6:
	.size	blowfish_init, .-blowfish_init
	.globl	blowfish_encrypt
	.type	blowfish_encrypt, @function
blowfish_encrypt:
.LFB7:
	pushq	%rbp
.LCFI3:
	movq	%rsp, %rbp
.LCFI4:
	subq	$32, %rsp
.LCFI5:
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	-28(%rbp), %edx
	movq	-24(%rbp), %rsi
	movq	ctx@GOTPCREL(%rip), %rdi
	call	blf_ecb_encrypt@PLT
	movl	-28(%rbp), %edx
	movq	-24(%rbp), %rsi
	movq	ctx@GOTPCREL(%rip), %rdi
	call	blf_ecb_encrypt@PLT
	movl	-28(%rbp), %edx
	movq	-24(%rbp), %rsi
	movq	ctx@GOTPCREL(%rip), %rdi
	call	blf_ecb_encrypt@PLT
	movl	-28(%rbp), %edx
	movq	-24(%rbp), %rsi
	movq	ctx@GOTPCREL(%rip), %rdi
	call	blf_ecb_encrypt@PLT
	leave
	ret
.LFE7:
	.size	blowfish_encrypt, .-blowfish_encrypt
	.globl	blowfish_decrypt
	.type	blowfish_decrypt, @function
blowfish_decrypt:
.LFB8:
	pushq	%rbp
.LCFI6:
	movq	%rsp, %rbp
.LCFI7:
	subq	$32, %rsp
.LCFI8:
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	-28(%rbp), %edx
	movq	-24(%rbp), %rsi
	movq	ctx@GOTPCREL(%rip), %rdi
	call	blf_ecb_decrypt@PLT
	movl	-28(%rbp), %edx
	movq	-24(%rbp), %rsi
	movq	ctx@GOTPCREL(%rip), %rdi
	call	blf_ecb_decrypt@PLT
	movl	-28(%rbp), %edx
	movq	-24(%rbp), %rsi
	movq	ctx@GOTPCREL(%rip), %rdi
	call	blf_ecb_decrypt@PLT
	movl	-28(%rbp), %edx
	movq	-24(%rbp), %rsi
	movq	ctx@GOTPCREL(%rip), %rdi
	call	blf_ecb_decrypt@PLT
	leave
	ret
.LFE8:
	.size	blowfish_decrypt, .-blowfish_decrypt
	.comm	ctx,4168,32
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
