copy mt.prg mt_b.prg
type menu.prg >> mt_b.prg
type func.prg >> mt_b.prg
type inp.prg >> mt_b.prg
type print.prg >> mt_b.prg
type arhivs.prg >> mt_b.prg
type tunes.prg >> mt_b.prg
type title.prg >> mt_b.prg
type vars.prg >> mt_b.prg
clipper mt_b -m -q -l
rtlink FI mt_b OUT mt LIB clipper,extend,mcl
del mt_b.*
