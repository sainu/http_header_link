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

    describe '#generate' do
      context 'without options' do
        subject { instance.generate }

        let(:instance) { described_class.new('/', rel: 'previous') }

        it { is_expected.to eq('</>; rel="previous"') }
      end

      context 'with base_url option' do
        subject { instance.generate(base_url: base_url) }

        let(:instance) { described_class.new(url, rel: 'previous') }

        parameterized do
          where :base_url, :url, :expected_url, size: 8 do
            [
              ['http://localhost', 'items?page=1', 'http://localhost/items?page=1'],
              ['http://localhost/', 'items?page=1', 'http://localhost/items?page=1'],
              ['http://localhost', '/items?page=1', 'http://localhost/items?page=1'],
              ['http://localhost/', '/items?page=1', 'http://localhost/items?page=1'],
              ['http://localhost/base', 'items?page=1', 'http://localhost/items?page=1'],
              ['http://localhost/base/', 'items?page=1', 'http://localhost/base/items?page=1'],
              ['http://localhost/base', '/items?page=1', 'http://localhost/items?page=1'],
              ['http://localhost/base/', '/items?page=1', 'http://localhost/items?page=1']
            ]
          end

          with_them do
            it { is_expected.to eq(%(<#{expected_url}>; rel="previous")) }
          end
        end
      end
    end

    describe '#get_query' do
      subject { instance.get_query(query_name) }

      let(:instance) { described_class.new(url, rel: 'dummy') }

      parameterized do
        where :url, :query_name, :expected_value, size: 3 do
          [
            ['/', :page, nil],
            ['/?page=1', :page, '1'],
            ['/?dummy=1', :page, nil]
          ]
        end

        with_them do
          fit { is_expected.to eq(expected_value) }
        end
      end
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
