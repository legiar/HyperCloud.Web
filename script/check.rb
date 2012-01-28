#!/usr/bin/env ruby 
require "net/http"
require "net/https"
require "cgi"
require "pp"

http = Net::HTTP.new("10.1.1.6", 443)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
http.set_debug_output $err

headers = {"Host" => "en.demo.bpmonline.com"}
steps = [
  {:path => "/Login.aspx", :method => :get, :required => false, :redirect => true},
  {:path => "/VirtualLogin.aspx", :method => :get, :required => true, :redirect => false},
  {:path => "/ViewPage.aspx?Id=5e5f9a9e-aa7d-407d-9e1e-1c24c3f9b59a", :method => :get, :required => true, :redirect => false}]

cookies = {}
steps.each do |step|
  headers['Cookie'] = cookies.collect{|key,value| "#{key}=#{value.to_a.first}"}.join("; ")
  print "==== Check '#{step[:path]}'..."
  req = Net::HTTP::Get.new(step[:path], headers)
  http.request(req) do |response|
    case response
      when Net::HTTPSuccess
        puts response.code
        puts "\n"
        CGI::Cookie::parse(response['set-cookie']).each do |key, value|
          cookies[key] = value
        end
      when Net::HTTPRedirection
        print response.code
        puts "\n"
        CGI::Cookie::parse(response['set-cookie']).each do |key, value|
          cookies[key] = value
        end
      else
        puts "Fail"
    end
  end
end

