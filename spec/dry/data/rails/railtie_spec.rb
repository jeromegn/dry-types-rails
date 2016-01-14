require 'spec_helper'

describe Dry::Data::Rails::Railtie do
  before { Dry::Data.finalize }

  it 'removes the container on prepare' do
    expect(Dry::Data).to receive(:remove_instance_variable).with(:@container).and_call_original
    ActionDispatch::Reloader.prepare!
  end
end