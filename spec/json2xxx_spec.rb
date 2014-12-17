require 'spec_helper'
require 'json2xxx'

describe Json2xxx do
  it "should have a VERSION constant" do
    subject.const_get('VERSION').should_not be_empty
  end
end
