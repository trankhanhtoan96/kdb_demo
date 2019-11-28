h:hopen `::5000;
sleep:{[second;lastime] tnow:`second$(.z.z);
            s:"I"$(tnow-lastime);
            while[s<second;
                      tnow:`second$(.z.z);
                      s:"I"$(tnow-lastime)]};

lastminute:`minute$(.z.z);
while[1b;
          price:system "curl -s 'https://blockchain.info/tobtc?currency=USD&value=1'";
          price:"F"$(price);
          price:1%price;
          price:`int$(price);
          price:"I"$(price);
          time:.z.z;
          a:`second$(time);
          a:a.ss;
          while[(a mod 5) > 0;
                    time:.z.z;
                    a:`second$(time);
                    a:a.ss];
          (neg h) (`inserttrade;time;price);
          show time,price,"-";
          (neg h) (`updatetable);
          nowminute:`minute$(.z.z);
          if[nowminute.mm=0;nowminute=60];
          if[nowminute>lastminute;
             (neg h) (`savetodisk);
             lastminute=nowminute;];];
