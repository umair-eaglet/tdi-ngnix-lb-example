require 'spec_helper'

describe 'server::default' do

  it 'Display results from my app' do
    expect(command('curl://localhost:8484').exist_status).to eq 0
  end

  end
