require 'sinatra'
require 'sinatra/reloader'
require 'active_support'
require 'faraday'

get '/index' do
  erb :index
end

get '/result' do
  @keyword = params['text']

  dijizo = Faraday::Connection.new(:url => 'http://public.dejizo.jp') do |builder|
    builder.use Faraday::Request::UrlEncoded
    builder.use Faraday::Adapter::NetHttp
  end

  dic_item = dijizo.get '/NetDicV09.asmx/SearchDicItemLite', {
    "Dic" => 'EJdict',
    "Word" => @keyword,
    "Scope" => 'HEADWORD',
    "Match" => 'STARTWITH',
    "Merge" => 'AND',
    "Prof" => 'XHTML',
    "PageSize" => 1,
    "PageIndex" => 0  
  }
  doc = Hash.from_xml(dic_item.body)
  item_id = doc["SearchDicItemResult"]["TitleList"]["DicItemTitle"]["ItemID"]

  item = dijizo.get '/NetDicV09.asmx/GetDicItemLite', {
    "Dic" => 'EJdict',
    "Item" => item_id,
    "Loc" => '',
    "Prof" => 'XHTML'  
  }
  doc = Hash.from_xml(item.body) 
  doc.to_s
  @result_word = doc["GetDicItemResult"]["Body"]["div"]["div"]

  erb :result
end

