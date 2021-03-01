module Arroyo
  module HumanTime
    def self.humanize(date_to, date_from = Time.now.utc)
      date_to = date_from unless date_to

      diff = date_from.to_time - date_to.to_time
      
      is_past = diff >= 0
      if diff.abs.round <= 59
        if is_past
          return 'just now'
        end
        date_string = 'less than a minute'

      else
        date_string = HumanTimeWords.humanize(diff.abs.round, is_past)
      end

      is_past ? "#{date_string} ago" : "in #{date_string}"
    end

    class HumanTimeWords
      def self.humanize(seconds, is_past=true)
        verb_agreement(resolution(seconds))
      end

      private
      MINUTE = 60
      HOUR   = 60 * MINUTE
      DAY    = 24 * HOUR
      WEEK   = 7  * DAY
      MONTH  = 4  * WEEK
      YEAR   = 12 * MONTH
      
      DEFAULT_THRESHOLDS = {
        :seconds => [45, :minutes],  # seconds to minute
        :minutes => [45, :hours],    # minutes to hour
        :hours => [22, :days],       # hours to day
        :days => [26, :months],      # days to month
        :months => [11, :years],     # months to year
        :years => [1000, :years]
      }

      def self.thresholds
        #TODO: Could allow runtime-configurable thresholds here
        DEFAULT_THRESHOLDS
      end

      def self.resolution(diff)
        if diff >= YEAR
          compute_thresholds(diff, YEAR, :years)
        elsif diff >= MONTH
          compute_thresholds(diff, MONTH, :months)
        #elsif diff >= WEEK
        #  [(diff / WEEK).round, 'weeks']
        elsif diff >= DAY
          compute_thresholds(diff, DAY, :days)
        elsif diff >= HOUR
          compute_thresholds(diff, HOUR, :hours)
        else
          compute_thresholds(diff, MINUTE, :minutes)
        end
      end

      def self.compute_thresholds(diff, demoninator, term)
        r = diff.to_f / demoninator.to_f
        threshold = thresholds[term]
        if ( r >= threshold[0] )
          r = 1
          term = threshold.last
        end
        # tuple of [4, 'years']
        [r.round, term.to_s]
      end


      def self.verb_agreement(resolution)
        if resolution[0] == 1 && resolution.last == 'hours'
          'an hour'
        elsif resolution[0] == 1
          "a #{resolution.last[0...-1]}"
        else
          resolution.join(' ')
        end
      end
    end
  end
end
