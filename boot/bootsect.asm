; boot sector with 32 bit protected mode



[org 0x7c00]

KERNEL_OFFSET equ 0x1000   ;setting the off set where we will store our kernel

mov [BOOT_DRIVE] ,dl   ; bios stores to b



mov bp, 0x9000    ;  initialising the stack
mov sp,bp

mov bx,MSG_REAL_MODE 
call print_string

call load_kernel

call switch_to_pm   ;  never returning from here

jmp $

%include "boot/print/print_string.asm"
%include "boot/print/print_string_pm.asm"
%include "boot/gdt.asm"
%include "boot/switch_to_pm.asm"
%include "boot/disk_load.asm"


[bits 16]


load_kernel:
    mov bx,MSG_LOAD_KERNEL   ;printing that we are loading
    call print_string

    mov bx , KERNEL_OFFSET      ; Set -up parameters for our disk_load routine , so
    mov dh , 15               ; that we load the first 15 sectors ( excluding
    mov dl , [BOOT_DRIVE]     ; the boot sector ) from the boot disk 
                                ;( i.e. our kernel code ) to address KERNEL_OFFSET
    
    call disk_load              
    
    ret



[bits 32]

;after switch is complete we land here

BEGIN_PM:
    
    mov ebx,MSG_PROT_MODE
    call print_string_pm
        

    call KERNEL_OFFSET


    mov ebx,test_msg
    call print_string_pm

    jmp $  ;hang here after loading the system

;some of the global variables

BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16 - bit Real Mode" , 0
MSG_PROT_MODE db "Successfully landed in 32 - bit Protected Mode" , 0
MSG_LOAD_KERNEL db "Loading Kernel into memory...." , 0

test_msg db "main was executed",0

; Boot sector padding

times 510-($-$$) db 0
dw 0xaa55
