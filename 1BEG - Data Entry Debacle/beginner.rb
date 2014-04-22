
numTests = gets.chomp.to_i

for i in 1..numTests do
  number = gets
  if number.length < 11
    number.insert(3, "1")
  end
  print number
end 
    
