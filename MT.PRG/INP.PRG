*---------------------------------------------------------*
procedure RecExpMT
parameters Y1,X1,Y2,X2
private old_color,InpPage,otwet,done,Nz
old_color = setcolor(cinp)
save screen to InpPage
BoxTenj(Y1,X1,Y2,X2,ibox)
set color to &cl
MSG='   ˆ •  „ /  € ‘ •  „ '
@ Y1,int((X1+X2)/2-len(MSG)/2) say MSG
set color to &cinp
dDATE=date()
dNUMBER=nulvar(A->NUMBER)
dMATERIAL=nulvar(A->MATERIAL)
dMEAS=""
@ Y1+1,X1+1 say " „ â             ®¬¥à "
@ Y1+2,X1+1 say "ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍ"
@ Y1+3,X1+1 say " Œ â¥à¨ «                                ³…¤./¨§¬."
@ Y1+4,X1+1 say "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄ"
@ Y1+5,X1+1 say "                                         ³        "
@ Y1+6,X1+1 say "ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍ"
iRECNUM = nulvar(RECNUM)
iRECSUM = nulvar(RECSUM)
@ Y1+ 7,X1+ 2 say "Š®«¨ç¥áâ¢®"
@ Y1+ 8,X1+ 2 say "‘ã¬¬ "
@ Y1+ 9,X1+1 to Y1+9,X2-1 double
set color to &cl
MSG='   ˆ •  „ '
@ Y1+ 9,int((X1+X2)/2-len(MSG)/2) say MSG
set color to &cinp
drDIVISION=nulvar(DIVISION)
dRECEIPTS=nulvar(RECEIPTS)
@ Y1+10,X1+ 2 say "®¤à §¤¥«¥­¨¥"
@ Y1+11,X1+ 2 say "à¨å®¤­ë© áç¥â"
@ Y1+12,X1+1 to Y1+12,X2-1 double
set color to &cl
MSG='  € ‘ •  „ '
@ Y1+12,int((X1+X2)/2-len(MSG)/2) say MSG
set color to &cinp
deDIVISION=nulvar(DIVISION)
dEXPENSES=nulvar(EXPENSES)
@ Y1+13,X1+ 2 say "®¤à §¤¥«¥­¨¥"
@ Y1+14,X1+ 2 say " áå®¤­ë© áç¥â"
@ Y1+15,X1+1 to Y1+15,X2-1 double
dPOSTAV=nulvar(POSTAV)
@ Y1+16,X1+ 2 say "®áâ ¢é¨ª"
SIZE_MENU=10
done=.T.
otwet=1
do while done
  decl menu_var[SIZE_MENU]
  mtdict(dMATERIAL)
  menu_var[1] = dDATE
  @ Y1+ 1,X1+ 8 say menu_var[1]
  menu_var[2] = dNUMBER
  @ Y1+ 1,X1+24 say menu_var[2]
  menu_var[3] = dMATERIAL
  @ Y1+ 5,X1+ 2 say menu_var[3]
  @ Y1+ 5,X1+44 say dMEAS
  menu_var[4] = iRECNUM
  @ Y1+ 7,X1+13 say menu_var[4]
  menu_var[5] = iRECSUM
  @ Y1+ 8,X1+13 say menu_var[5]
  menu_var[6] = mdict("D2",drDIVISION,"D1","division.dic","division.ntx")
  @ Y1+10,X1+18 say menu_var[6]
  menu_var[7] = mdict("str(D1)+' '+D2",dRECEIPTS,"D1","balans.dic","balans.ntx")
  @ Y1+11,X1+18 say menu_var[7]
  menu_var[8] = mdict("D2",deDIVISION,"D1","division.dic","division.ntx")
  @ Y1+13,X1+18 say menu_var[8]
  menu_var[9] = mdict("str(D1)+' '+D2",dEXPENSES,"D1","balans.dic","balans.ntx")
  @ Y1+14,X1+18 say menu_var[9]
  menu_var[10] = mdict("str(D1)+' '+D2",dPOSTAV,"D1","postav.dic","postav.ntx")
  @ Y1+16,X1+18 say menu_var[10]
  do while otwet!=0
    do case
    case otwet=1
      @ Y1+ 1,X1+ 8 get menu_var[1]
    case otwet=2
      @ Y1+ 1,X1+24 get menu_var[2]
    case otwet=3
      @ Y1+ 5,X1+ 2 get menu_var[3]
    case otwet=4
      @ Y1+ 7,X1+13 get menu_var[4]
    case otwet=5
      @ Y1+ 8,X1+13 get menu_var[5]
    case otwet=6
      @ Y1+10,X1+18 get menu_var[6]
    case otwet=7
      @ Y1+11,X1+18 get menu_var[7]
    case otwet=8
      @ Y1+13,X1+18 get menu_var[8]
    case otwet=9
      @ Y1+14,X1+18 get menu_var[9]
    case otwet=10
      @ Y1+16,X1+18 get menu_var[10]
    endcase
    clear gets
    key_last = inkey(0)
    do case
    case otwet=1
      @ Y1+ 1,X1+ 8 say menu_var[1]
    case otwet=2
      @ Y1+ 1,X1+24 say menu_var[2]
    case otwet=3
      @ Y1+ 5,X1+ 2 say menu_var[3]
    case otwet=4
      @ Y1+ 7,X1+13 say menu_var[4]
    case otwet=5
      @ Y1+ 8,X1+13 say menu_var[5]
    case otwet=6
      @ Y1+10,X1+18 say menu_var[6]
    case otwet=7
      @ Y1+11,X1+18 say menu_var[7]
    case otwet=8
      @ Y1+13,X1+18 say menu_var[8]
    case otwet=9
      @ Y1+14,X1+18 say menu_var[9]
    case otwet=10
      @ Y1+16,X1+18 say menu_var[10]
    endcase
    do case
      case key_last = 27
        otwet = 0
        done=.F.
      case key_last =  5.or.key_last = 19   && UP or RIGHT
        if otwet = 1
          otwet = SIZE_MENU
        else
          otwet = otwet - 1
        endif
      case key_last = 24.or.key_last =  4   && DOWN or LEFT
        if otwet = SIZE_MENU
          otwet = 1
        else
          otwet = otwet + 1
        endif
      case key_last = 13.or.isdata(key_last)
        if key_last <> 13
          keyboard chr(key_last)
        endif
        do case
        case otwet=1
          set cursor on
          @ Y1+ 1,X1+ 8 get dDATE
          read
          set cursor off
        case otwet=2
          set cursor on
          @ Y1+ 1,X1+24 get dNUMBER
          read
          set cursor off
        case otwet=3
          dMATERIAL = DictFind(dMATERIAL,"MATERIAL","MATERIAL+' '+MEAS","Œ â¥à¨ «","material.dic","material.ntx")
        case otwet=4
          set cursor on
          @ Y1+ 7,X1+13 get iRECNUM
          read
          set cursor off
        case otwet=5
          set cursor on
          @ Y1+ 8,X1+13 get iRECSUM
          read
          set cursor off
        case otwet=6
          drDIVISION = DictFind(drDIVISION,"D1","D2","®¤à §¤¥«¥­¨¥","division.dic","division.ntx")
        case otwet=7
          dRECEIPTS = DictFind(dRECEIPTS,"D1","str(D1)+' '+D2","à¨å®¤","balans.dic","balans.ntx")
        case otwet=8
          deDIVISION = DictFind(deDIVISION,"D1","D2","®¤à §¤¥«¥­¨¥","division.dic","division.ntx")
        case otwet=9
          dEXPENSES = DictFind(dEXPENSES,"D1","str(D1)+' '+D2"," áå®¤","balans.dic","balans.ntx")
        case otwet=10
          dPOSTAV = DictFind(dPOSTAV,"D1","str(D1)+' '+D2","®áâ ¢é¨ª","postav.dic","postav.ntx")
        endcase
        if lastkey()=13.or.isdata(lastkey())
          keyboard chr(24)
        endif
        exit
      case key_last =  9
        do Calculator
      endcase
  enddo
  rele menu_var
