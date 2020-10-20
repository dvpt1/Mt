*---------------------------------------------------------*
procedure InpFilter
parameters Y1,X1,Y2,X2
private var_fld,var_prm,is_var
private fil_string,type_var
private otwet
private old_color
private del_filter
del_filter=.F.
old_color = setcolor()
save screen to InpPage
set color to &cfr
BoxTenj(Y1,X1,Y2,X2,ibox)
set color to &cl
MSG=' В Ы Б О Р К А '
@ Y1,int((X1+X2)/2-len(MSG)/2) say MSG
set color to &cl
@ Y2,X1+1 say ' М Е Н Ю: '
set color to &cmenu
MSG='Enter'
@ row(),col() get MSG
@ row(),col() say 'Ввод'
MSG='DEL'
@ row(),col() get MSG
@ row(),col() say 'Удалить'
MSG='ESC'
@ row(),col() get MSG
@ row(),col() say 'Выход'
clear gets
declare var_filter[SIZE_FILTER]  && Массив ключей фильтра
fil_string=alltrim(I->L_FILTER)  && Разбор строки фильтра
fil_string=strtran(fil_string,".and.","    ")
for i=1 to SIZE_FILTER
  var_filter[i]=psubstr(fil_string,i)
  var_filter[i]=strtran(var_filter[i],filter_fld[i])
  var_filter[i]=strtran(var_filter[i],"=")
  var_fld=filter_fld[i]
  type_var=&var_fld
  do case
  case type("type_var")="C"
    var_filter[i]=strtran(var_filter[i],'"')
  case type("type_var")="N"
    var_filter[i]=val(var_filter[i])
    var_filter[i]=val(transform(var_filter[i],pictn(type_var)))  && для форматирования
  case type("type_var")="D"
    var_filter[i]=strtran(var_filter[i],"ctod()")
    var_filter[i]=strtran(var_filter[i],'"')
    var_filter[i]=ctod(var_filter[i])
  case type("type_var")="L"
    if var_filter[i]="()"     && "(.not.)"
      var_filter[i]=strtran(filter_iif[i],filter_fld[i],".T.")
    else
      var_filter[i]=strtran(filter_iif[i],filter_fld[i],".F.")
    endif
  endcase
next
otwet=1
do while otwet!=0   && Собственно меню выбора нового фильтра
  set color to &cfr
  for i=1 to SIZE_FILTER
    @ Y1+i+1,X1+2 say filter_nam[i]
    do case
    case .not.empty(filter_dbf[i])
      var_prm=mDict(filter_scr[i],var_filter[i],filter_cod[i],filter_dbf[i],filter_ntx[i])
    case .not.empty(filter_iif[i])
      var_fld=var_filter[i]
      var_prm=&var_fld
    othe
      var_prm=var_filter[i]
    endcase
    @ row(),col()+1 prompt varstr(var_prm)
  next
  set key 7 to DelFilter
  menu to otwet
  set key 7 to
  if otwet != 0
    do case
    case .not.empty(filter_dbf[otwet])
      var_filter[otwet]=DictFind(var_filter[otwet],filter_cod[otwet],filter_scr[otwet],;
                        filter_nam[otwet],filter_dbf[otwet],filter_ntx[otwet])
    case .not.empty(filter_iif[otwet])
      if var_filter[otwet]="iif(.T.,"
        var_filter[otwet]=strtran(var_filter[otwet],"iif(.T.,","iif(.F.,")
      else
        var_filter[otwet]=strtran(var_filter[otwet],"iif(.F.,","iif(.T.,")
      endif
    othe
      set cursor on
      @ Y1+otwet+1,X1+3+len(filter_nam[otwet]) get var_filter[otwet]
      read
      set cursor off
    endcase
  endif
