# frozen_string_literal: true

RSpec.describe HttpLinkHeader::Link do
  describe 'Instance methods' do
    describe '#url' do
      subject { instance.url }

      let(:instance) { described_class.new(*args) }
      let(:args) do
        ['/', { rel: 'previous' }]
      end

      it { is_expected.to eq('/') }
    end

    describe '#to_s' do
      subject { instance.to_s }

      let(:instance) { described_class.new(*args) }
      let(:args) do
        ['/', { rel: 'previous' }]
      end

      it { is_expected.to eq('</>; rel="previous"') }
    end

    describe '#rel' do
      subject { instance.rel }

      let(:instance) { described_class.new(*args) }
      let(:args) do
        ['/', options]
      end

      parameterized do
        where :options, :expected_value, size: 2 do
          [
            [{}, nil],
            [{ rel: 'next' }, 'next']
          ]
        end

        with_them do
          it { is_expected.to eq(expected_value) }
        end
      end
    end

    describe '#hreflang' do
      subject { instance.hreflang }

      let(:instance) { described_class.new(*args) }
      let(:args) do
        ['/', options]
      end

      parameterized do
        where :options, :expected_value, size: 2 do
          [
            [{}, nil],
            [{ hreflang: 'ja' }, 'ja']
          ]
        end

        with_them do
          it { is_expected.to eq(expected_value) }
        end
      end
    end

    describe '#title' do
      subject { instance.title }

      let(:instance) { described_class.new(*args) }
      let(:args) do
        ['/', options]
      end

      parameterized do
        where :options, :expected_value, size: 2 do
          [
            [{}, nil],
            [{ title: 'previous chapter' }, 'previous chapter']
          ]
        end

        with_them do
          it { is_expected.to eq(expected_value) }
        end
      end
    end

    describe '#media' do
      subject { instance.media }

      let(:instance) { described_class.new(*args) }
      let(:args) do
        ['/', options]
      end

      parameterized do
        where :options, :expected_value, size: 2 do
          [
            [{}, nil],
            [{ media: '(min-width: 801px)' }, '(min-width: 801px)']
          ]
        end

        with_them do
          it { is_expected.to eq(expected_value) }
        end
      end
    end

    describe '#type' do
      subject { instance.type }

      let(:instance) { described_class.new(*args) }
      let(:args) do
        ['/', options]
      end

      parameterized do
        where :options, :expected_value, size: 2 do
          [
            [{}, nil],
            [{ type: 'text/plain' }, 'text/plain']
          ]
        end

        with_them do
          it { is_expected.to eq(expected_value) }
        end
      end
    end
  end
end