enddo
if .not.(empty(dMATERIAL))
 if Fragen('ˆ•„/€‘•„','‚ë¯®«­¨âì ®¯¥à æ¨î?')
  Nz=recno()
  if iRECSUM=0
   summ=Summa()
  endif
  set filter to
  go top
  if dRECEIPTS!=0
    set order to 2
    seek str(dRECEIPTS)+dMATERIAL+str(drDIVISION)
    if .not.found()
      append blank
      repl DATE     with dDATE
      repl NUMBER   with dNUMBER
      repl MATERIAL with dMATERIAL
      repl DIVISION with drDIVISION
      repl RECEIPTS with dRECEIPTS
      repl POSTAV   with iif(dPOSTAV=0,deDIVISION,dPOSTAV)
    endif
    repl RECNUM with RECNUM+iRECNUM
    repl RECSUM with RECSUM+iif(iRECSUM=0,iRECNUM*summ,iRECSUM)
    repl ENDNUM with BEGNUM+RECNUM-EXPNUM
    repl ENDSUM with BEGSUM+RECSUM-EXPSUM
  endif
  if dEXPENSES!=0
    set order to 3
    seek str(dEXPENSES)+dMATERIAL+str(deDIVISION)
    if .not.found()
      append blank
      repl DATE     with dDATE
      repl NUMBER   with dNUMBER
      repl MATERIAL with dMATERIAL
      repl DIVISION with deDIVISION
      repl EXPENSES with dEXPENSES
      repl POSTAV   with iif(dPOSTAV=0,drDIVISION,dPOSTAV)
    endif
    repl EXPNUM with EXPNUM+iRECNUM
    repl EXPSUM with EXPSUM+iif(iRECSUM=0,iRECNUM*summ,iRECSUM)
    repl ENDNUM with BEGNUM+RECNUM-EXPNUM
    repl ENDSUM with BEGSUM+RECSUM-EXPSUM
  endif
  skip
  commit
  set order to I->REGIM_SORT
  InitFilter()
  go Nz
  RETR=0
  redraw=.F.
 endif
