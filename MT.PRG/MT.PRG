*----------------------------------------Конюхов Д.Л.-----*
*                   М А Т Е Р И А Л Ы                     *
*---------------------------------------------------------*
*=========================================================*
*                     CLIPPER  2.0                        *
*=========================================================*
external mdict,strnum,strroun,strline
*---------------------------------------------------------*
#define F_NAME 1
#define F_SIZE 2
#define F_DATE 3
#define F_TIME 4
#define F_ATT  5
*---------------------------------------------------------*
public is_arhiv
*---------------------------------------------------------*
parameters param1
if type("param1") <> "C"
  param1 = ""
endif
OpenMouse()
InitSets()
InitVars()
InitColor(param1)
InitPMSG()
InitFormul()
InitCalc()
InitMenu()
InitMT()
*********************************************
*name_firm = __pinit(direxe()+'MT.',__panti())
*********************************************
cur_path=getdir()
cur_config=cur_path+"\config.mt"
redraw=.T.
PrgExit=.T.
do while PrgExit
 if redraw
  select 9
  use &cur_config
  cur_date=cur_path+"\"+str(year(I->T_DATE),4)+"."+strtran(str(month(I->T_DATE),2)," ","0")
  mkdir(cur_date)
  tBALANS=I->BALANS
  new_path=cur_date+"\MT"+intnum(I->BALANS)
  new_config=new_path+"\config.mt"
  use
  mkdir(new_path)
  set path to &new_path
  select 9
  if .not.file(new_config)
   copy file &cur_config to &new_config
  endif
  use &new_config
  CreateDBF()
  OpenDBF()
  CreateNTX(upper(param1)="/A")
  OpenNTX()
  DrawMT()
  mDIVISION=nulvar(DIVISION)
  mRECEIPTS=nulvar(RECEIPTS)
  mEXPENSES=nulvar(EXPENSES)
 else
  redraw=.T.
 endif
 setcolor(c)
 dbedit(Y_min+5,X_min+1,Y_max-3,X_max-1,jour_jou,"JourFunc","",jour_nam)
 if redraw
  CloseDBF()         && закрыть
  select 9
  use
 endif
enddo
set color to w/n
clear
set cursor On
CloseMouse()
Quit                                && Выход из программы

*---------------------------------------------------------*
function JourFunc
parameters mode,fld_ptr
RETR=1
Retr_User=.T.
Last_User=0
do while Retr_User
Retr_User=.F.
do case
case mode = 0
  if mDIVISION!=DIVISION
    @ 1,20 say mdict("H->D2",DIVISION,"D1","division.dic","division.ntx")
    mDIVISION=DIVISION
  endif
  if mRECEIPTS!=RECEIPTS
    @ 2,20 say mdict("str(H->D1)+' '+H->D2",RECEIPTS,"D1","balans.dic","balans.ntx")
    mRECEIPTS=RECEIPTS
  endif
  if mEXPENSES!=EXPENSES
    @ 3,20 say mdict("str(H->D1)+' '+H->D2",EXPENSES,"D1","balans.dic","balans.ntx")
    mEXPENSES=EXPENSES
  endif
  @ Y_max, 2 say '██████████████'
  if mark != 0
    setcolor(cl)
    @ Y_max, 2 say "Помечено "+ltrim(str(Mark))
    setcolor(c)
  endif
case mode = 3
case mode = 4
do case
case (Last_User =  7).or.(lastkey()=   7)       && DEL
  DelMT()
case (Last_User = 32).or.(lastkey() = 32)       && SPACE
  if delete()
    recall
    Mark=Mark-1
  else
    delete
    Mark=Mark+1
  endif
  RETR=2
case (Last_User = 22).or.(lastkey() = 22)       && INS
  RecExpMT(Y_srm-9,X_srm-25,Y_srm+8,X_srm+26)
case (Last_User = 13).or.(lastkey() = 13)       && ENTER
  InpMT(Y_srm-11,X_srm-32,Y_srm+11,X_srm+32)
case (Last_User = -2).or.(lastkey() = -2)       && F3
  SummaMT(Y_srm-9,X_srm-32,Y_srm+9,X_srm+32)
case (Last_User = -3).or.(lastkey() = -3)       && F4
  OborITOG(Y_srm-5,X_srm-20,Y_srm+5,X_srm+19)
case (Last_User = -4).or.(lastkey() = -4)       && F5
  FindMT(fld_ptr,Y_srm-2,X_srm-30,Y_srm+2,X_srm+30)
case (Last_User = -5).or.(lastkey() = -5)       && F6
  InpFilter(Y_srm-3,X_srm-30,Y_srm+SIZE_FILTER,X_srm+30)
case (Last_User = -6).or.(lastkey() = -6)       && F7
  select 9
  use &cur_config
  var_exp=DictFind(0,"D1","str(D1)+' '+D2","Выбеpите счет","BALANS.DIC","BALANS.NTX")
  if lastkey()!=27.and.var_exp!=I->BALANS
    repl I->BALANS with var_exp
    RETR=0
  endif
  use &new_config
  select 1
case (Last_User = -7).or.(lastkey() = -7)       && F8
  InpMonth()
case (Last_User = -8).or.(lastkey() = -8)       && F9
  Tune(Y_srm-6,X_srm-30,Y_srm+6,X_srm+30)
case (Last_User = -9).or.(lastkey() = -9)       && F10
  MenuMain()
case (Last_User = 45).or.(lastkey() = 45)       && -
  SeleMT(.F.,fld_ptr,Y_srm-3,X_srm-30,Y_srm+3,X_srm+30)
case (Last_User = 43).or.(lastkey() = 43)       && +
  SeleMT(.T.,fld_ptr,Y_srm-3,X_srm-30,Y_srm+3,X_srm+30)
