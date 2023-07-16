[bits 16]

switch_to_pm:
   
    cli                 ;switching off the interrupts

    lgdt [gdt_descriptor]  ;loading the gdt

    mov eax, cr0        ;setting the first bit of cr0 register to switch to 
    or eax, 0x1         ;protected mode
    mov cr0, eax

    jmp CODE_SEG:init_pm

    [bits 32]

    ;init the stack and registers in PM

init_pm:

        mov ax,DATA_SEG
        mov ds,ax
        mov ss,ax
        mov es,ax
        mov fs,ax
        mov gs,ax

        mov ebp,0x9000
        mov esp,ebp

        call BEGIN_PM