enddo
MSG=""          && Строка названия фильтра
fil_string=""   && Строка логического выражения фильтра
if .not.del_filter
is_var=.F.
for i=1 to SIZE_FILTER
  if .not.empty(var_filter[i])
  if i != 1.and.is_var
    fil_string=fil_string+".and."
    MSG=MSG+"  "
  endif
  is_var=.T.
  var_fld=filter_fld[i]
  type_var=&var_fld
  do case
  case type("type_var")="C"
    fil_string=fil_string+filter_fld[i]+"="+'"'+var_filter[i]+'"'
  case type("type_var")="N"
    fil_string=fil_string+filter_fld[i]+"="+ltrim(str(var_filter[i]))
  case type("type_var")="D"
    fil_string=fil_string+filter_fld[i]+"="+"ctod("+"'"+dtoc(var_filter[i])+"'"+")"
  case type("type_var")="L"
    if var_filter[i]="iif(.T.,"
      fil_string=fil_string+"("+filter_fld[i]+")"
    else
      fil_string=fil_string+"(.not."+filter_fld[i]+")"
    endif
  endcase
  if .not.empty(var_filter[i])
  do case
  case .not.empty(filter_dbf[i])
    var_fld=mDict(filter_scr[i],var_filter[i],filter_cod[i],filter_dbf[i],filter_ntx[i])
  case .not.empty(filter_iif[i])
    var_fld=var_filter[i]
    var_fld=&var_fld
  othe
    var_fld=var_filter[i]
  endcase
  do case
  case type("var_fld")="C"
    MSG=MSG+'"'+alltrim(var_fld)+'"'
  case type("var_fld")="N"
    MSG=MSG+ltrim(str(var_fld))
  case type("var_fld")="D"
    MSG=MSG+dtoc(var_fld)
  case type("var_fld")="L"
    MSG=MSG+'"'+alltrim(var_fld)+'"'
  endcase
  endif
  endif
next
endif
restore screen from InpPage
if fil_string!=I->L_FILTER.or.del_filter        && Если фильтр изменен
  replace I->L_FILTER with fil_string
  replace I->N_FILTER with MSG
  MarkRecall()
  InitFilter()
  RETR=0
endif
set color to &old_color
return
*---------------------------------------------------------*
procedure DelFilter
del_filter=.T.
keyboard chr(27)
return
*---------------------------------------------------------*
procedure InpMonth
parameters Y1,X1,Y2,X2
private old_color,ch,otwet,ptr,old_date,old_select,old_filter,j,i,new_ptr
old_color=setcolor(cw)
save screen to InpPage
DrawBox(Y_min,X_max-24,Y_min+2,X_max,ibox)
setcolor(cl)
MSG=' ТЕКУЩАЯ ДАТА '
@ Y_min,int((X_max-24+X_max)/2-len(MSG)/2) say MSG
??chr(7)
old_date=I->T_DATE
ptr=month(I->T_DATE)
if ptr=0
 ptr=1
endif
ch=str(year(I->T_DATE),4)
otwet=1
do while otwet!=0
  setcolor(cw)
  @ Y_min+1,X_max-19 prompt Month[ptr]
  @ row(),col()+1 prompt ch
  @ row(),col() say " г."
  menu to otwet
  if otwet != 0
    do case
    case otwet=1
      save screen
      setcolor(cdict)
      BoxTenj(Y_min+1,X_max-20,Y_min+14,X_max-11,ibox)
      new_ptr=achoice(Y_min+2,X_max-19,Y_min+13,X_max-12,month,"","",ptr)
      if new_ptr != 0
        ptr=new_ptr
      endif
      rest screen
    case otwet=2
      set cursor on
      @ Y_min+1,X_max-19+len(Month[month(I->T_DATE)])+1 get ch picture '####'
      read
      set cursor off
    endcase
  endif
enddo
if old_date != ctod("01."+str(ptr,2)+"."+ch)
  nm=month(I->T_DATE)
  setcolor(old_color)
  restore screen from InpPage
  DrawDate(Y_min,X_max-24,Y_min+2,X_max)
  save screen to InpPage
  restore screen from InpPage
  if Fragen('','Будем переводить ЛС на новый месяц?')
    restore screen from InpPage
    MsgWrite("Ж д и т е . . .  Перевожу все ЛС на новый месяц...")
    CloseDBF()  && закрываю старый месяц
    select 9
    use &cur_config
    repl I->T_DATE with ctod("01."+str(ptr,2)+"."+ch)
    cur_date=cur_path+"\"+str(year(I->T_DATE),4)+"."+strtran(str(month(I->T_DATE),2)," ","0")
    mkdir(cur_date)
    tBALANS=I->BALANS
    old_path = new_path
    new_path=cur_date+"\MT"+intnum(I->BALANS)
    new_config=new_path+"\config.mt"
    use
    mkdir(new_path)
    set path to &new_path
    deles("*.*",new_path)
    copys("*.*",old_path,new_path)
    select 9
    if .not.file(new_config)
      copy file &cur_config to &new_config
    endif
    use &new_config
    repl I->T_DATE with ctod("01."+str(ptr,2)+"."+ch)
    OpenDBF()   && откpываю новый месяц
    OpenNTX()
    select 1
    set filter to
    go top
    dMATERIAL=""
    dMEAS=""
    do while .not.eof()
      repl BEGNUM with ENDNUM
      repl BEGSUM with ENDSUM
      repl RECNUM with 0
      repl RECSUM with 0
      repl EXPNUM with 0
      repl EXPSUM with 0
      skip
    enddo
    name1_DBF=new_path+"\temp.dbf"
    name_NTX=new_path+"\temp.ntx"
    index on str(DIVISION)+MATERIAL to &name_NTX
    total on str(DIVISION)+MATERIAL fields BEGNUM,BEGSUM,ENDNUM,ENDSUM to &name1_DBF
    CloseDBF()
    name2_DBF=new_path+"\"+MainDBF
    dele file &name2_DBF
    rename &name1_DBF to &name2_DBF
    dele file &name_NTX
    OpenDBF()
    delete for BEGNUM=0
    pack
    CreateNTX(.T.)
    OpenNTX()
    InitFilter()
    RETR=0
  endif
