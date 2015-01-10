def my_if(condition, then_clause, else_clause)
  if condition.call
    then_clause.call
  else
    else_clause.call
  end  
end

5.times do |val|
  my_if(-> {val<2}, -> { puts "#{val} is samll" }, -> { puts "#{val} is big" })
end