case (Last_User = 27).or.(lastkey() = 27)       && ESC
  if Fragen(' В Ы Х О Д ','Завершить работу с программой?')
    PrgExit=.F.
    RETR=0
  endif
endcase
endcase
enddo
return RETR
*---------------------------------------------------------*
procedure CreateDBF
select 1
name_DBF=new_path+"\"+MainDBF
name_STR=cur_path+"\"+MainSTR
if .not.file(name_DBF)
  creat &name_DBF from &name_STR
endif
if SIZE_DICT != 0
  for i=1 to SIZE_DICT
    if dict_path[i]
      name_dbf=cur_path+"\"+dict_dbf[i]
    else
      name_dbf=new_path+"\"+dict_dbf[i]
    endif
    if .not.file(name_dbf)
      name_str=cur_path+"\"+dict_str[i]
      creat &name_dbf from &name_str
    endif
  next
endif
return
*---------------------------------------------------------*
procedure OpenDBF
select 1
name_DBF=new_path+"\"+MainDBF
use &name_DBF
return
*---------------------------------------------------------*
procedure CreateNTX
parameters log
private old_color,old_select
old_color = setcolor()
save screen
if SIZE_INDX != 0
  for i=1 to SIZE_INDX
    name_NTX=new_path+"\"+index_ntx[i]
    if (.not.file(name_NTX)).or.log
      name_key = index_key[i]
      setcolor(cw)
      BoxTenj(Y_srm-2,X_srm-10,Y_srm+2,X_srm+10,ibox)
      setcolor(cl)
      @ Y_srm-2,X_srm-5 say 'Сортирую...'
      setcolor(cw)
      @ Y_srm,int(X_srm-len(index_ntx[i])/2) say index_ntx[i]
      index on &name_key to &name_NTX
    endif
  next
  go top
endif
if SIZE_DICT != 0
  old_select=select()
  select 8
  for i=1 to SIZE_DICT
    if .not.empty(dict_ntx[i])
      if dict_path[i]
       name_dbf=cur_path+"\"+dict_dbf[i]
       name_NTX=cur_path+"\"+dict_ntx[i]
      else
       name_dbf=new_path+"\"+dict_dbf[i]
       name_NTX=new_path+"\"+dict_ntx[i]
      endif
      if .not.file(name_NTX).or.log
        name_key=dict_key[i]
        setcolor(cw)
        BoxTenj(Y_srm-2,X_srm-10,Y_srm+2,X_srm+10,ibox)
        setcolor(cl)
        @ Y_srm-2,X_srm-5 say 'Сортирую...'
        setcolor(cw)
        @ Y_srm,int(X_srm-len(dict_ntx[i])/2) say dict_ntx[i]
        use &name_dbf
        index on &name_key to &name_NTX
        use
      endif
    endif
  next
  select(old_select)
endif
restore screen
setcolor(old_color)
return
*---------------------------------------------------------*
procedure OpenNTX
if SIZE_INDX = 0
  return
endif
for i=1 to SIZE_INDX
  ch = ltrim(str(i))
  Fl_NTX&ch = new_path+"\"+index_ntx[i]
next
do case
case SIZE_INDX=1
  set index to &Fl_NTX1
case SIZE_INDX=2
  set index to &Fl_NTX1,&Fl_NTX2
case SIZE_INDX=3
  set index to &Fl_NTX1,&Fl_NTX2,&Fl_NTX3
case SIZE_INDX=4
  set index to &Fl_NTX1,&Fl_NTX2,&Fl_NTX3,&Fl_NTX4
case SIZE_INDX=5
  set index to &Fl_NTX1,&Fl_NTX2,&Fl_NTX3,&Fl_NTX4,&Fl_NTX5
endcase
set order to I->REGIM_SORT
return
*---------------------------------------------------------*
procedure DrawMT
set color to &c
DrawBox(Y_min,X_min,Y_max,X_max,ibox)
DrawDate()
set color to &c
@  1, 3 say 'Подразделение'
@  2, 3 say 'Приходный счет'
@  3, 3 say 'Расходный счет'
@  4, 1 to 4,78 double
set color to &cl
@ Y_max,X_min+64 say '║ F10 - Меню ║'
InitFilter()
set color to &c
return
*---------------------------------------------------------*
procedure DrawDate
set color to &c
@ Y_min,X_min say replicate("█",80)
set color to &cl
if empty(I->T_DATE)
 repl I->T_DATE with date()
endif
MSG='Обоpотная ведомость по балансовому счету '+intnum(tBALANS)+' за '+alltrim(Month[month(I->T_DATE)])+" "+str(year(I->T_DATE),4)+"г."
@ Y_min,int(X_srm-len(MSG)/2) say MSG
return
*---------------------------------------------------------*
procedure InitFilter
setcolor(c)
@ Y_max-2,X_min say replicate('█',80)
@ Y_max-1,X_min+1 say replicate(' ',78)
setcolor(cl)
MSG=' В Ы Б О Р К А '
@ Y_max-2,int(X_srm-len(MSG)/2) say MSG
name_filter=alltrim(I->L_FILTER)
if empty(name_filter).or.SIZE_FILTER=0
  set filter to
else
  set filter to &name_filter
endif
go top
MSG=alltrim(I->N_FILTER)
setcolor(c)
@ Y_max-1,int(X_srm-len(MSG)/2)+1 say MSG
return
*---------------------------------------------------------*
function CloseDBF
MarkRecall()
select 1
use
return " "
*---------------------------------------------------------*
function MarkRecall
if Mark # 0
  save screen
  MsgWrite('Удаляю метки...')
  recall for delete()
  Mark = 0
  restore screen
endif
return " "
