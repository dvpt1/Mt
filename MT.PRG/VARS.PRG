*-------------Инициализация массива лицевого счета--------*
procedure InitMT
public cur_path,new_path,cur_config,new_config,tBALANS
public MainDBF,MainSTR
store 'mt.dbf' to MainDBF
store 'mt.str' to MainSTR
select 9
use config.mt
public pic_sum
pic_sum=pictn(I->FORMAT)
use
select 8
use journal.mt             && Журнал
public SIZE_JOUR
SIZE_JOUR = lastrec()+1
public jour_jou[SIZE_JOUR]   && Макро поле журнала
public jour_fld[SIZE_JOUR]   && Имя  поля
public jour_nam[SIZE_JOUR]   && Название поля
public jour_iif[SIZE_JOUR]   && Название логического поля
public jour_dbf[SIZE_JOUR]   && Название файла словаря
public jour_ntx[SIZE_JOUR]   && и его файла индекса
public jour_cod[SIZE_JOUR]   && Код из словаря
public jour_scr[SIZE_JOUR]   && Листинг словаря
i=1
jour_jou[i]="iif(delete(),chr(16),' ')"
jour_fld[i]="delete()"
jour_nam[i]=""
jour_iif[i]="iif(delete(),chr(16),' ')"
jour_dbf[i]=""
jour_ntx[i]=""
jour_cod[i]=""
jour_scr[i]=""
do while .not.eof()
  i=i+1
  do case
    case .not.empty(H->DICT_DBF)
      jour_jou[i]="mdict('"+alltrim(H->FIELD_SCR)+"',"+alltrim(H->FIELD_NAME)+;
      ",'"+alltrim(H->FIELD_COD)+"','"+alltrim(H->DICT_DBF)+"','"+alltrim(H->DICT_NTX)+"')"
    case .not.empty(H->IIF_STR)
      jour_jou[i]=alltrim(H->IIF_STR)
    othe
      jour_jou[i]=alltrim(H->FIELD_NAME)
  endcase
  jour_fld[i]=alltrim(H->FIELD_NAME)
  jour_nam[i]=alltrim(H->NAME_FIELD)
  jour_iif[i]=alltrim(H->IIF_STR)
  jour_dbf[i]=alltrim(H->DICT_DBF)
  jour_ntx[i]=alltrim(H->DICT_NTX)
  jour_cod[i]=alltrim(H->FIELD_COD)
  jour_scr[i]=alltrim(H->FIELD_SCR)
  skip
enddo
use filter.mt             && Фильтр
public SIZE_FILTER
SIZE_FILTER = lastrec()
if SIZE_FILTER != 0
  public filter_fld[SIZE_FILTER]   && Имя  поля
  public filter_nam[SIZE_FILTER]   && Название поля
  public filter_iif[SIZE_FILTER]   && Название логического поля
  public filter_dbf[SIZE_FILTER]   && Название файла словаря
  public filter_ntx[SIZE_FILTER]   && и его файла индекса
  public filter_cod[SIZE_FILTER]   && Код из словаря
  public filter_scr[SIZE_FILTER]   && Листинг словаря
  i=0
  do while .not.eof()
    i=i+1
    filter_fld[i]=alltrim(H->FIELD_NAME)
    filter_nam[i]=alltrim(H->NAME_FIELD)
    filter_iif[i]=alltrim(H->IIF_STR)
    filter_dbf[i]=alltrim(H->DICT_DBF)
    filter_ntx[i]=alltrim(H->DICT_NTX)
    filter_cod[i]=alltrim(H->FIELD_COD)
    filter_scr[i]=alltrim(H->FIELD_SCR)
    skip
  enddo
endif
use index.mt             && Индекс rent.dbf
public SIZE_INDX
SIZE_INDX = lastrec()
if SIZE_INDX != 0
  public index_prm[SIZE_INDX]
  public index_ntx[SIZE_INDX]
  public index_key[SIZE_INDX]
  i=0
  do while .not.eof()
    i=i+1
    index_prm[i] = H->INDEX_PRM
    index_ntx[i] = alltrim(H->INDEX_NTX)
    index_key[i] = alltrim(H->INDEX_KEY)
    skip
  enddo
endif
use diction.mt             && список словарей
public SIZE_DICT
SIZE_DICT = lastrec()
if SIZE_DICT != 0
  public dict_prm[SIZE_DICT]
  public dict_dbf[SIZE_DICT]
  public dict_ntx[SIZE_DICT]
  public dict_key[SIZE_DICT]
  public dict_str[SIZE_DICT]
  public dict_path[SIZE_DICT]
  i=0
  do while .not.eof()
    i=i+1
    dict_prm[i] = H->DICT_PRM
    dict_dbf[i] = alltrim(H->DICT_DBF)
    dict_ntx[i] = alltrim(H->DICT_NTX)
    dict_key[i] = alltrim(H->DICT_KEY)
    dict_str[i] = alltrim(H->DICT_STR)
    dict_path[i] = H->DICT_PATH
    skip
  enddo
endif
use
   public is_setj
   is_setj=.F.
   public is_archiv
   is_archiv=.F.
return