endif
restore screen from InpPage
set color to &old_color
return
*---------------------------------------------------------*
procedure InpMT
parameters Y1,X1,Y2,X2
private old_color,InpPage,otwet,menu_var,log_clr,done
old_color = setcolor(cinp)
save screen to InpPage
BoxTenj(Y1,X1,Y2,X2,ibox)
set color to &cl
MSG=' ‘ — … ’ '
@ Y1,int((X1+X2)/2-len(MSG)/2) say MSG
@ Y2,X_min+24 say ' Œ …  : '
set color to &cmenu
MSG='Enter'
@ row(),col() get MSG
@ row(),col() say '‚¢®¤'
MSG='ESC'
@ row(),col() get MSG
@ row(),col() say '‚ëå®¤'
clear gets
set color to &cinp
@ Y1+ 1,X1+2 say "®¤à §¤¥«¥­¨¥"
@ Y1+ 2,X1+2 say "à¨å®¤­ë© áç¥â"
@ Y1+ 3,X1+2 say " áå®¤­ë© áç¥â"
@ Y1+ 4,X1+2 say "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍ»"
@ Y1+ 5,X1+2 say "º Œ â¥à¨ «                                         ³…¤./¨§¬.º"
@ Y1+ 6,X1+2 say "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄ¶"
@ Y1+ 7,X1+2 say "º                                                  ³        º"
@ Y1+ 8,X1+2 say "ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍ¹"
@ Y1+ 9,X1+2 say "º           à¨å®¤            ³            áå®¤            º"
@ Y1+10,X1+2 say "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
@ Y1+11,X1+2 say "º  Š®«¨ç¥áâ¢®  ³    ‘ã¬¬      ³  Š®«¨ç¥áâ¢®  ³    ‘ã¬¬      º"
@ Y1+12,X1+2 say "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
@ Y1+13,X1+2 say "º              ³              ³              ³              º"
@ Y1+14,X1+2 say "ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹"
@ Y1+15,X1+2 say "º      ‘ «ì¤® ­  ­ ç «®       ³      ‘ «ì¤® ­  ª®­¥æ        º"
@ Y1+16,X1+2 say "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
@ Y1+17,X1+2 say "º  Š®«¨ç¥áâ¢®  ³    ‘ã¬¬      ³  Š®«¨ç¥áâ¢®  ³    ‘ã¬¬      º"
@ Y1+18,X1+2 say "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
@ Y1+19,X1+2 say "º              ³              ³              ³              º"
@ Y1+20,X1+2 say "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼"
@ Y1+21,X1+2 say "„ â           ®¬¥à           ®áâ ¢é¨ª"
dDATE=date()
dMATERIAL=""
dMEAS=""
SIZE_MENU=15
done=.T.
otwet=1
do while done
  mtdict(A->MATERIAL)
  repl ENDNUM with BEGNUM+RECNUM-EXPNUM
  repl ENDSUM with BEGSUM+RECSUM-EXPSUM
  decl menu_var[SIZE_MENU]
  menu_var[1] = mdict("D2",DIVISION,"D1","division.dic","division.ntx")
  @ Y1+1,X1+18 say menu_var[1]
  menu_var[2] = mdict("str(D1)+' '+D2",RECEIPTS,"D1","balans.dic","balans.ntx")
  @ Y1+2,X1+18 say menu_var[2]
  menu_var[3] = mdict("str(D1)+' '+D2",EXPENSES,"D1","balans.dic","balans.ntx")
  @ Y1+3,X1+18 say menu_var[3]
  menu_var[4] = MATERIAL
  @ Y1+7,X1+ 4 say menu_var[4]
  @ Y1+7,X1+56 say dMEAS
  menu_var[5] = RECNUM
  @ Y1+13,X1+ 3 say RECNUM
  menu_var[6] = RECSUM
  @ Y1+13,X1+18 say RECSUM
  menu_var[7] = EXPNUM
  @ Y1+13,X1+33 say EXPNUM
  menu_var[8] = EXPSUM
  @ Y1+13,X1+48 say EXPSUM
  menu_var[9] = BEGNUM
  @ Y1+19,X1+ 3 say BEGNUM
  menu_var[10] = BEGSUM
  @ Y1+19,X1+18 say BEGSUM
  menu_var[11] = ENDNUM
  @ Y1+19,X1+33 say ENDNUM
  menu_var[12] = ENDSUM
  @ Y1+19,X1+48 say ENDSUM
  menu_var[13] = DATE
  @ Y1+21,X1+ 7 say DATE
  menu_var[14] = NUMBER
  @ Y1+21,X1+22 say NUMBER
  menu_var[15] = mdict("D2",POSTAV,"D1","postav.dic","postav.ntx")
  @ Y1+21,X1+42 say menu_var[15]
  do while otwet!=0
    do case
    case otwet=1
      @ Y1+ 1,X1+18 get menu_var[1]
    case otwet=2
      @ Y1+ 2,X1+18 get menu_var[2]
    case otwet=3
      @ Y1+ 3,X1+18 get menu_var[3]
    case otwet=4
      @ Y1+ 7,X1+ 4 get menu_var[4]
    case otwet=5
      @ Y1+13,X1+ 3 get menu_var[5]
    case otwet=6
      @ Y1+13,X1+18 get menu_var[6]
    case otwet=7
      @ Y1+13,X1+33 get menu_var[7]
    case otwet=8
      @ Y1+13,X1+48 get menu_var[8]
    case otwet=9
      @ Y1+19,X1+ 3 get menu_var[9]
    case otwet=10
      @ Y1+19,X1+18 get menu_var[10]
    case otwet=11
      @ Y1+19,X1+33 get menu_var[11]
    case otwet=12
      @ Y1+19,X1+48 get menu_var[12]
    case otwet=13
      @ Y1+21,X1+ 7 get menu_var[13]
    case otwet=14
      @ Y1+21,X1+22 get menu_var[14]
    case otwet=15
      @ Y1+21,X1+42 get menu_var[15]
    endcase
    clear gets
    key_last = inkey(0)
    do case
    case otwet=1
      @ Y1+ 1,X1+18 say menu_var[1]
    case otwet=2
      @ Y1+ 2,X1+18 say menu_var[2]
    case otwet=3
      @ Y1+ 3,X1+18 say menu_var[3]
    case otwet=4
      @ Y1+ 7,X1+ 4 say menu_var[4]
    case otwet=5
      @ Y1+13,X1+ 3 say menu_var[5]
    case otwet=6
      @ Y1+13,X1+18 say menu_var[6]
    case otwet=7
      @ Y1+13,X1+33 say menu_var[7]
    case otwet=8
      @ Y1+13,X1+48 say menu_var[8]
    case otwet=9
      @ Y1+19,X1+ 3 say menu_var[9]
    case otwet=10
      @ Y1+19,X1+18 say menu_var[10]
    case otwet=11
      @ Y1+19,X1+33 say menu_var[11]
    case otwet=12
      @ Y1+19,X1+48 say menu_var[12]
    case otwet=13
      @ Y1+21,X1+ 7 say menu_var[13]
    case otwet=14
      @ Y1+21,X1+22 say menu_var[14]
    case otwet=15
      @ Y1+21,X1+42 say menu_var[15]
    endcase
    do case
      case key_last = 27
        otwet = 0
        done=.F.
      case key_last =  5.or.key_last = 19   && UP or RIGHT
        if otwet = 1
          otwet = SIZE_MENU
        else
          otwet = otwet - 1
        endif
      case key_last = 24.or.key_last =  4   && DOWN or LEFT
        if otwet = SIZE_MENU
          otwet = 1
        else
          otwet = otwet + 1
        endif
      case key_last = 13.or.isdata(key_last)
        if key_last <> 13
          keyboard chr(key_last)
        endif
        do case
        case otwet=1
          repl DIVISION with DictFind(DIVISION,"D1","D2","®¤à §¤¥«¥­¨¥","division.dic","division.ntx")
        case otwet=2
          repl RECEIPTS with DictFind(RECEIPTS,"D1","str(D1)+' '+D2","à¨å®¤","balans.dic","balans.ntx")
        case otwet=3
          repl EXPENSES with DictFind(EXPENSES,"D1","str(D1)+' '+D2"," áå®¤","balans.dic","balans.ntx")
        case otwet=4
          repl MATERIAL with DictFind(MATERIAL,"MATERIAL","MATERIAL+' '+MEAS+' '","Œ â¥à¨ «","material.dic","material.ntx")
        case otwet=5
          set cursor on
          @ Y1+13,X1+ 3 get A->RECNUM
          read
          set cursor off
        case otwet=6
          set cursor on
          @ Y1+13,X1+18 get A->RECSUM
          read
          set cursor off
        case otwet=7
          set cursor on
          @ Y1+13,X1+33 get A->EXPNUM
          read
          set cursor off
        case otwet=8
          set cursor on
          @ Y1+13,X1+48 get A->EXPSUM
          read
          set cursor off
        case otwet=9
          set cursor on
          @ Y1+19,X1+ 3 get A->BEGNUM
          read
          set cursor off
        case otwet=10
          set cursor on
          @ Y1+19,X1+18 get A->BEGSUM
          read
          set cursor off
        case otwet=11
          set cursor on
          @ Y1+19,X1+33 get A->ENDNUM
          read
          set cursor off
        case otwet=12
          set cursor on
          @ Y1+19,X1+48 get A->ENDSUM
          read
          set cursor off
        case otwet=13
          set cursor on
          @ Y1+21,X1+ 7 get A->DATE
          read
          set cursor off
        case otwet=14
          set cursor on
          @ Y1+21,X1+22 get A->NUMBER
          read
          set cursor off
        case otwet=15
          repl POSTAV with DictFind(POSTAV,"D1","D2","®áâ ¢é¨ª","postav.dic","postav.ntx")
        endcase
        if lastkey()=13.or.isdata(lastkey())
          keyboard chr(24)
        endif
        exit
      case key_last =  9
        do Calculator
      endcase
  enddo
  rele menu_var
