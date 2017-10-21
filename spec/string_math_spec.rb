require "spec_helper"

RSpec.describe NilClass do
  using StringMath::NilMath

  describe "#empty?" do
    it 'returns true' do
      expect(nil.empty?).to be true
    end
  end

  describe '#to_d' do
    it 'returns self' do
      expect(nil.to_d).to be nil
    end
  end

  describe '#+' do
    context 'other is also nil' do
      it 'returns self' do
        expect(nil + nil).to eq nil
      end
    end

    context 'other is empty' do
      it 'returns self' do
        expect(nil + "").to eq nil
      end
    end

    context 'other is not nil and is not empty' do
      it 'returns other', :aggregate_failures do
        expect(nil + "1.5").to eq "1.5"
        expect(nil + 1.5).to eq 1.5
      end
    end
  end
end

RSpec.describe String do
  using StringMath::StringMath

  describe '#+' do
    context 'both sides are empty' do
      it 'returns nil', :aggregate_failures do
        expect("" + "").to eq nil
        expect("" + nil).to eq nil
      end
    end

    context 'self is not empty' do
      it 'returns self' do
        expect("1" + nil).to eq 1
      end
    end

    context 'other is not empty' do
      it 'returns other' do
        expect("" + "4").to eq 4
      end
    end

    context 'both sides are not empty' do
      it 'returns sum' do
        expect("1" + "4").to eq 5
      end
    end
  end
end

RSpec.describe BigDecimal do
  using StringMath::BigDecimalMath

  describe '#empty?' do
    it 'returns false' do
      expect(BigDecimal.new('1.5').empty?).to eq false
    end
  end

  describe '#+' do
    context 'other is empty' do
      it 'returns self', :aggregate_failures do
        bd = BigDecimal.new('1.5')

        expect(bd + "").to eq 1.5
        expect(bd + nil).to eq 1.5
      end
    end
  end
end
