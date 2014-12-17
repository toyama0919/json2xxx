require 'spec_helper'
require 'json2xxx'

describe Json2xxx::Core do
  before do
    @core = Core.new
  end

  it "tsv" do
    data = [
            {id: 1, name: 'user1', address: 'tokyo'},
            {id: 2, name: 'user2', address: 'tokyo'},
            {id: 3, name: 'user3', address: 'tokyo'}
           ]
    result = @core.convert_csv(data, "\t")
    result.should == %Q{"id"\t"name"\t"address"
"1"\t"user1"\t"tokyo"
"2"\t"user2"\t"tokyo"
"3"\t"user3"\t"tokyo"
}
  end

  it "tsv" do
    data = [
            {id: 1, name: 'user1', address: 'tokyo'},
            {id: 2, name: 'user2', address: 'tokyo', zip_code: '111-1111'},
            {id: 3, name: 'user3', address: 'tokyo'}
           ]
    result = @core.convert_csv(data, "\t")
    result.should == %Q{"id"\t"name"\t"address"
"1"\t"user1"\t"tokyo"
"2"\t"user2"\t"tokyo"
"3"\t"user3"\t"tokyo"
}
  end

  after do
  end
end