endif
restore screen from InpPage
setcolor(old_color)
return
*---------------------------------------------------------*
function FindMT
parameters fld_ptr,Y1,X1,Y2,X2
private var_find,var_fld,otwet
private old_color,old_index
old_color = setcolor()
save screen to InpPage
set color to &cfr
BoxTenj(Y1,X1,Y2,X2,ibox)
set color to &cl
MSG='  И С К А Т Ь '
@ Y1,int((X1+X2)/2-len(MSG)/2) say MSG
set color to &cfr
var_fld=jour_fld[fld_ptr]
var_find=nulvar(&var_fld)
@ Y1+2,X1+2 say jour_nam[fld_ptr]
do case
case .not.empty(jour_dbf[fld_ptr])
  var_find=DictFind(var_find,jour_cod[fld_ptr],jour_scr[fld_ptr],;
           jour_nam[fld_ptr],jour_dbf[fld_ptr],jour_ntx[fld_ptr])
case .not.empty(jour_iif[fld_ptr])
  var_fld=jour_jou[fld_ptr]
  var_fld=strtran(var_fld,jour_fld[fld_ptr],"var_find")
  otwet=1
  var_find=.T.
  @ row(),col()+2 prompt &var_fld
  var_find=.F.
  @ row(),col()+2 prompt &var_fld
  menu to otwet
  if otwet=1
    var_find=.T.
  else
    var_find=.F.
  endif
othe
  set cursor on
  @ row(),col()+2 get var_find
  read
  set cursor off
endcase
if lastkey() != 27
  MsgWrite("Сейчас поищем...")
  Nz=recno()
  log=0   && Есть ли индекс по этому полю
  if SIZE_INDX != 0
    for i=1 to SIZE_INDX
      if jour_fld[fld_ptr]==index_key[i]
        log=i
      endif
    next
  endif
  old_index=indexord()
  set order to log
  var_fld=jour_fld[fld_ptr]
  if indexord() != 0
    if type("var_find")="C"
      set softseek on
      seek var_find
      set softseek off
    else
      seek var_find
    endif
  else
    if type("var_find")="L"
      if var_find
        locate for &var_fld
      else
        locate for .not.&var_fld
      endif
    else
      locate for &var_fld.=var_find
    endif
  endif
  if found().or.(&var_fld.=var_find)
    RETR=2
  else
    ??chr(7)
    WarnWrite("Поиск не удачен...")
    go Nz
    RETR=1
  endif
  set order to old_index
endif
restore screen from InpPage
set color to &old_color
return " "
*---------------------------------------------------------*
procedure DelMT
save screen
if Yes_Or_No(' У Д А Л И Т Ь ','Лицевые счета?',2)
  MsgWrite("Ждите... Удаляю...")
  if Mark=0
    delete
  else
    Mark=0
  endif
  pack
  go top
  RETR=2
else
  RETR=1
endif
restore screen
return
*---------------------------------------------------------*
function SeleMT
parameters log,fld_ptr,Y1,X1,Y2,X2
if fld_ptr = 1
  WarnWrite("По полю метки селектирование не осуществляется...")
  RETR=1
  return " "
endif
private var_sele1,var_sele2,var_fld,var_num,otwet
private old_color
old_color = setcolor()
save screen to InpPage
set color to &cfr
BoxTenj(Y1,X1,Y2,X2,ibox)
set color to &cl
if log
  MSG=' З А С Е Л Е К Т И Р О В А Т Ь '
else
  MSG=' Р А З С Е Л Е К Т И Р О В А Т Ь '
