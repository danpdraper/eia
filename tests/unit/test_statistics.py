import pytest

import eia.statistics as statistics


class TestStatistic(object):
    def test_apply_raises_not_implemented_error(self):
        with pytest.raises(NotImplementedError):
            statistics.Statistic.apply([])


class TestEightiethPercentile(object):
    def test_apply_returns_eightieth_percentile_of_supplied_data(self):
        # Even number of elements
        data = [40, 39, 38, 37, 36, 35, 34, 33, 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21]
        assert 36 == statistics.EightiethPercentile.apply(data)
        # Odd number of elements
        data = [40, 39, 38, 37, 36, 35, 34, 33, 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20]
        assert 35 == statistics.EightiethPercentile.apply(data)


class TestMean(object):
    def test_apply_returns_mean_of_supplied_data(self):
        data = [1, 1, 2, 2, 3, 3, 4, 4, 16]
        assert 4 == statistics.Mean.apply(data)


class TestMedian(object):
    def test_apply_returns_median_of_supplied_data(self):
        data = [1, 1, 2, 2, 3, 3, 4, 4, 16]
        assert 3 == statistics.Median.apply(data)


class TestNinetiethPercentile(object):
    def test_apply_returns_ninetieth_percentile_of_supplied_data(self):
        # Even number of elements
        data = [40, 39, 38, 37, 36, 35, 34, 33, 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21]
        assert 38 == statistics.NinetiethPercentile.apply(data)
        # Odd number of elements
        data = [40, 39, 38, 37, 36, 35, 34, 33, 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20]
        assert 37 == statistics.NinetiethPercentile.apply(data)


class TestNinetyninthPercentile(object):
    def test_apply_returns_ninetyninth_percentile_of_supplied_data(self):
        # Even number of elements
        data = [
            120, 119, 118, 117, 116, 115, 114, 113, 112, 111,
            110, 109, 108, 107, 106, 105, 104, 103, 102, 101,
            100, 99, 98, 97, 96, 95, 94, 93, 92, 91,
            90, 89, 88, 87, 86, 85, 84, 83, 82, 81,
            80, 79, 78, 77, 76, 75, 74, 73, 72, 71,
            70, 69, 68, 67, 66, 65, 64, 63, 62, 61,
            60, 59, 58, 57, 56, 55, 54, 53, 52, 51,
            50, 49, 48, 47, 46, 45, 44, 43, 42, 41,
            40, 39, 38, 37, 36, 35, 34, 33, 32, 31,
            30, 29, 28, 27, 26, 25, 24, 23, 22, 21,
        ]
        assert 119 == statistics.NinetyninthPercentile.apply(data)
        # Odd number of elements
        data = [
            120, 119, 118, 117, 116, 115, 114, 113, 112, 111,
            110, 109, 108, 107, 106, 105, 104, 103, 102, 101,
            100, 99, 98, 97, 96, 95, 94, 93, 92, 91,
            90, 89, 88, 87, 86, 85, 84, 83, 82, 81,
            80, 79, 78, 77, 76, 75, 74, 73, 72, 71,
            70, 69, 68, 67, 66, 65, 64, 63, 62, 61,
            60, 59, 58, 57, 56, 55, 54, 53, 52, 51,
            50, 49, 48, 47, 46, 45, 44, 43, 42, 41,
            40, 39, 38, 37, 36, 35, 34, 33, 32, 31,
            30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20,
        ]
        assert 118 == statistics.NinetyninthPercentile.apply(data)
