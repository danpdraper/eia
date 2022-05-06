import math
import statistics


class Statistic(object):
    @staticmethod
    def apply(data):
        raise NotImplementedError('Subclasses must override this method.')


class EightiethPercentile(Statistic):
    @staticmethod
    def apply(data):
        return sorted(data)[math.floor(0.8 * len(data)) - 1]


class Mean(Statistic):
    @staticmethod
    def apply(data):
        return statistics.mean(data)


class Median(Statistic):
    @staticmethod
    def apply(data):
        return statistics.median(data)


class NinetiethPercentile(Statistic):
    @staticmethod
    def apply(data):
        return sorted(data)[math.floor(0.9 * len(data)) - 1]


class NinetyninthPercentile(Statistic):
    @staticmethod
    def apply(data):
        return sorted(data)[math.floor(0.99 * len(data)) - 1]


EIGHTIETH_PERCENTILE = EightiethPercentile
MEAN = Mean
MEDIAN = Median
NINETIETH_PERCENTILE = NinetiethPercentile
NINETYNINTH_PERCENTILE = NinetyninthPercentile


STATISTICS = {
    'eightieth_percentile': EIGHTIETH_PERCENTILE,
    'mean': MEAN,
    'median': MEDIAN,
    'ninetieth_percentile': NINETIETH_PERCENTILE,
    'ninetyninth_percentile': NINETYNINTH_PERCENTILE,
}
