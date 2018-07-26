RSpec.describe DigDeep do
  let(:case1){
    {
      :l1 => "Level 1"
    }
  }

  let(:case2){
    {
      :l1 => {
        :l2 => "Level 2"
      }
    }
  }

  let(:case3){
    {
      :l1 => [{
        :l2 => "Level 2",
        :l2a => "Level 2a"
      }]
    }
  }

  let(:case4){
    {
      :l1a => [ "aaa", true, {:bingo => "Bingo1!"}, 111, false ],
      :l1b => {
        :l2a => "level 2a",
        :l2b => {
          :l3 => {
            :bingo => "Bingo!",
            :l4 => [ "bbb", {:bingo => "Bingo2!"}, {:bingo => "Bingo3!"} ]
          }
        }
      }
    }
  }

  let(:case5){
    {
      :stuff => "hello",
      :l1 => {
        :stuff => true,
        :l2 => {
          :stuff => ["nested", true, "four"],
          :l3 => {
            :stuff => ["so nested", false, 5]
          },
          :l3a => {
            :stuff => {
              :food => "pizza"
            }
          }
        },
        :l2a => {
          :stuff => false
        }
      }
    }
  }

  let(:case6){
    {
      :l1 => {
        :l2 => {
          :stuff => {
            :food => "pizza"
          }
        },
        :stuff => {
          :food => "rice"
        }
      },
      :stuff => {
        :food => "burger"
      }
    }
  }

  let(:case7){
    {
      :l1 => {
        :l2 => {
          :stuff => ["soccer", "football", "basketball"]
        },
        :stuff => ["cars", "airplanes", "boats"]
      },
      :stuff => ["soda", "candy", "pizza"]
    }
  }

  let(:case8){
    {
      :l1 => [{
          :l2a => "level 2",
          :l2b => {
            :l3a => [
              { :email => "email+1@example.com" },
              { :email => "email+2@example.com"}
            ],
            :l3b => "level 3"
          }
      },
      { :email => "email+3@example.com"} ]
    }
  }

  let(:case9){
    {
      :l1 => {
        :l2 => {
          :l3 => {
            :l4a => "Level 4",
            :l4b => {
              :l5a => false,
              :dup_key => false,
              :l5b => {
                :l6 => ["apple", "orange"],
                :dup_key => true
              }
            } 
          },
          :email => "email_1@exapmle.com",
          :dup_key => "testing"
        },
        :email => "email_2@exapmle.com"
      },
      :l1a => true,
      :dup_key => ["pizza", 5, true]
    }
  }

  let(:case10){
    {
      :l1 => {
        :l2a => nil,
        :l2b => nil
      }
    }
  }

  let(:client_with_many_addresses){
    {
      name: {
        first_name: "John",
        last_name: "Doe"
      },
      addresses: [
        {
          company: "Google",
          street: "1600 Amphitheatre Parkway",
          city: "Mountain View",
          state: "CA",
          zipcode: "94043",
          location: {
            latitude: 37.4220,
            longitude: -122.0841
          }
        },
        {
          company: "Apple",
          street: "1 Apple Park Way",
          city: "Cupertino",
          state: "CA",
          zipcode: "95014",
          location: {
            latitude: 37.3318,
            longitude: -122.0312
          }
        }
      ]
    }
  }

  let(:readme_example){
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

  it "dig_deep for a hash" do
    expect(case1.is_a? Hash).to be true
  end

  it "Success examples shown on Readme" do 
    expect(readme_example.dig_deep(:l4a)).to eq "Level 4"
    expect(readme_example.dig_deep(:l5a)).to be false
    expect(readme_example.dig_deep(:xyz)).to be nil
  end

  it "dig_deep for string in case 1 success" do
    expect(case1.dig_deep(:l1)).to eq "Level 1"
  end

  it "dig_deep for string in case 2 success" do
    expect(case2.dig_deep(:l2)).to eq "Level 2"
  end

  it "can dig into array of hash" do
    expect(case3.dig_deep(:l2a)).to eq "Level 2a"
  end

  it "can dig into nested array of hashes" do
    expect(case4.dig_deep(:bingo)).to eq ["Bingo1!", "Bingo!", "Bingo2!", "Bingo3!"]
  end

  it "dig_deep for identical keys" do
    expect(case5.dig_deep(:stuff)).to eq \
      ["hello", true, ["nested", true, "four"], ["so nested", false, 5], {:food=>"pizza"}, false]
  end

  it "dig_deep for identical keys" do
    expect(case6.dig_deep(:stuff)).to eq \
      [{:food=>"burger"}, {:food=>"rice"}, {:food=>"pizza"}]
  end

  it "dig_deep into the deepest level and returns all stuffs" do
    expect(case7.dig_deep(:stuff)).to eq \
      [["soda", "candy", "pizza"], ["cars", "airplanes", "boats"], ["soccer", "football", "basketball"]]
  end

  it 'dig_deep into a nested hash and array and return emails' do
    expect(case8.dig_deep(:email)).to eq ["email+1@example.com", "email+2@example.com", "email+3@example.com"]
  end

  it "dig_deep for string success" do
    expect(case9.dig_deep(:l4a)).to eq "Level 4"
  end

  it "dig_deep for falsy success" do
    expect(case9.dig_deep(:l5a)).to eq false
  end

  it "dig_deep for truthy success" do
    expect(case9.dig_deep(:l1a)).to eq true
  end

  it "dig_deep for hash success" do
    expect(case9.dig_deep(:l5b).is_a? Hash).to be true
  end

  it "dig_deep for array success" do
    expect(case9.dig_deep(:l6)).to eq ["apple", "orange"]
  end

  it "dig_deep returns all emails" do
    expect(case9.dig_deep(:email)).to eq ["email_2@exapmle.com", "email_1@exapmle.com"]
  end

   it "dig_deep returns all identical keys" do
    expect(case9.dig_deep(:dup_key)).to eq \
      [["pizza", 5, true], "testing", false, true]
  end

  it "returns nil when no target is found" do
    expect(case9.dig_deep(:nada)).to eq nil
  end

  it "returns nil success" do
    expect(case10.dig_deep(:l2b)).to eq nil
  end

  it "dig_deep on empty hash returns nil" do
    expect({}.dig_deep(:l1)).to eq nil
  end

  it "dig_deep will not work on string" do
    expect{"".dig_deep(:l1)}.to raise_error(NoMethodError)
  end

  it "dig_deep will not work on number" do
    expect{123.dig_deep(:l1)}.to raise_error(NoMethodError)
  end

  it "dig_deep will not work on boolean" do
    expect{false.dig_deep(:l1)}.to raise_error(NoMethodError)
  end
  it "dig_deep will not work on array" do
    expect{[].dig_deep(:l1)}.to raise_error(NoMethodError)
  end

  it 'client_with_many_addresses' do
    expect(client_with_many_addresses.dig_deep(:latitude)).to eq [37.422, 37.3318]
  end
end
