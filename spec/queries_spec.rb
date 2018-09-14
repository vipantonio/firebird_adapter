require 'spec_helper'

describe 'query' do

  it 'finds first record' do
    expect(SisTest.first).to be_nil
    SisTest.create!
    expect(SisTest.first).to be_present
  end

  it 'finds second record' do
    expect(SisTest.second).to be_nil
    SisTest.create!(id_test: 11)
    SisTest.create!(id_test: 22)
    SisTest.create!(id_test: 99)
    expect(SisTest.second.id_test).to eq 22
  end

  it '#all' do
    expect(SisTest.all).to be_empty

    SisTest.create!
    expect(SisTest.all).to be_any
  end

  it '#limit' do
    SisTest.create!
    SisTest.create!
    expect(SisTest.limit(1).count).to eq 1
    expect(SisTest.limit(3).count).to eq 2
  end

  it '#limit, #offset' do
    SisTest.create!(id_test: 11)
    SisTest.create!(id_test: 22)
    SisTest.create!(id_test: 33)
    SisTest.create!(id_test: 44)
    SisTest.create!(id_test: 55)
    expect(SisTest.third.id_test).to eq 33
    expect(SisTest.limit(1).offset(4).first.id_test).to eq 55
  end

  it '#where' do
    SisTest.create!
    expect(SisTest.where('id_test < ?', 0).count).to eq 0
    expect(SisTest.where('id_test > ?', 0).count).to eq 1
  end

end