endif
@ Y1,int((X1+X2)/2-len(MSG)/2) say MSG
set color to &cfr
var_fld=jour_fld[fld_ptr]
var_sele1=nulvar(&var_fld)
var_sele2=var_sele1
do case
case .not.empty(jour_dbf[fld_ptr])
  @ Y1+2,X1+2 say jour_nam[fld_ptr]+" для "
  var_sele1=DictFind(var_sele1,jour_cod[fld_ptr],jour_scr[fld_ptr],;
           jour_nam[fld_ptr],jour_dbf[fld_ptr],jour_ntx[fld_ptr])
case .not.empty(jour_iif[fld_ptr])
  @ Y1+2,X1+2 say jour_nam[fld_ptr]+" для "
  var_fld=jour_jou[fld_ptr]
  var_fld=strtran(var_fld,jour_fld[fld_ptr],"var_sele1")
  otwet=1
  var_sele1=.T.
  @ row(),col()+2 prompt &var_fld
  var_sele1=.F.
  @ row(),col()+2 prompt &var_fld
  menu to otwet
  if otwet=1
    var_sele1=.T.
  else
    var_sele1=.F.
  endif
othe
  set cursor on
  @ Y1+2,X1+2 say jour_nam[fld_ptr]+" с "
  @ row(),col() get var_sele1
  @ Y1+4,X1+2+len(jour_nam[fld_ptr]) say "по "
  @ row(),col() get var_sele2
  read
  set cursor off
endcase
if lastkey() != 27
  if log
    MsgWrite("Сейчас заселектируем...")
  else
    MsgWrite("Сейчас разселектируем...")
  endif
  Nz=recno()
  go top
  var_fld=jour_fld[fld_ptr]
  if empty(var_sele2)
    var_sele2=var_sele1
  endif
  if log
    if type("var_sele1")="L"
      do while .not.eof()
        if iif(var_sele1,&var_fld.,.not.&var_fld)
          if .not.delete()
            delete
            Mark=Mark+1
          endif
        endif
        skip
      enddo
    else
      do while .not.eof()
        if &var_fld.>=var_sele1.and.&var_fld.<=var_sele2
          if .not.delete()
            delete
            Mark=Mark+1
          endif
        endif
        skip
      enddo
    endif
  else
    if type("var_sele1")="L"
      do while .not.eof()
        if iif(var_sele1,&var_fld.,.not.&var_fld)
          if delete()
            recall
            Mark=Mark-1
          endif
        endif
        skip
      enddo
    else
      do while .not.eof()
        if &var_fld.>=var_sele1.and.&var_fld.<=var_sele2
          if delete()
            recall
            Mark=Mark-1
          endif
        endif
        skip
      enddo
    endif
  endif
  go Nz
  RETR=2
else
  RETR=1
endif
restore screen from InpPage
set color to &old_color
return " "
*---------------------------------------------------------*
function GlossFunc
parameters mode,fld_ptr
private cur_field,key_last
key_last=LASTKEY()
do case
case mode <= 3
  return 1
case LASTKEY() = 27
  return 0
case LASTKEY() = 13.or.isdata(key_last)
  if key_last <> 13
     keyboard chr(key_last)
  endif
  set cursor on
  cur_field=dict_fld[fld_ptr]
  if cur_field="iif("
   repl D3 with !D3
   clear typeahead
  else
   @ row(),col() get &cur_field
   read
  endif
  set cursor off
  return 2
case lastkey() = 22        && Ins
  append blank
  return 2
case lastkey() = -4        && F5
  PrintGloss()
case lastkey() = -5        && F6
  FindGloss(fld_ptr,Y_srm-2,X_srm-30,Y_srm+2,X_srm+30)
  return 2
case lastkey() = 7         && Del
  DelGloss()
  return 2
