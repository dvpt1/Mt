*---------------------------------------------------------*
procedure SaveArhiv
private disk,old_Nz
disk=diskAB()
if empty(disk)
  return
endif
old_Nz=recno()
CloseDBF()
select 9
use &new_config
save_path=disk+"\"+str(year(I->T_DATE),4)+"."+strtran(str(month(I->T_DATE),2)," ","0")
mkdir(save_path)
save_path=save_path+"\MT"+intnum(I->BALANS)
mkdir(save_path)
copys("*.*",new_path,save_path)
use &new_config
OpenDBF()
OpenNTX()
InitFilter()
go old_Nz
redraw=.T.
RETR=0
return
*---------------------------------------------------------*
procedure LoadArhiv
private disk
disk=diskAB()
if empty(disk)
  return
endif
private new_date
new_date=DateArh(disk)
if .not.empty(new_date)
 CloseDBF()
 select 9
 use &cur_config
 repl I->T_DATE with new_date
 load_path=disk+"\"+str(year(I->T_DATE),4)+"."+strtran(str(month(I->T_DATE),2)," ","0")+;
                "\MT"+intnum(I->BALANS)
 cur_date=cur_path+"\"+str(year(I->T_DATE),4)+"."+strtran(str(month(I->T_DATE),2)," ","0")
 mkdir(cur_date)
 tBALANS=I->BALANS
 new_path=cur_date+"\MT"+intnum(I->BALANS)
 new_config=new_path+"\config.mt"
 use
 mkdir(new_path)
 copys("*.*",load_path,new_path)
 set path to &new_path
 select 9
 use &new_config
 OpenDBF()
 OpenNTX()
 redraw=.T.
 RETR=0
endif
return
*---------------------------------------------------------*
procedure OldArhiv
private new_date
new_date=DateArh(cur_path)
if .not.empty(new_date)
 CloseDBF()
 select 9
 use &cur_config
 repl I->T_DATE with new_date
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
 OpenDBF()
 OpenNTX()
 redraw=.T.
 RETR=0
endif
return
*---------------------------------------------------------*
procedure DelArhiv
private new_date
do while .T.
new_date=DateArh(cur_path)
if .not.empty(new_date)
if new_date != I->T_DATE
save scre
if Yes_Or_No('','У д а л и т ь   а p х и в ?',2)
 del_path=cur_path+"\"+str(year(new_date),4)+"."+strtran(str(month(new_date),2)," ","0")+;
          "\MT"+intnum(I->BALANS)
 deles("*.*",del_path)
 rmdir(del_path)
endif
rest scre
else
 WarnWrite("Текущий аpхив удалять  H Е Л Ь З Я !!!")
endif
else
 exit
endif
enddo
return
*---------------------------------------------------------*
function DateArh
parameters disk_path
private old_color
old_color = setcolor()
save scre
MsgWrite("Читаю список архивов...")
private nNames := {}, aNames := {}
aFiles := DIRECTORY(disk_path+"\*.*", "D")
AEVAL(aFiles,{ | file | AADD(nNames, file[F_NAME]), AADD(aNames, file[F_ATT]) })
fcount=len(nNames)
j=0
for i=1 to fcount
 if aNames[i] == "D".AND.nNames[i] != "..".AND.nNames[i] != ".".AND.isdigit(nNames[i])
  j++
 endif
next
ncount=j
private iArhiv[ncount]
j=1
for i=1 to fcount
 if aNames[i] == "D".AND.nNames[i] != "..".AND.nNames[i] != ".".AND.isdigit(nNames[i])
  iArhiv[j] = ctod("01."+substr(nNames[i],6,2)+"."+substr(nNames[i],1,4))
  j++
 endif
next
asort(iArhiv)
private aArhiv[ncount]
for i=1 to ncount
 aArhiv[i] = " "+Month[month(iArhiv[i])]+" "+str(year(iArhiv[i]),4)+" "
next
rest scre
save scre
setcolor(cdict)
BoxTenj(Y_srm-10,X_srm-8,Y_srm+10,X_srm+8,ibox)
setcolor(cl)
MSG=' А Р Х И В '
@ Y_srm-10,int(X_srm-len(MSG)/2)+1 say MSG
setcolor(cdict)
ptr=1
new_ptr=achoice(Y_srm-9,X_srm-7,Y_srm+9,X_srm+7,aArhiv,"","",ptr)
rest scre
setcolor(old_color)
return iif(new_ptr=0,ctod(""),iif(empty(iArhiv[new_ptr]),ctod(""),iArhiv[new_ptr]))
*---------------------------------------------------------*
function IsArhiv
disk_path=cur_path
old_color = setcolor()
private nNames := {}, aNames := {}
aFiles := DIRECTORY(disk_path+"\*.*", "D")
AEVAL(aFiles,{ | file | AADD(nNames, file[F_NAME]), AADD(aNames, file[F_ATT]) })
fcount=len(nNames)
j=0
for i=1 to fcount
 if aNames[i] == "D".AND.nNames[i] != "..".AND.nNames[i] != ".".AND.isdigit(nNames[i])
  j++
 endif
next
ncount=j
private iArhiv[ncount]
j=1
for i=1 to fcount
 if aNames[i] == "D".AND.nNames[i] != "..".AND.nNames[i] != ".".AND.isdigit(nNames[i])
  iArhiv[j] = ctod("01."+substr(nNames[i],6,2)+"."+substr(nNames[i],1,4))
  j++
 endif
next
asort(iArhiv)
return iif(iArhiv[ncount]=I->T_DATE,.F.,.T.)
