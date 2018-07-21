RSpec.describe DigDeep do
  let(:data){
    {
      :l1 => {
        :l2 => {
          :l3 => {
            :l4a => "Level 4",
            :l4b => {
              :l5a => false,
              :l5b => {
                :l6 => ["apple", "orange"]
              }
            } 
          }
        }
      },
      :l7 => true
    }
  }

  it "has a version number" do
    expect(DigDeep::VERSION).not_to be nil
  end

  it "data is a hash" do
    expect(data.is_a? Hash).to be true
  end

  it "dig_deep for string success" do
    expect(data.dig_deep(:l4a)).to eq "Level 4"
  end

  it "dig_deep for falsy success" do
    expect(data.dig_deep(:l5a)).to eq false
  end

  it "dig_deep for truthy success" do
    expect(data.dig_deep(:l7)).to eq true
  end

  it "dig_deep for hash success" do
    expect(data.dig_deep(:l5b).is_a? Hash).to be true
  end

  it "dig_deep for array success" do
    expect(data.dig_deep(:l6)).to eq ["apple", "orange"]
  end

  it "dig_deep not found returns nil" do
    expect(data.dig_deep(:l8)).to eq nil
  end

  it "dig_deep on empty hash returns nil" do
    expect({}.dig_deep(:l1)).to eq nil
  end
end
