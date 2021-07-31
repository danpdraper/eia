class MockSimilarityCalculator(object):
    def __init__(self, similarity_values):
        self.similarity_values = similarity_values

    def calculate(self, first_text, second_text):
        return self.similarity_values[(first_text, second_text)]
