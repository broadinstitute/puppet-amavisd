module Puppet::Parser::Functions
  newfunction(:perl_data_print, type: :rvalue, doc: <<-EOS
Print out a Perl array given a Puppet array.  This takes care of doing
things related to the array, but calls perl_var_print to print individual
data types.

Given a nil value (undef), perl_varprint will return 'undef'.

Example:

    $var1 = 10
    $var2 = 'hello'
    $var3 = undef
    $var4 = 'undef'

    perl_data_print($var1)
    # => 10
    perl_data_print($var2)
    # => "hello"
    perl_data_print($var3)
    # => undef
    perl_data_print($var4)
    # => undef

EOS
  ) do |args|
    raise(Puppet::ParseError, "perl_data_print() wrong number of arguments. Given: #{args.size} for 1)") if args.size != 1

    data = args[0]

    if data.nil? || data == ''
      return nil
    end

    if data.is_a?(String) && data == 'undef'
      return 'undef'
    end

    begin
      Float(data)
    rescue ArgumentError  # rubocop:disable Lint/SuppressedException
    else
      return data.to_s
    end

    begin
      Integer(data)
    rescue ArgumentError  # rubocop:disable Lint/SuppressedException
    else
      return data.to_s
    end

    # Super-hacky thing to make variables with "math" work.
    # Only accounting for multiplication currently.
    d = data.split('*')
    ret = []
    is_math = true

    d.each do |num|
      Float(num)
      Integer(num)
    rescue ArgumentError
      is_math = false
      break
    else
      ret << num
    end

    if is_math
      return ret.join('*')
    end

    return "\"#{data}\""
  end
end
