File.foreach("./ordinal") do |line|
  print line if(($. == 1) || line =~ /eig/)..(($. == 3) || line =~ /nin/)
end
