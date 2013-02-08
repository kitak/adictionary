# coding: utf-8
require 'sinatra'
require 'sinatra/reloader'
require 'rexml/document'
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
  doc = REXML::Document.new(dic_item.body)

  begin
    item_id = doc.elements['//TitleList/DicItemTitle/ItemID'].text

    item = dijizo.get '/NetDicV09.asmx/GetDicItemLite', {
      "Dic" => 'EJdict',
      "Item" => item_id,
      "Loc" => '',
      "Prof" => 'XHTML'  
    }
    doc = REXML::Document.new(item.body) 
    @result_word = doc.elements['//Body/div/div'].text
  rescue
    @result_word = 'みつかりませんでした'
  end

  erb :result
end

