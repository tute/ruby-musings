require './factorial'
require './fibonacci'

class GettingFunky
  def call(env)
    if env['PATH_INFO'] =~ /factorial/
      FactorialApp.new.call(env)
    elsif env['PATH_INFO'] =~ /fibonacci/
      FibonacciApp.new.call(env)
    else
      res = "Try <a href='/factorial/5'>/factorial/5</a> or <a href='/fibonacci/5'>/fibonacci/5</a>"
      [200, { 'Content-Type' => 'text/html' }, [res]]
    end
  end
end
