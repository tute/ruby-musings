class FibonacciApp
  def call(env)
    @env = env
    if n <= 1
      base_case
    else
      induction_step
    end
  end

  private

  # Fibonacci(0) => 0, Fibonacci(1) => 1
  def base_case
    [200, { 'Content-Type' => 'text/plain' }, [n]]
  end

  def induction_step
    res = get_fibonacci(n-1) + get_fibonacci(n-2)
    [200, { 'Content-Type' => 'text/plain' }, [res.to_s]]
  end

  def get_fibonacci(i)
    @env['PATH_INFO'] = "/fibonacci/#{i}"
    self.class.new.call(@env)[2][0].to_i
  end

  # Parameter comes as last part of the URL
  def n
    @n ||= @env['PATH_INFO'].split('/').last.to_i
  end
end
