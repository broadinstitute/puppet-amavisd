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

  if Puppet::Pops::Types::TypeCalculator.instance?(String, data) and data == 'undef'
    return "undef"
  end

  if Puppet::Pops::Types::TypeCalculator.instance?(String, data)
    return "\"#{data}\""
  end

  if Puppet::Pops::Types::TypeCalculator.instance?(Integer, data)
    return "#{data}"
  end

  return data.to_s
end
