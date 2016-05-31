Puppet::Parser::Functions::newfunction(:perl_data_print, :type => :rvalue, :doc => <<-EOS
Print out a Perl array given a Puppet array.  This takes care of doing
things related to the array, but calls perl_var_print to print individual
data types.

Given a nil value (undef), perl_varprint will return 'undef'.

Example:

    $var1 = [ 10, "abc" ]

    perl_varprint($var1)
    # => 10
    perl_varprint($var2)
    # => "hello"
    perl_varprint($var3)
    # => undef
    perl_varprint($var4)
    # => undef

EOS
) do |args|
  raise(Puppet::ParseError, "perl_data_print() wrong number of arguments. Given: #{args.size} for 1)") if args.size != 1

  data = args[0]

  if data.nil? or data == ""
    return nil
  end

  if function_is_string([data]) and data == 'undef'
    return "undef"
  end

  if function_is_numeric([data])
    return "#{data}"
  end

  # Super-hacky thing to make variables with "math" work.
  # Only accounting for multiplication currently.
  d = data.split('*')
  ret = []
  is_math = true

  d.each do |num|
    if function_is_numeric([num])
      ret << num
    else
      is_math = false
      break
    end
  end

  if is_math
    return ret.join('*')
  end

  return "\"#{data}\""
end
