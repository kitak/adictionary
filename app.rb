require 'sinatra'

get '/index' do
end

get '/result' do
  keyword = params['text']
end

  #$p0 = 'http://public.dejizo.jp/NetDicV09.asmx/';
  #$p1 = 'SearchDicItemLite?Dic=EJdict';
  #$p2 = '&Word=';
  #$p3 = '&Scope=HEADWORD';
  #$p4 = '&Match=STARTWITH';
  #$p5 = '&Merge=AND';
  #$p6 = '&Prof=XHTML';
  #$p7 = '&PageSize=1';
  #$p8 = '&PageIndex=0';

  #$url = $p0.$p1.$p2.$keyword.$p3.$p4.$p5.$p6.$p7.$p8;

  #$result = simplexml_load_file($url);
  #$itemID = $result->TitleList->DicItemTitle->ItemID;

  #$i0 = 'http://public.dejizo.jp/NetDicV09.asmx/GetDicItemLite?Dic=EJdict';
  #$i1 = '&Item=';
  #$i2 = '&Loc=';
  #$i3 = '&Prof=XHTML';

  #$item = $i0.$i1.$itemID.$i2.$i3;

  #$resultid = simplexml_load_file($item);
  #$resultword = $resultid->Body->div->div;

