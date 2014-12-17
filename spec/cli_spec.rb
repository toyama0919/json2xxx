require 'spec_helper'
require 'json2xxx'

describe Json2xxx::CLI do
  before do
  end

  it "should stdout sample" do
    output = capture_stdout do
      Json2xxx::CLI.start(['help'])
    end
    output.should_not nil
  end

  after do
  end
end
