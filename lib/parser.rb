class Parser
  attr_reader :adds, :credits, :charges

  def initialize(file)
    @file = file.to_a
    file.close
  end

  def parse!
    tokenized_instr = parse_card_instructions(@file)
    @adds = grab_adds(tokenized_instr)
    @credits = grab_credits(tokenized_instr)
    @charges = grab_charges(tokenized_instr)
  end

  def parse_card_instructions(card_instr)
    tokenized_instr = card_instr.map { |line| line.split(" ") } 
  end

  def grab_adds(card_instr)
    adds = card_instr.select { |line| line[0].upcase == "ADD" }
    adds.each do |line|
      line[2] = line[2].to_i
      line[3].slice!(0)
      line[3] = line[3].to_i
    end
    adds
  end

  def grab_credits(card_instr)
    credits = card_instr.select { |line| line[0].upcase == "CREDIT" }
    credits.each do |line| 
      line[2].slice!(0)
      line[2] = line[2].to_i
    end
    credits 
  end

  def grab_charges(card_instr)
    charges = card_instr.select { |line| line[0].upcase == "CHARGE" }
    charges.each do |line|
      line[2].slice!(0)
      line[2] = line[2].to_i
    end
  end
end
