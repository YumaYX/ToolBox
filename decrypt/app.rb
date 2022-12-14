#!/usr/bin/env ruby
require 'openssl'

def decrypt(privatekey, datalocation)
  rsa = OpenSSL::PKey::RSA.new(open(privatekey))
  data = open(datalocation, 'r').read
  rsa.private_decrypt(data)
end

