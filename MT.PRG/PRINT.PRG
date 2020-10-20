*---------------------------------------------------------*
procedure AccoLPT1
private str_file,str_prn
if empty(I->L_FILTER)
  WarnWrite("УСТАНОВИТЕ ВЫБОРКУ...")
  return
endif
dMATERIAL = DictFind("","MATERIAL","MATERIAL+' '+MEAS","Материал","material.dic","material.ntx")
if lastkey()!=13
  return
endif
str_file=memoread(cur_path+"\account.prn")
MsgWrite(msgprn)
Nz=recno()
dNUMB=""
dMEAS=""
dBEGNUM=0
dBEGSUM=0
dRECNUM=0
dRECSUM=0
dEXPNUM=0
dEXPSUM=0
dENDNUM=0
dENDSUM=0
mtdict(dMATERIAL)
Summa()
dZENA=dENDSUM/dENDNUM
dZENA=transform(dENDSUM/dENDNUM,pic_sum)
*** 1-заголовок
i_min=at(chr(1),str_file)
i_max=rat(chr(1),str_file)
if i_min != i_max.and.i_min != (i_max - 1)
 str_prn=substr(str_file,i_min+1,i_max-i_min-1)
endif
isprn=mprints(strfrm(str_prn))
*** 2-таблица
if isprn
 i_min=at(chr(2),str_file)
 i_max=rat(chr(2),str_file)
 if i_min != i_max.and.i_min != (i_max - 1)
  str_prn=substr(str_file,i_min+1,i_max-i_min-1)
 endif
 set order to 1
 seek dMATERIAL
 dDIV=val(alltrim(substr(I->L_FILTER,10,5)))
 nn=0
 do while isprn.and.dMATERIAL=A->MATERIAL
  dDATE=DATE
  dNUMBER=NUMBER
  nn++
  dNN=str(nn,5)
  if RECSUM!=0
   dPOSTAV=mdict("D2",POSTAV,"D1","postav.dic","postav.ntx")
   dRECSUM=RECSUM
   dEXPSUM=0
   dBEGSUM=dBEGSUM+RECSUM
  else
   dPOSTAV=mdict("D2",POSTAV,"D1","division.dic","division.ntx")
   dRECSUM=0
   dEXPSUM=EXPSUM
   dBEGSUM=dBEGSUM-EXPSUM
  endif
  repl I->FORMAT with dRECSUM
  dRECSUM=I->FORMAT
  repl I->FORMAT with dEXPSUM
  dEXPSUM=I->FORMAT
  repl I->FORMAT with dBEGSUM
  dBEGSUM=I->FORMAT
  isprn=mprints(strfrm(str_prn))
  skip
 enddo
 set order to I->REGIM_SORT
*** 3-окончание
 if isprn
  i_min=at(chr(3),str_file)
  i_max=rat(chr(3),str_file)
  if i_min != i_max.and.i_min != (i_max - 1)
   str_prn=substr(str_file,i_min+1,i_max-i_min-1)
  endif
  mprints(strfrm(str_prn))
 endif
 go Nz
endif
return
*---------------------------------------------------------*
function OborLPT1
private old_color,ptr,currprow,str_file,i,j,indx,i_min,i_max,old_Nz,str_prn,isprn
if reccount() = 0
  WarnWrite("Hечего pасчитывать...")
  return " "
endif
if .not.Fragen('','Произвести необходимые расчеты?')
  return " "
endif
MsgWrite("Расчитываю...")
old_color=setcolor(cw)
old_select=select()
old_Nz=recno()
set order to 1
total on MATERIAL fields BEGNUM,BEGSUM,RECNUM,RECSUM,EXPNUM,EXPSUM,ENDNUM,ENDSUM to temp.dbf
select 2
use temp.dbf
if QuesPrint()
MsgWrite(msgprn)
*** 1-заголовок
str_file=memoread(cur_path+"\oborot.prn")
i_min=at(chr(1),str_file)
i_max=rat(chr(1),str_file)
if i_min != i_max.and.i_min != (i_max - 1)
  str_prn=strfrm(substr(str_file,i_min+1,i_max-i_min-1))
else
  str_prn=""
endif
isprn=mprints(str_prn)
*** 2-таблица
if isprn
dMATERIAL=""
dMEAS=""
dPRICE=0
i_min=at(chr(2),str_file)
i_max=rat(chr(2),str_file)
if i_min != i_max.and.i_min != (i_max - 1)
  str_tab=substr(str_file,i_min+1,i_max-i_min-1)
else
  str_tab=""
endif
sBEGSUM=0
sRECSUM=0
sEXPSUM=0
sENDSUM=0
do while (.not.eof())
  mtdict(B->MATERIAL)
  str_prn=strfrm(str_tab)
  isprn=mprints(str_prn)
  sBEGSUM=sBEGSUM+BEGSUM
  sRECSUM=sRECSUM+RECSUM
  sEXPSUM=sEXPSUM+EXPSUM
  sENDSUM=sENDSUM+ENDSUM
  if isprn
    skip
  else
    exit
  endif