endcase
return 1
*---------------------------------------------------------*
function MenuGloss
set color to &cl
@ Y_max,X_min+8 say ' М Е Н Ю: '
set color to &cmenu
MSG='INS'
@ row(),col() get MSG
@ row(),col() say 'Создать'
MSG='Enter'
@ row(),col() get MSG
@ row(),col() say 'Ввод'
MSG='F5'
@ row(),col() get MSG
@ row(),col() say 'Печать'
MSG='F6'
@ row(),col() get MSG
@ row(),col() say 'Искать'
MSG='DEL'
@ row(),col() get MSG
@ row(),col() say 'Удалить'
MSG='ESC'
@ row(),col() get MSG
@ row(),col() say 'Выход'
clear gets
return " "
*---------------------------------------------------------*
function FindGloss
parameters fld_ptr,Y1,X1,Y2,X2
private var_find,var_fld,otwet
private old_color
old_color = setcolor()
save screen to InpPage
set color to &cfr
BoxTenj(Y1,X1,Y2,X2,ibox)
set color to &cl
MSG=' И С К А Т Ь '
@ Y1,int((X1+X2)/2-len(MSG)/2) say MSG
set color to &cfr
var_fld=dict_fld[fld_ptr]
var_find=nulvar(&var_fld)
@ Y1+2,X1+2 say dict_nam[fld_ptr]
set cursor on
@ row(),col()+2 get var_find
read
set cursor off
if lastkey() != 27
  MsgWrite("Сейчас поищем...")
  Nz=recno()
  if type("var_find")="L"
    if var_find
      locate for &var_fld
    else
      locate for .not.&var_fld
    endif
  else
    locate for var_find=&var_fld
  endif
  if .not.found()
    ??chr(7)
    WarnWrite("Поиск не удачен...")
    go Nz
  endif
endif
restore screen from InpPage
set color to &old_color
return " "
*---------------------------------------------------------*
procedure DelGloss
save screen
if Yes_Or_No(' У Д А Л И Т Ь ','Текущую запись?',2)
  MsgWrite("Ждите... Удаляю...")
  if otwet2=5
    DeleteDir()
  else
    delete
    pack
    go top
  endif
endif
restore screen
return
*---------------------------------------------------------*
procedure DeleteDir
del_path=cur_path+"\MT"+intnum(D1)
old_path=getdir()
if .not.(old_path==del_path)
  if chdir(del_path)
    acount=adir("*.*")
    if acount != 0
     declare aFiles[acount]
     adir("*.*", aFiles)
     for i=1 to acount
      ch=aFiles[i]
      dele file &ch
     next
    endif
    chdir(cur_path)
    rmdir(del_path)
    chdir(old_path)
  endif
  delete
  pack
  go top
else
  WarnWrite("Немогу удалить текущий балансовый счет...")
endif
return
*---------------------------------------------------------*
function PrintGloss
if .not.QuesPrint()
  return " "
endif
private InpPage,cnt_fld,len_flds,fld,log_prn,str_prn,i,NN,Nz
* otwet из MenuGloss
save screen to InpPage
MsgWrite("Печатаю...")
cnt_fld=len(dict_fld)
declare len_fld[cnt_fld]
len_flds=0
for i=1 to cnt_fld
  fld=dict_fld[i]
  if len(dict_nam[i]) >= lenvar(&fld)
    len_fld[i]=len(dict_nam[i])
  else
    len_fld[i]=lenvar(&fld)
  endif
  len_flds=len_flds+len_fld[i]
next
log_prn=.T.
if log_prn
  str_prn="Словарь: "+'"'+alltrim(dict_prm[otwet2])+'"'+chr(13)+chr(10)+chr(13)+chr(10)
  str_prn=str_prn+replicate("-",len_flds+cnt_fld*3+4)+chr(13)+chr(10)
  str_prn=str_prn+"  №№"
  for i=1 to cnt_fld
    if len(dict_nam[i])=len_fld[i]
      str_prn=str_prn+" ! "+dict_nam[i]
    else
      str_prn=str_prn+" ! "+dict_nam[i]+space(len_fld[i]-len(dict_nam[i]))
    endif
  next
  str_prn=str_prn+chr(13)+chr(10)
  str_prn=str_prn+replicate("-",len_flds+cnt_fld*3+4)+chr(13)+chr(10)
  log_prn=mprints(str_prn)
endif
if log_prn
  Nz=recno()
  go top
  NN=1
  do while .not.eof()
    str_prn=str(NN,4)
    for i=1 to cnt_fld
      fld=dict_fld[i]
      if lenvar(&fld)=len_fld[i]
        str_prn=str_prn+" ! "+varstr(&fld)
      else
        str_prn=str_prn+" ! "+space(len_fld[i]-lenvar(&fld))+varstr(&fld)
      endif
    next
    str_prn=str_prn+chr(13)+chr(10)
    log_prn=mprints(str_prn)
    if .not.log_prn
      exit
    endif
    NN=NN+1
    skip
  enddo
  go Nz
endif
if log_prn
  str_prn=str_prn+replicate("-",len_flds+cnt_fld*3+4)+chr(13)+chr(10)
  log_prn=mprints(str_prn)
endif
restore screen from InpPage
return " "