enddo
Nz=recno()
skip
commit
go Nz
RETR=0
redraw=.F.
restore screen from InpPage
set color to &old_color
return
*---------------------------------------------------------*
procedure mtdict
parameters sik
private old_select
old_select = select()
select 8
use material.dic
set index to material.ntx
seek sik
dNUMB    =NUMB
dMATERIAL=MATERIAL
dMEAS    =MEAS
use
select(old_select)
return
*---------------------------------------------------------*
procedure Summa
private old_Nz
if reccount() = 0
  return 0
endif
old_Nz=recno()
set order to 1
dBEGNUM=0
dBEGSUM=0
dRECNUM=0
dRECSUM=0
dEXPNUM=0
dEXPSUM=0
dENDNUM=0
dENDSUM=0
seek dMATERIAL
do while dMATERIAL=A->MATERIAL
  dBEGNUM=dBEGNUM+BEGNUM
  dBEGSUM=dBEGSUM+BEGSUM
  dRECNUM=dRECNUM+RECNUM
  dRECSUM=dRECSUM+RECSUM
  dEXPNUM=dEXPNUM+EXPNUM
  dEXPSUM=dEXPSUM+EXPSUM
  dENDNUM=dENDNUM+ENDNUM
  dENDSUM=dENDSUM+ENDSUM
  skip
