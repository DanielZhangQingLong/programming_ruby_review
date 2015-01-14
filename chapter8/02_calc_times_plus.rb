print "times or plus: "

operator = gets

print "input number:"

number = Integer(gets)

calc = operator =~ /^t/ ? ( lambda { |n| n * number } )  : ( lambda { |n| n + number } )


puts ( (1..10).collect(&calc).join(", ") )
