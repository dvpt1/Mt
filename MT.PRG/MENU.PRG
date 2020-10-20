*---------------------------------------------------------*
procedure InitMenu
public Level1,Level2_1,Level2_2,Level2_3,Level2_4,Level2_5,Level2_6
store 1 to Level1,Level2_1,Level2_2,Level2_3,Level2_4,Level2_5,Level2_6
return
*---------------------------------------------------------*
function MenuMain
private old_color
old_color = setcolor()
save screen to OnePage
RETR=1
level=1
set color to &cmenu
BoxTenj(Y_min,X_min+5,Y_min+2,X_max-5,'╔═╗║╝═╚║ ')
otwet1=Level1
do while (otwet1 != 0)
  set color to &cmenu
  @ Y_min+1, 7    prompt " Учет "
  @ row(),col()+4 prompt " Словарь "
  @ row(),col()+4 prompt " Индекс "
  @ row(),col()+4 prompt " Печать "
  @ row(),col()+4 prompt " Сервис "
  @ row(),col()+4 prompt " Архив "
  do OnKeyMenuP
  menu to otwet1
  do OfKeyMenuP
  save scre to TwoPage
  do case
  case otwet1=1
    MenuAcco(Y_min+2,X_min+6,Y_min+12,X_max-50)
  case otwet1=2
    MenuDict(Y_min+2,X_min+16,Y_min+7,X_max-42)
  case otwet1=3
    MenuIndex(Y_min+2,X_min+29,Y_min+8,X_max-27)
  case otwet1=4
    MenuPrint(Y_min+2,X_min+41,Y_min+6,X_max-27)
  case otwet1=5
    MenuRegim(Y_min+2,X_min+50,Y_min+12,X_max-7)
  case otwet1=6
    MenuArhiv(Y_min+2,X_min+58,Y_min+7,X_max-6)
  endcase
  if otwet1!=0
    Level1=otwet1
  endif
  rest scre from TwoPage
enddo
restore screen from OnePage
set color to (old_color)
return " "
*---------------------------------------------------------*
function MenuAcco
parameters Y1,X1,Y2,X2
set color to &cmenu
BoxTenj(Y1,X1,Y2,X2,'╤═╤│┘─└│ ')
level=2
otwet2=Level2_1
do while (otwet2 != 0)
  set color to &cmenu
  @ Y1+1,   X1+1 prompt " Приход/Расход  {INS} "
  @ row()+1,X1+1 prompt " Корректировка        "
  @ row()+1,X1+1 prompt " Сумма           {F3} "
  @ row()+1,X1+1 prompt " Итого оборот    {F4} "
  @ row()+1,X1+1 prompt " Удаление       {DEL} "
  @ row()+1,X1+1 prompt " Балансовый счет {F7} "
  @ row()+1,X1+1 prompt " Дата            {F8} "
  @ row()+1,X1   say   "├──────────────────────┤"
  @ row()+1,X1+1 prompt " Выход                "
  do OnKeyMenuD
  menu to otwet2
  do OfKeyMenuD
  Save Screen to TrePage
  do case
  case otwet2=1
    Last_User=22
  case otwet2=2
    Last_User=13
  case otwet2=3
    Last_User=-2
  case otwet2=4
    Last_User=-3
  case otwet2=5
    Last_User= 7
  case otwet2=6
    Last_User=-6
  case otwet2=7
    Last_User=-7
  case otwet2=8
    Last_User=27
  endcase
  if otwet2!=0
    Level2_1=otwet2
    Retr_User=.T.
    keyboard chr(27)+chr(27)
  endif
  Restore Screen from TrePage
