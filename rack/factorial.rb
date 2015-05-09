class FactorialApp
  def call(env)
    @env = env
    if n == 0
      base_case
    else
      induction_step
    end
  end

  private

  # Factorial(0) => 1
  def base_case
    [200, { 'Content-Type' => 'text/plain' }, [1]]
  end

  # Factorial(n) => n * Factorial(n-1)
  def induction_step
    res = n * get_factorial(n-1)
    [200, { 'Content-Type' => 'text/plain' }, [res.to_s]]
  end

  def get_factorial(i)
    @env['PATH_INFO'] = "/factorial/#{i}"
    self.class.new.call(@env)[2][0].to_i
  end

  # Parameter comes as last part of the URL
  def n
    @n ||= @env['PATH_INFO'].split('/').last.to_i
  end
end
