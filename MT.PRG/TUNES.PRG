*---------------------------------------------------------*
procedure Tune
parameters Y1,X1,Y2,X2
private otwet,old_color
old_color = setcolor()
save screen to OnePage
set color to &cfr
BoxTenj(Y1,X1,Y2,X2,ibox)
set color to &cl
MSG=' Н А С Т Р О Й К А '
@ Y1,int((X1+X2)/2-len(MSG)/2) say MSG
otwet=1
do while (otwet != 0)
   set color to &cfr
   @ Y1+ 2,X1+2 prompt "Предприятие:"
   @ row(),col()+1 say I->ORGANIZ
   @ Y1+ 4,X1+2 prompt "Должность:"
   @ row(),col()+1 say I->BUH
   @ Y1+ 6,X1+2 prompt "Подпись:"
   @ row(),col()+1 say I->PODPIS
   @ Y1+ 8,X1+2 prompt "Ширина печати:"
   @ row(),col()+1 say I->LEN_LPT1
   @ Y1+10,X1+2 prompt "Перевод листа:"
   @ row(),col()+1 say iif(I->IS_LIST,"ДА ","НЕТ")
   menu to otwet
   if otwet!=0
     set cursor on
     do case
       case otwet=1
         @ Y1+2,X1+15 get I->ORGANIZ
         read
       case otwet=2
         @ Y1+4,X1+13 get I->BUH
         read
       case otwet=3
         @ Y1+6,X1+11 get I->PODPIS
         read
       case otwet=4
         @ Y1+8,X1+17 get I->LEN_LPT1
         read
       case otwet=5
         repl I->IS_LIST with .not.(I->IS_LIST)
     endcase
     set cursor off
   endif
enddo
restore screen from OnePage
set color to (old_color)
return
