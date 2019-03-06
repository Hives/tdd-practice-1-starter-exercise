require 'remember_names'

describe "the remember_name method" do
  it "gives us a confirmation message about 'Billy' when receiving argument 'Billy'" do
    expect(remember_name("Billy")).to eq 'Name "Billy" remembered!'
  end
  it "gives us a confirmation message about 'Sally' when receiving argument 'Sally'" do
    expect(remember_name("Sally")).to eq 'Name "Sally" remembered!'
  end
end
