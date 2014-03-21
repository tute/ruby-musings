require './factorial'
require './fibonacci'

use Rack::Reloader

map '/factorial' do
  run FactorialApp.new
end

map '/fibonacci' do
  run FibonacciApp.new
end

map '/' do
  res = "Try <a href='/factorial/5'>/factorial/5</a> or <a href='/fibonacci/5'>/fibonacci/5</a>"
  run Proc.new {|env| [200, { 'Content-Type' => 'text/html' }, [res]]}
end
