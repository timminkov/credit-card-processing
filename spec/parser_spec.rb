require 'parser'

describe Parser do
  describe "#initialize" do
    it "gets initialized with an object" do
      parser = Parser.new(StringIO.new)
    end
  end

  describe "#parse_card_instructions" do
    it "returns a spaced array" do
      card_instr = ["Charge Tom $500"]
      parser = Parser.new(StringIO.new)
      tokenized_card_instr = [["Charge", "Tom", "$500"]]
      parser.parse_card_instructions(card_instr).should == tokenized_card_instr
    end
  end

  describe "#split_array" do
    before(:each) do
      @tokenized_card_instr = [["Charge", "Tom", "$500"], ["Add", "Sally", "3873298473", "$100"], ["Credit", "Rob", "$500"]]  
    end
    
    context "grab_adds" do
      it "takes all adds" do
        parser = Parser.new(StringIO.new)
        parser.grab_adds(@tokenized_card_instr).should == [["Add", "Sally", 3873298473, 100]]
      end
    end

    context "grab_credits" do
      it "takes all credits" do
        parser = Parser.new(StringIO.new)
        parser.grab_credits(@tokenized_card_instr).should == [["Credit", "Rob", 500]]
      end
    end

    context "grab_charges" do
      it "takes all charges" do
        parser = Parser.new(StringIO.new)
        parser.grab_charges(@tokenized_card_instr).should == [["Charge", "Tom", 500]]
      end
    end
  end

  describe "#parse!" do
    it "parses a file" do
      file = StringIO.new("Add Tom 18723897 $400\nCredit Lisa $100\nCharge Tom $500")
      parser = Parser.new(file)
      parser.parse!
      parser.adds.should == [["Add", "Tom", 18723897, 400]]
      parser.credits.should == [["Credit", "Lisa", 100]]
      parser.charges.should == [["Charge", "Tom", 500]]
    end
  end
end
