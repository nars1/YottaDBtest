C9B04001673g	; generate nofull_boolean $increment() cases into C9B04001673b
  ;
  new
  new $etrap
  set $etrap="break"
  set file="C9B04001673b.m"
  set pre=" . k b,^b,ef,g zk l,l(1),l(2),e(1),^ei,^g,^g(1),^g(2) s ^a(1,2)=1,d=a",post="),r=$r,m='$d(",trail="m),$i(cnt) x act"
  open file:newver
  use file
  for j=1:1 set line=$text(prefix+j) quit:"cases"=line  write line,!
  for j=1:1 set ca=$translate($text(cases+j),"X","2") quit:"stop"=ca  do
  . for iv="","^" do
  .. set case=$translate(ca,"Y",$select(""=iv:"1",1:"2"))
  .. set lir=$piece(case,";",3),i=iv_"c"_$piece(case,";",2),ir=$select($l(iv):iv_"c"_$piece(case,";",4),1:lir)
  .. new j 
  .. for j=1:1 set ca=$translate($t(cases+j),"X","1") quit:ca="stop"  do
  ... for tv="","^" do
  .... set case=$translate(ca,"Y",$select(""=tv:"1",1:"2"))
  .... set tir=$piece(case,";",3),t=tv_"b"_$piece(case,";",2)
  .... if iv="",tv="",(i["$$ei")!(t["$$ei") quit
  .... if tir["ir" set tir=$piece(tir,"ir")_ir_$piece(tir,"ir",2)
  .... set tr=$select($l(tv):tv_"b"_$piece(case,";",4),tir["^"&("^a(1,2)"'=tir):tir,1:ir)
  .... if "$"'=$e(tr) set tr=""""_tr_"""" 
  .... for o="!","&" do
  ..... write pre,o,"$i(",t,",",i,post,tv,"b) i ",tr,"'=r!",$s(0&""=tv:"(",1:"(a="_$s(o="!":"'",1:"")),trail,!
  ..... if 0=($increment(lines)#1000) u $principal write !,lines u file
  for j=0:1 set line=$t(end+j) quit:"nomore"=line  write line,!
  close file
  quit
prefix
C9B04001673b ; torture $increment() in nofull_boolean mode - generated by C9B04001673g
  ;
  new (act)
  if '$data(act) new act d
  . set act="s l=$st($st,""place"")'[""^"" w !,a,?2,$d(b)!$d(^b),?4,c,?10,r,?20,$st($st-l,""place""),!,$st($st-l,""mcode"")"
  new $etrap
  set $etrap="goto err",zl=$zl
  kill ^a,^c,^gi
  set (c,c(1),c(2),^c,^c(1),^c(2),^c(1,1),c(1,1,2),c(1,2,2),^c(1,1,2),^c(1,2,2),c(2,1,2),c(2,2,2),^c(2,1,2),^c(2,2,2))=1
  set (l(1,2),l(2,2),li(1),e(2),^e(1,2),^e(2,2),^ei(1),^g(1,2),^g(2,2),^gi(1))=1
  ;view "nofull_boolean"
  for a=0,1 do
cases
  ;;^a(1,2);;
  ;(X);^a(1,2);(1);
  ;(l(X,2));^a(1,2);(X);
  ;(^g(X,2));^g(X,2);(X);
  ;($i(l(X)));^a(1,2);(X);
  ;($i(l($$ei)));ir;(1);
  ;($i(^g(X)));^g(X);(X);
  ;($i(l(X),li(1)));^a(1,2);(X);
  ;($i(l(X),li($$ei)));ir;(1)
  ;($i(l(X),^gi(1)));^gi(1);(X)
  ;($i(^g(X),li(1)));^g(X);(X)
  ;($i(^g(X),^gi(1)));^g(X);(X)
  ;($i(l(X),^gi(1)));^gi(1);(X)
  ;($i(^g(X),li(1)));^g(X);(X)
  ;($i(^g(X),^gi(1)));^g(X);(X)
  ;($$ei);ir;(1)
  ;(e($$ef(^e(1,2))));^e(1,2);(1)
  ;(X,e(2),2);^a(1,2);(X,1,2)
  ;(X,^e(2,2),2);^e(2,2);(X,1,2)
  ;(1,$$ei,2);ir;(1,1,2)
  ;(1,$$ef(^e(1,2)),2);^e(1,2);(1,2,2)
  ;(1,$i(^g(X)),2);^g(X);(1,X,2)
  ;(1,$i(^g(X),li(1)),2);^g(X);(1,X,2)
  ;(1,$i(^g(X),^gi(1)),2);^g(X);(1,X,2)
  ;(1,$i(^g(X),^gi(1)),2);^g(X);(1,X,2)
  ;(1,$i(l(X)),2);^a(1,2);(1,X,2)
  ;(1,$i(l(X),li(1)),2);^a(1,2);(1,X,2)
  ;(1,$i(l(X),^gi(1)),2);^gi(1);(1,X,2)
  ;(1,$$ef(^e($i(^g(X)),2)),2);^e(1,2);(1,2,2)
  ;($$ef(^e($i(g(X)),2)));^e(Y,2);(Y)
stop
end 
  write !,$select($get(cnt):"FAIL",1:"PASS")," from ",$text(+0);," ",$v("full_boolean"),!
  quit
ei()
  quit ^ei(1)
ef(ef)
  quit $increment(ef)
err
  write !,$zstatus
  xecute act
  if $increment(cnt) set $ecode=""
  set lab=$piece($piece($zstatus,"+"),",",2)
  if "err"=lab zgoto zl:end
  goto @(lab_"+"_($piece($zstatus,"+",2)+1))
nomore
