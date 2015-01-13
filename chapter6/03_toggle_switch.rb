File.open("./03_toggle_switch.txt") do |file|
  file.each_line do |line|
    puts line if line =~ /start/ .. line =~ /end/
  end
end
