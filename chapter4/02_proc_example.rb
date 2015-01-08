class ProcExample
  def pass_in_block(&action)
    @store_proc = action
  end

  def use_proc(parameter)
    @store_proc.call(parameter)
  end
end

pe = ProcExample.new
pe.pass_in_block { |value| puts "the value is #{value}" }

pe.use_proc(100)
