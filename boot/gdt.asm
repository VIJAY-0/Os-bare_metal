gdt_start:


    gdt_null:
        dd 0x00 ; define double word  (4 bytes)
        dd 0x00

    gdt_code: ;the code segment descriptor  

        ;base = 0x0  4 bits
        ;limit = 0xfffff  20 bits
        ;1st flag : present 1    privilege 00   descriptor type 1   1001b
        ;typeflags   code 1    conforming 0    readable  1     accessed 0   1010b
        ;2nd flags: grannularity 1   (32-bit default) 1    64-bit segment  0   AVL  0    1100b

        dw 0xffff       ; Limit (0-15) 16 bits
        dw 0x0          ; Base ( bits 0 -15)
        db 0x0          ; Base ( bits 16 -23)
        db 10011010b    ; 1st flags , type flags
        db 11001111b    ; 2nd flags , Limit ( bits 16 -19)
        db 0x0          ; Base ( bits 24 -31)
    gdt_data:
        
        dw 0xffff       ; Limit (0-15) 16 bits
        dw 0x0          ; Base ( bits 0 -15)
        db 0x0          ; Base ( bits 16 -23)
        db 10010010b    ; 1st flags , type flags
        db 11001111b    ; 2nd flags , Limit ( bits 16 -19)
        db 0x0          ; Base ( bits 24 -31)
    gdt_end:

    gdt_descriptor:
        dw gdt_end - gdt_start -1   ;always less 1
        dd gdt_start  ;start address of GDT


    CODE_SEG equ gdt_code - gdt_start
    DATA_SEG equ gdt_data - gdt_start

    