enddo
set order to I->REGIM_SORT
go old_Nz
return dENDSUM/dENDNUM
*---------------------------------------------------------*
procedure SummaMT
parameters Y1,X1,Y2,X2
private old_color,InpPage,otwet,menu_var,log_clr,done
if reccount() = 0
  WarnWrite("H¥ç¥£® áç¨â âì...")
  return
endif
old_color = setcolor(cinp)
save screen to InpPage
BoxTenj(Y1,X1,Y2,X2,ibox)
set color to &cl
MSG=' ‘ “ Œ Œ € '
@ Y1,int((X1+X2)/2-len(MSG)/2) say MSG
set color to &cinp
@ Y1+ 1,X1+2 say "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
@ Y1+ 2,X1+2 say "º Œ â¥à¨ «                               ³ˆ§¬³    –¥­       º"
@ Y1+ 3,X1+2 say "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
@ Y1+ 4,X1+2 say "º                                        ³   ³              º"
@ Y1+ 5,X1+2 say "ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÏÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹"
@ Y1+ 6,X1+2 say "º           à¨å®¤            ³            áå®¤            º"
@ Y1+ 7,X1+2 say "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
@ Y1+ 8,X1+2 say "º  Š®«¨ç¥áâ¢®  ³    ‘ã¬¬      ³  Š®«¨ç¥áâ¢®  ³    ‘ã¬¬      º"
@ Y1+ 9,X1+2 say "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
@ Y1+10,X1+2 say "º              ³              ³              ³              º"
@ Y1+11,X1+2 say "ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹"
@ Y1+12,X1+2 say "º      ‘ «ì¤® ­  ­ ç «®       ³      ‘ «ì¤® ­  ª®­¥æ        º"
@ Y1+13,X1+2 say "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
@ Y1+14,X1+2 say "º  Š®«¨ç¥áâ¢®  ³    ‘ã¬¬      ³  Š®«¨ç¥áâ¢®  ³    ‘ã¬¬      º"
@ Y1+15,X1+2 say "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
@ Y1+16,X1+2 say "º              ³              ³              ³              º"
@ Y1+17,X1+2 say "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼"
dMATERIAL=""
dMEAS=""
mtdict(A->MATERIAL)
@ Y1+4,X1+ 3 say MATERIAL
@ Y1+4,X1+44 say dMEAS
***
save screen
MsgWrite("‘ç¨â î...")
dMATERIAL=A->MATERIAL
dBEGNUM=0
dBEGSUM=0
dRECNUM=0
dRECSUM=0
dEXPNUM=0
dEXPSUM=0
dENDNUM=0
dENDSUM=0
Summa()
restore screen
@ Y1+ 4,X1+48 say dENDSUM/dENDNUM picture pic_sum
@ Y1+10,X1+ 3 say dRECNUM picture pic_sum
@ Y1+10,X1+18 say dRECSUM picture pic_sum
@ Y1+10,X1+33 say dEXPNUM picture pic_sum
@ Y1+10,X1+48 say dEXPSUM picture pic_sum
@ Y1+16,X1+ 3 say dBEGNUM picture pic_sum
@ Y1+16,X1+18 say dBEGSUM picture pic_sum
@ Y1+16,X1+33 say dENDNUM picture pic_sum
@ Y1+16,X1+48 say dENDSUM picture pic_sum
inkey(0)
restore screen from InpPage
set color to &old_color
return
*---------------------------------------------------------*
function OborITOG
parameters Y1,X1,Y2,X2
private old_color,ptr,currprow,str_file,i,j,indx,i_min,i_max,old_Nz,str_prn,isprn
if reccount() = 0
  WarnWrite("H¥ç¥£® p áç¨âë¢ âì...")
  return " "
