describe "the remember_name method" do
  it "gives us a confirmation message" do
    expect (remember_name("Billy")).to eq 'Name "Billy" remembered!'
  end
end
