h: hopen `::5005;
c: {[a; b] do[b; a:a*10]; a};
d: {[x;y;m]j:n?y[x]; c[j; m-(x+1)]};
e:{x%1000};
n:48 49 50 51 52 53 54 55 56 57;
getprice:{[] a:system "curl -s 'http://localhost/kdb-demo/getprice.php?type=1'"; b:system "curl -s 'http://localhost/kdb-demo/getprice.php?type=2'"; a:flip `int$(a); b:flip `int$(b); i:0; r:0; t:0; m:count a; do[m; r:r+d[i;a;m]; i:i+1]; i:0; m:count b; do[m; t:t+d[i;b;m]; i:i+1]; r:r+e[t]; r};
while[1b;price:getprice[];
         time:.z.Z;
         timem:`minute$(time);
         h "t:select [-120] `second$(time), price from trade";
         if[(h "count trade")>0; a: h "last trade"; a:a[`time]; if[not(a.ss=time.ss); h (`inserttrade; time; price)]; mm:`minute$(a); if[not(mm.mm=timem.mm); h "`:/Users/tkt/q/trade set trade"]];
         if[(h "count trade")=0; h (`inserttrade; time; price)]; show time; show price;]

//t: select [-120] time, price:120?8000 from trade
//thêm đơn vị tiền tệ USD vào đồ thị