enddo
endif
*** 3 - END строка
if isprn
i_min=at(chr(3),str_file)
i_max=rat(chr(3),str_file)
if i_min != i_max.and.i_min != (i_max - 1)
  str_prn=strfrm(substr(str_file,i_min+1,i_max-i_min-1))
else
  str_prn=""
endif
isprn=mprints(str_prn)
endif
***
endif
select 2
use
dele file temp.dbf
***
setcolor(old_color)
select(old_select)
set order to I->REGIM_SORT
go old_Nz
return " "
*---------------------------------------------------------*
function SvodLPT1
private old_color,ptr,currprow,str_file,i,j,indx,i_min,i_max,old_Nz,str_prn,isprn
if reccount() = 0
  WarnWrite("Hечего pасчитывать...")
  return " "
endif
if .not.Fragen('','Произвести необходимые расчеты?')
  return " "
endif
MsgWrite("Расчитываю...")
old_color=setcolor(cw)
old_select=select()
old_Nz=recno()
set filter to
go top
index on str(DIVISION)+str(RECEIPTS) to rec.ntx
total on str(DIVISION)+str(RECEIPTS) fields RECSUM to rec.dbf
index on str(DIVISION)+str(EXPENSES) to exp.ntx
total on str(DIVISION)+str(EXPENSES) fields EXPSUM to exp.dbf
index on str(DIVISION) to sum.ntx
total on str(DIVISION) fields BEGSUM,ENDSUM to sum.dbf
close index
select 2
use rec.dbf
index on str(DIVISION)+str(RECEIPTS) to rec.ntx
select 3
use exp.dbf
index on str(DIVISION)+str(EXPENSES) to exp.ntx
select 4
use division.dic index division.ntx
select 5
use balans.dic index balans.ntx
select 7
use sum.dbf
index on str(DIVISION) to sum.ntx
select 4
len_dev=lenvar(D2)
nul_dev=nulvar(D2)
select 5
count_rec=reccount()
count_exp=reccount()
*** Расчет фактического числа rec и exp
decl iREC[count_rec]
afill(iREC,0)
decl iEXP[count_exp]
afill(iEXP,0)
select 4
go top
do while (.not.eof())
  select 5
  go top
  i=1
  do while .not.eof()
    select 2
    seek str(D->D1)+str(E->D1)
    iREC[i]=iREC[i]+RECSUM
    i=i+1
    select 5
    skip
  enddo
  select 5
  go top
  i=1
  do while .not.eof()
    select 3
    seek str(D->D1)+str(E->D1)
    iEXP[i]=iEXP[i]+EXPSUM
    i=i+1
    select 5
    skip
  enddo
  select 4
  skip
enddo
j=0
for i=1 to count_rec
  if iREC[i] != 0
    j=j+1
  endif
next
cnt_rec=j
j=0
for i=1 to count_exp
  if iEXP[i] != 0
    j=j+1
  endif
next
cnt_exp=j
***  формирование строки таблицы
select(old_select)
len_sum=lenvar(pic_sum)
str_len=(len_dev)+4*(len_sum+1)+(cnt_rec+cnt_exp)*(len_sum+1)
*** 1-заголовок
str_file=memoread(cur_path+"\svod.prn")
str_prn=""
i_min=at(chr(1),str_file)
i_max=rat(chr(1),str_file)
if i_min != i_max.and.i_min != (i_max - 1)
  str_prn=str_prn+strfrm(substr(str_file,i_min+1,i_max-i_min-1))
endif
***
* 1 строка
str_prn=str_prn+replicate("-",str_len)+chr(13)+chr(10)
* 2 строка
str_prn=str_prn+"    Подразделения   !"
str_prn=str_prn+zentstr(len_sum,"Сальдо")+"!"
str_prn=str_prn+zentstr(cnt_rec*(len_sum+1)-1,"Приход")+"!"
str_prn=str_prn+zentstr(len_sum,"Итого")+"!"
str_prn=str_prn+zentstr(cnt_exp*(len_sum+1)-1,"Расход")+"!"
str_prn=str_prn+zentstr(len_sum,"Итого")+"!"
str_prn=str_prn+zentstr(len_sum,"Сальдо")
str_prn=str_prn+chr(13)+chr(10)
* 3 строка
str_prn=str_prn+nul_dev+"!"
str_prn=str_prn+zentstr(len_sum,"на")+"!"
str_prn=str_prn+replicate("-",cnt_rec*(len_sum+1)-1)+"!"
str_prn=str_prn+zentstr(len_sum,"приход")+"!"
str_prn=str_prn+replicate("-",cnt_exp*(len_sum+1)-1)+"!"
str_prn=str_prn+zentstr(len_sum,"расход")+"!"
str_prn=str_prn+zentstr(len_sum,"на")
str_prn=str_prn+chr(13)+chr(10)
* 4 строка
str_prn=str_prn+nul_dev+"!"
str_prn=str_prn+zentstr(len_sum,"начало")+"!"
select 5
go top
i=1
do while .not.eof()
 if iREC[i] != 0
  str_prn=str_prn+zentstr(len_sum,strroun(D1))+"!"
 endif
 skip
 i=i+1