enddo
return " "
*---------------------------------------------------------*
function MenuDict
parameters Y1,X1,Y2,X2
private old_select,name_str,name_dbf,name_ntx
set color to &cmenu
BoxTenj(Y1,X1,Y2,X2,'╤═╤│┘─└│ ')
level=2
otwet2=Level2_2
do while (otwet2 != 0)
  set color to &cmenu
  @ Y1,X1+1 say ''
  for i=1 to SIZE_DICT
    @ row()+1,X1+1 prompt dict_prm[i]
  next
  do OnKeyMenuD
  menu to otwet2
  do OfKeyMenuD
  Save Screen to TrePage
  if otwet2!=0
    old_select=select()
    set color to &c
    DrawBox(Y_min,X_min,Y_max,X_max,ibox)
    set color to &cl
    MSG=" С Л О В А Р Ь "+'"'+alltrim(dict_prm[otwet2])+'"'
    @ Y_min,int((X_min+X_max)/2-len(MSG)/2) say MSG
    MenuGloss()
    set color to &c
    select 8
    name_str=dict_str[otwet2]
    use &name_str
    j=lastrec()
    declare dict_fld[j]
    declare dict_nam[j]
    for i=1 to j
     if H->FIELD_TYPE!="L"
      dict_fld[i]=alltrim(H->FIELD_NAME)
     else
      dict_fld[i]="iif("+alltrim(H->FIELD_NAME)+",'ДА ','HЕТ')"
     endif
     dict_nam[i]=alltrim(H->NAME_FIELD)
     skip
    next
    name_dbf=dict_dbf[otwet2]
    use &name_dbf
    if .not.empty(dict_ntx[otwet2])
      name_ntx=dict_ntx[otwet2]
      set index to &name_ntx
    endif
    dbedit(Y_min+1,X_min+1,Y_max-1,X_max-1,dict_fld,"GlossFunc","",dict_nam,.T.,.T.,"─┴─")
    use
    select(old_select)
  endif
  if otwet2!=0
    Level2_2=otwet2
  endif
  Restore Screen from TrePage
enddo
return " "
*---------------------------------------------------------*
function MenuIndex
parameters Y1,X1,Y2,X2
set color to &cmenu
BoxTenj(Y1,X1,Y2,X2,'╤═╤│┘─└│ ')
level=2
otwet2=Level2_3
do while (otwet2 != 0)
  set color to &cmenu
  @ Y1+1,   X1+1 prompt " Сортировать все ...  "
  @ row()+1,X1   say   "├──────────────────────┤"
  @ row()+1,X1+1 prompt " "+iif(indexord()=0,"√","-")+" поступлению        "
  if SIZE_INDX != 0
    for i=1 to SIZE_INDX
      @ row()+1,X1+1 prompt " "+iif(indexord()=i,"√","-")+index_prm[i]
    next
  endif
  do OnKeyMenuD
  menu to otwet2
  do OfKeyMenuD
  Save Screen to TrePage
  do case
  case otwet2=1
    CreateNTX(.T.)
    OpenNTX()
  othe
    if otwet2 != 0
      repl I->REGIM_SORT with (otwet2-2)
      set order to I->REGIM_SORT
    endif
  endcase
  if otwet2 != 0
    Level2_3=otwet2
    RETR=2
    keyboard chr(27)+chr(27)
  endif
  Restore Screen from TrePage
enddo
return " "
*---------------------------------------------------------*
function MenuPrint
parameters Y1,X1,Y2,X2
set color to &cmenu
BoxTenj(Y1,X1,Y2,X2,'╤═╤│┘─└│ ')
level=2
otwet2=Level2_4
do while (otwet2 != 0)
  set color to &cmenu
  @ Y1+1,   X1+1 prompt " Оборота  "
  @ row()+1,X1+1 prompt " Баланса  "
  @ row()+1,X1+1 prompt " Карточки "
  do OnKeyMenuD
  menu to otwet2
  do OfKeyMenuD
  Save Screen to TrePage
  do case
  case otwet2=1
    OborLPT1()
  case otwet2=2
    SvodLPT1()
  case otwet2=3
    AccoLPT1()
  endcase
  if otwet2!=0
    Level2_4=otwet2
  endif
  Restore Screen from TrePage
