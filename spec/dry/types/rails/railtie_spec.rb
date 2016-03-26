require 'spec_helper'

describe Dry::Types::Rails::Railtie do
  before do
    module ::Types
      include Dry::Types.module
    end
  end
  it 'removes the container on prepare' do
    expect(Dry::Types).to receive(:remove_instance_variable).with(:@container).and_call_original
    ActionDispatch::Reloader.prepare!
  end
end