endif
save screen to InpPage
MsgWrite(" áç¨âë¢ î...")
old_color=setcolor(cw)
old_select=select()
old_Nz=recno()
set order to 1
total on MATERIAL fields BEGNUM,BEGSUM,RECNUM,RECSUM,EXPNUM,EXPSUM,ENDNUM,ENDSUM to temp.dbf
select 2
use temp.dbf
dMATERIAL=""
dMEAS=""
sBEGSUM=0
sRECSUM=0
sEXPSUM=0
sENDSUM=0
do while (.not.eof())
  mtdict(B->MATERIAL)
  sBEGSUM=sBEGSUM+BEGSUM
  sRECSUM=sRECSUM+RECSUM
  sEXPSUM=sEXPSUM+EXPSUM
  sENDSUM=sENDSUM+ENDSUM
  skip
enddo
select 2
use
dele file temp.dbf
BoxTenj(Y1,X1,Y2,X2,ibox)
set color to &cl
MSG=' ˆ ’  ƒ  '
@ Y1,int((X1+X2)/2-len(MSG)/2) say MSG
set color to &cinp
@ Y1+ 1,X1+1 say "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
@ Y1+ 2,X1+1 say "º      à¨å®¤      ³      áå®¤      º"
@ Y1+ 3,X1+1 say "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
@ Y1+ 4,X1+1 say "º                  ³                 º"
@ Y1+ 5,X1+1 say "ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹"
@ Y1+ 6,X1+1 say "º ‘ «ì¤® ­  ­ ç «® ³ ‘ «ì¤® ­  ª®­¥æ º"
@ Y1+ 7,X1+1 say "ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶"
@ Y1+ 8,X1+1 say "º                  ³                 º"
@ Y1+ 9,X1+1 say "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼"
@ Y1+ 4,X1+ 4 say sRECSUM picture pic_sum
@ Y1+ 4,X1+22 say sEXPSUM picture pic_sum
@ Y1+ 8,X1+ 4 say sBEGSUM picture pic_sum
@ Y1+ 8,X1+22 say sENDSUM picture pic_sum
inkey(0)
restore screen from InpPage
setcolor(old_color)
select(old_select)
set order to I->REGIM_SORT
go old_Nz
return " "
