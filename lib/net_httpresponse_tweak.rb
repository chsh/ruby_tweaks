# Intended to extend the Net::HTTP response object
# and adds support for decoding gzip and deflate encoded pages
#
# Author: Jason Stirk <http://griffin.oobleyboo.com>
# Home: http://griffin.oobleyboo.com/projects/http_encoding_helper
# Created: 5 September 2007
# Last Updated: 23 November 2007
#
# Usage:
# You can use gzipped content transparently.
#
# require 'net/http'
# require 'http_encoding_helper'
# headers={'Accept-Encoding' => 'gzip, deflate' }
# http = Net::HTTP.new('griffin.oobleyboo.com', 80)
# http.start do |h|
#   request = Net::HTTP::Get.new('/', headers)
#   response = http.request(request)
#   content=response.plain_body     # Method from our library
#   puts "Transferred: #{response.body.length} bytes"
#   puts "Compression: #{response['content-encoding']}"
#   puts "Extracted: #{response.plain_body.length} bytes"  
# end
#	

require 'net/http'
require 'zlib'
require 'stringio'

class Net::HTTPResponse
  def body_with_gunzip
    encoding = self['content-encoding']
    content = nil
    raw_body = self.body_without_gunzip
    if encoding then
      case encoding
        when 'gzip'
          i = Zlib::GzipReader.new(StringIO.new(raw_body))
          content = i.read
        when 'deflate'
          i = Zlib::Inflate.new
          content = i.inflate(raw_body)
        else
          raise "Unknown encoding - #{encoding}"
      end
    else
      content = raw_body
    end
    content
  end
  alias_method_chain :body, :gunzip
end