enddo
str_prn=str_prn+space(len_sum)+"!"
select 5
go top
i=1
do while .not.eof()
 if iEXP[i] != 0
  str_prn=str_prn+zentstr(len_sum,strroun(D1))+"!"
 endif
 skip
 i=i+1
enddo
str_prn=str_prn+space(len_sum)+"!"
str_prn=str_prn+zentstr(len_sum,"конец")
str_prn=str_prn+chr(13)+chr(10)
* 5 строка
str_prn=str_prn+replicate("-",str_len)+chr(13)+chr(10)
***
iRECSUM=0
iEXPSUM=0
iBEGSUM=0
iENDSUM=0
select 4
go top
do while (.not.eof())
  str_prn=str_prn+D2+"!"
  select 5
  go top
  dRECSUM=0
  i=1
  ch=""
  do while .not.eof()
    if iREC[i] != 0
      select 2
      seek str(D->D1)+str(E->D1)
      ch=ch+strnum(RECSUM)+"!"
      dRECSUM=dRECSUM+RECSUM
      select 5
    endif
    skip
    i=i+1
  enddo
  select 7
  seek str(D->D1)
  dBEGSUM=BEGSUM
  iRECSUM=iRECSUM+dRECSUM
  iBEGSUM=iBEGSUM+dBEGSUM
  repl I->FORMAT with dBEGSUM
  str_prn=str_prn+strnum(I->FORMAT)+"!"
  repl I->FORMAT with dRECSUM
  str_prn=str_prn+ch+strnum(I->FORMAT)+"!"
  select 5
  go top
  dEXPSUM=0
  i=1
  do while .not.eof()
    if iEXP[i] != 0
      select 3
      seek str(D->D1)+str(E->D1)
      str_prn=str_prn+strnum(EXPSUM)+"!"
      dEXPSUM=dEXPSUM+EXPSUM
      select 5
    endif
    skip
    i=i+1
  enddo
  select 7
  seek str(D->D1)
  dENDSUM=ENDSUM
  iEXPSUM=iEXPSUM+dEXPSUM
  iENDSUM=iENDSUM+dENDSUM
  repl I->FORMAT with dEXPSUM
  str_prn=str_prn+strnum(I->FORMAT)+"!"
  repl I->FORMAT with dENDSUM
  str_prn=str_prn+strnum(I->FORMAT)
  str_prn=str_prn+chr(13)+chr(10)
  select 4
  skip
enddo
* "Итого"
str_prn=str_prn+replicate("-",str_len)+chr(13)+chr(10)
str_prn=str_prn+"    ИТОГО           !"
repl I->FORMAT with iBEGSUM
str_prn=str_prn+strnum(I->FORMAT)+"!"
i=1
do while i<=count_rec
  if iREC[i] != 0
    repl I->FORMAT with iREC[i]
    str_prn=str_prn+strnum(I->FORMAT)+"!"
  endif
  i=i+1
enddo
repl I->FORMAT with iRECSUM
str_prn=str_prn+strnum(I->FORMAT)+"!"
i=1
do while i<=count_exp
  if iEXP[i] != 0
    repl I->FORMAT with iEXP[i]
    str_prn=str_prn+strnum(I->FORMAT)+"!"
  endif
  i=i+1
enddo
repl I->FORMAT with iEXPSUM
str_prn=str_prn+strnum(I->FORMAT)+"!"
repl I->FORMAT with iENDSUM
str_prn=str_prn+strnum(I->FORMAT)
str_prn=str_prn+chr(13)+chr(10)
* 3 - END строка
str_prn=str_prn+replicate("-",str_len)+chr(13)+chr(10)
i_min=at(chr(3),str_file)
i_max=rat(chr(3),str_file)
if i_min != i_max.and.i_min != (i_max - 1)
  str_prn=str_prn+strfrm(substr(str_file,i_min+1,i_max-i_min-1))
endif
***
select 2
use
select 3
use
select 4
use
select 5
use
select 7
use
dele file rec.dbf
dele file exp.dbf
dele file sum.dbf
dele file rec.ntx
dele file exp.ntx
dele file sum.ntx
***
str_prn=formprn(@str_prn,I->LEN_LPT1,I->IS_LIST)
ed(Y_min,X_min,Y_max,X_max,@str_prn)
***
setcolor(old_color)
select(old_select)
OpenNTX()
InitFilter()
go old_Nz
return " "
