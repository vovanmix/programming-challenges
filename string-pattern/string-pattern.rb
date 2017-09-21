class Wordpattern
  class << self
    def wordpattern(pattern, input)
      rec(pattern, input, {})
    end

    def rec(pattern, input, words)
      return true if input.empty? && pattern.empty?
      return false if input.empty? || pattern.empty?

      return rec_existing_word(pattern, input, words) if words.key?(pattern[0])
      rec_new_word(pattern, input, words)
    end

    def rec_existing_word(pattern, input, words)
      word_pattern = pattern[0]
      remaining_pattern = pattern[1..-1]
      existing_word = words[word_pattern]
      length = existing_word.length
      word = input[0..length - 1]

      return false if word != existing_word
      rec(remaining_pattern, input[length..-1], words)
    end

    def rec_new_word(pattern, input, words)
      max_len = input.size - pattern.size + 1
      word_pattern = pattern[0]
      remaining_pattern = pattern[1..-1]

      (1..max_len).reduce(false) do |acc, length|
        word = input[0..length - 1]
        next acc if words.values.include? word

        words_clone = words.clone.tap { |l| l[word_pattern] = word }
        acc || rec(remaining_pattern, input[length..-1], words_clone)
      end
    end
  end
end

### Test

describe Wordpattern do
  it 'works' do
    expect(Wordpattern.wordpattern('', '')).to eq(true)
    expect(Wordpattern.wordpattern('a', 'blue')).to eq(true)
    expect(Wordpattern.wordpattern('ab', 'blue')).to eq(true)
    expect(Wordpattern.wordpattern('abba', 'redbluebluered')).to eq(true)

    expect(Wordpattern.wordpattern('abba', 'redredredred')).to eq(false)
    expect(Wordpattern.wordpattern('aaaa', 'redbluebluered')).to eq(false)
    expect(Wordpattern.wordpattern('aaaa', 'redredredred')).to eq(true)
    expect(Wordpattern.wordpattern('aaaa', 'redredred')).to eq(false)
    expect(Wordpattern.wordpattern('abba', 'redblue')).to eq(false)

    expect(Wordpattern.wordpattern('aab', '111111')).to eq(true)
    expect(Wordpattern.wordpattern('abb', '111111')).to eq(true)
  end

  describe 'rec' do
    before do
      allow(Wordpattern).to receive(:rec_existing_word)
      allow(Wordpattern).to receive(:rec_new_word)
    end

    it 'calls rec_existing_word' do
      Wordpattern.rec('abba', 'redbluebluered', { 'a' => 'red' })

      expect(Wordpattern).to have_received(:rec_existing_word).with('abba', 'redbluebluered', { 'a' => 'red' }).once
    end

    it 'calls rec_new_word' do
      Wordpattern.rec('abba', 'redbluebluered', { 'z' => 'r' })

      expect(Wordpattern).to have_received(:rec_new_word).with('abba', 'redbluebluered', { 'z' => 'r' }).once
    end

    it 'false if length not match' do
      expect(Wordpattern.rec('a', '', { 'a' => 'red' })).to be false
      expect(Wordpattern.rec('', 'a', { 'a' => 'red' })).to be false
    end

    it 'true if length match' do
      expect(Wordpattern.rec('', '', { 'a' => 'red' })).to be true
    end
  end

  describe 'rec_new_word' do
    it 'works' do
      allow(Wordpattern).to receive(:rec)

      Wordpattern.rec_new_word('abba', 'redbluebluered', {})

      expect(Wordpattern).to have_received(:rec).with('bba', 'edbluebluered', { 'a' => 'r' }).once
      expect(Wordpattern).to have_received(:rec).with('bba', 'dbluebluered', { 'a' => 're' }).once
      expect(Wordpattern).to have_received(:rec).with('bba', 'bluebluered', { 'a' => 'red' }).once
    end

    it 'works fine on the middle stage' do
      allow(Wordpattern).to receive(:rec)

      Wordpattern.rec_new_word('bba', 'bluebluered', {
        'a' => 'red'
      })

      expect(Wordpattern).to have_received(:rec).with('ba', 'bluered', { 'a' => 'red', 'b' => 'blue' }).once
    end

    it 'returns false if word does match a different pattern' do
      expect(Wordpattern.rec_new_word('a', 'red', {'b' => 'red'})).to be false
    end
  end

  describe 'rec_existing_word' do
    it 'works' do
      allow(Wordpattern).to receive(:rec)

      Wordpattern.rec_existing_word('abba', 'redbluebluered', {
        'a' => 'red'
      })

      expect(Wordpattern).to have_received(:rec).with('bba', 'bluebluered', { 'a' => 'red' }).once
    end

    it 'works fine on the middle stage' do
      allow(Wordpattern).to receive(:rec)

      Wordpattern.rec_existing_word('ba', 'bluered', {
        'a' => 'red',
        'b' => 'blue'
      })

      expect(Wordpattern).to have_received(:rec).with('a', 'red', { 'a' => 'red', 'b' => 'blue' }).once
    end

    it 'works fine on the final stage' do
      allow(Wordpattern).to receive(:rec)

      Wordpattern.rec_existing_word('a', 'red', {
        'a' => 'red'
      })

      expect(Wordpattern).to have_received(:rec).with('', '', { 'a' => 'red' }).once
    end

    it 'returns false if word does not match' do
      expect(Wordpattern.rec_existing_word('a', 'red', {'a' => 'blue'})).to be false
    end
  end
end