enddo
return " "
*---------------------------------------------------------*
function MenuRegim
parameters Y1,X1,Y2,X2
set color to &cmenu
BoxTenj(Y1,X1,Y2,X2,'╤═╤│┘─└│ ')
level=2
otwet2=Level2_5
do while (otwet2 != 0)
  set color to &cmenu
  @ Y1+1,   X1+1 prompt " Hемного обо мне...  "
  @ row()+1,X1   say   "├─────────────────────┤"
  @ row()+1,X1+1 prompt " Калькулятор    {Tab}"
  @ row()+1,X1+1 prompt " Искать          {F5}"
  @ row()+1,X1+1 prompt " Выбрать         {F6}"
  @ row()+1,X1+1 prompt " Заселектировать  {+}"
  @ row()+1,X1+1 prompt " Разселектировать {-}"
  @ row()+1,X1   say   "├─────────────────────┤"
  @ row()+1,X1+1 prompt " Настройка       {F9}"
  do OnKeyMenuD
  menu to otwet2
  do OfKeyMenuD
  Save Screen to TrePage
  do case
  case otwet2=1
    DrawTitle()
  case otwet2=2
    do Calculator
  case otwet2=3
    Last_User=-4
  case otwet2=4
    Last_User=-5
  case otwet2=5
    Last_User=43
  case otwet2=6
    Last_User=45
  case otwet2=7
    Last_User=-8
  endcase
  if otwet2!=0.and.otwet2!=1.and.otwet2!=2
    Level2_5=otwet2
    Retr_User=.T.
    keyboard chr(27)+chr(27)
  endif
  Restore Screen from TrePage
enddo
return " "
*---------------------------------------------------------*
function MenuArhiv
parameters Y1,X1,Y2,X2
set color to &cmenu
BoxTenj(Y1,X1,Y2,X2,'╤═╤│┘─└│ ')
level=2
otwet2=Level2_6
do while (otwet2 != 0)
  set color to &cmenu
  @ Y1+1,   X1+1 prompt " сохранить    "
  @ row()+1,X1+1 prompt " восстановить "
  @ row()+1,X1+1 prompt " пеpеключить  "
  @ row()+1,X1+1 prompt " удалить      "
  do OnKeyMenuD
  menu to otwet2
  do OfKeyMenuD
  Save Screen to TrePage
  do case
  case otwet2=1
    SaveArhiv()
  case otwet2=2
    LoadArhiv()
  case otwet2=3
    OldArhiv()
  case otwet2=4
    DelArhiv()
  endcase
  if otwet2!=0.and.RETR=0
    Level2_6=otwet2
    keyboard chr(27)+chr(27)
  endif
  Restore Screen from TrePage
enddo
return " "

*---------------------------------------------------------*
procedure OnKeyMenuP
set key 43 to PlusKey
set key 45 to MinusKey
set key 22 to InsKey
set key  7 to DelKey
set key 32 to SpaceKey
set key -2 to F3Key
set key -3 to F4Key
set key -4 to F5Key
set key -5 to F6Key
set key -6 to F7Key
set key -7 to F8Key
return
*---------------------------------------------------------*
procedure OfKeyMenuP
set key 43 to
set key 45 to
set key 22 to
set key  7 to
set key 32 to
set key -2 to
set key -3 to
set key -4 to
set key -5 to
set key -6 to
set key -7 to
return
*---------------------------------------------------------*
procedure OnKeyMenuD
set key 19 to LeftKeyMenu
set key  4 to RightKeyMenu
set key 43 to PlusKey
set key 45 to MinusKey
set key 22 to InsKey
set key  7 to DelKey
set key 32 to SpaceKey
set key -2 to F3Key
set key -3 to F4Key
set key -4 to F5Key
set key -5 to F6Key
set key -6 to F7Key
set key -7 to F8Key
return
*---------------------------------------------------------*
procedure OfKeyMenuD
set key 19 to
set key  4 to
set key 43 to
set key 45 to
set key 22 to
set key  7 to
set key 32 to
set key -2 to
set key -3 to
set key -4 to
set key -5 to
set key -6 to
set key -7 to
return
*---------------------------------------------------------*
procedure LeftKeyMenu
keyboard chr(27) + chr(19) + chr(13)
return
*---------------------------------------------------------*
procedure RightKeyMenu
keyboard chr(27) + chr(4) + chr(13)
return
*---------------------------------------------------------*
procedure PlusKey
Last_User=43
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure MinusKey
Last_User=45
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure InsKey
Last_User= 22
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure DelKey
Last_User= 7
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure F1Key
Last_User= 28
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure F2Key
Last_User= -1
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure F3Key
Last_User= -2
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure F4Key
Last_User= -3
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure F5Key
Last_User= -4
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure F6Key
Last_User= -5
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure F7Key
Last_User= -6
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure F8Key
Last_User= -7
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
*---------------------------------------------------------*
procedure SpaceKey
Last_User= 32
Retr_User=.T.
do case
  case level=1
    keyboard chr(27)
  case level=2
    keyboard chr(27)+chr(27)
endcase
return
