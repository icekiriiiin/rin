#基于ruby2.4，登录WEB后台点击链接（https://localhost:3443/#/me/）获取你的apikey，并替换脚本api_key的值
#需要扫描的文件列表保存再脚本同目录的url.txt下。
#ruby果然是最恶心人的脚本
#@清纯可爱冰淇淋
require 'net/https'
api_key = "1986ad8c0a5b3df4d7028d5f3c06e936c8fdd3126585a4f01b921104c44f8e8d2"
IO.foreach("url.txt"){|block| 
tag = block.chomp
puts "#{tag}"
Net::HTTP.start('127.0.0.1',3443,{:use_ssl => true,:verify_mode => OpenSSL::SSL::VERIFY_NONE}) {|http|
api_key = "1986ad8c0a5b3df4d7028d5f3c06e936c8fdd3126585a4f01b921104c44f8e8d2"
headers = { 
  'X-Auth' => api_key,
  'content-type' => 'application/json'
  }
urladd = "\{\"address\":\"#{tag}\",\"description\":\"test\",\"criticality\":\"10\"}"
response = http.post('/api/v1/targets',urladd,headers)
tid = response.body.split(",")
scanadd = "{#{tid[2]},\"profile_id\":\"11111111-1111-1111-1111-111111111111\",\"schedule\":{\"disable\":false,\"start_date\":null,\"time_sensitive\":false},\"ui_session_id\":\"66666666666666666666666666666666\"}"
response = http.post('/api/v1/scans',scanadd,headers)
}
}