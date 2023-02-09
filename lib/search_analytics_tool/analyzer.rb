module SearchAnalyticsTool
  class Analyzer
    attr_reader :current_query, :previous_article_search

    def initialize(current_query:)
      @current_query = current_query || ''
      @previous_article_search = ArticleSearch.previous_query_for_user('Darlan')
    end

    def run
      @current_query_words = current_query.split

      return if current_query_words.empty?

      @previous_query_words = previous_article_search&.query&.split || []

      return if p(present_words_equal?) && p(previous_query_words_bigger? || (same_words_number? && previous_last_word_bigger?))

      if (current_query_words_bigger? || same_words_number?) && present_words_equal?
        previous_article_search.update(query: current_query)
      else
        save_search
      end
    end

    private

    attr_reader :current_query_words, :previous_query_words

    def same_words_number?
      current_query_words.size == previous_query_words.size
    end

    def previous_query_words_bigger?
      current_query_words.size < previous_query_words.size
    end

    def current_query_words_bigger?
      current_query_words.size > previous_query_words.size
    end

    def present_words_equal?
      complete_words_size = ([current_query_words.size, previous_query_words.size].min - 1)

      return false if complete_words_size.negative?

      complete_words_comparisons = complete_words_size.times.map do |n|
        current_query_words[n] == previous_query_words[n]
      end

      complete_words_equal = complete_words_comparisons.reduce(true) { |previous, current| previous && current }

      last_current_word = current_query_words[complete_words_size]
      last_previous_word = previous_query_words[complete_words_size]

      last_word_size = [last_current_word.size, last_previous_word.size].min - 1
      last_word_similar = last_current_word[..last_word_size] == last_previous_word[..last_word_size]

      last_word_similar && complete_words_equal
    end

    def previous_last_word_bigger?
      previous_query_words.last.size > current_query_words.last.size
    end

    def save_search
      ArticleSearch.new(username: 'Darlan', query: current_query).save!
    end
  end
end
