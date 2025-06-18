

SECTION "Header", ROM0[$100]
    NOP ;if this isnt here the header is shifted one byte and doesnt work anymore
    jp EntryPoint
Logo:
    db $CE,$ED,$66,$66,$CC,$0D,$00,$0B,$03,$73,$00,$83,$00,$0C,$00,$0D,$00,$08,$11,$1F,$88,$89,$00,$0E,$DC,$CC,$6E,$E6,$DD,$DD,$D9,$99
    db $BB,$BB,$67,$63,$6E,$0E,$EC,$CC,$DD,$DC,$99,$9F,$BB,$B9,$33,$3E
Header:
    ;title
    db $41,$4e,$49,$4D ;A,N,I,M
    db $4f,$52,$50,$48 ;O,R,P,H
    db $53,$00,$00 ;S,00,00
    ;manufacturer
    db $42,$41,$4d,$45 ;B,A,M,E
    ;cgb flag
    db $C0
    ;new licensee
    db $34,$31
    ;sgb flag
    db $0
    ;cart type
    db $19
    ;size 1MB
    db $05
    ;ram size NONE
    db $00
    ;region
    db $01
    ;old liscencee
    db $33
    ;mask rom version
    db $00
    ;header check
    db $AA
    ;global check
    db $26,$90
EntryPoint:
    di
    cp $11
    jr Z,SetSpeed
    call $0623
    NOP
    NOP
SetSpeed:
    ldh A,[$ff4d]
    cp $80
    jr Z,VirtualRam
    ld A,$01
    ldh [$ff4d],A ;ff4d = KEY1
    xor A
    ldh [$ff0f],A ;ff0f = IF
    ldh [$ffff],A 
    ld A,$30
    ldh [$ff00],A ;ff00 = P1
    STOP
VirtualRam:
    ld sp,$cffe
    call $029d
    ld A,$67
    ldh [$ff40],A ;ff40 = LCDC
    xor A
    ldh [$ffff],A 
    ldh [$ff0f],A ;ff0f = IF
    ldh [$ff43],A ;ff43 = SCX
    ldh [$ff42],A ;ff42 = SCY
    ldh [$ff41],A ; ff41 = STAT
    ldh [$ff4f],A ; ff4f = VBK
    ldh [$ff70],A ; ff70 = SVBK
    ldh [$ff56],A ; ff56 = RP
    ldh [$ff24],A ; ff24 = NR50
    ld [$1666],A
    ld [$3666],A
    inc A
    ld [$4666],A
    xor A

SECTION "rom3f", ROMX,BANK[$4000]