import unittest
from random import choice, randint


class Figure:
    FIGURES = ["квадрат", "прямокутник", "трикутник"]

    def __init__(self, type, length, isPerfect) -> None:
        assert length > 0, "Довжина має бути більшою за 0!"
        assert type in self.FIGURES, "Дозволені фігури: квадрат, прямокутник, трикутник"
        self.type = type
        self.length = length
        self.isPerfect = isPerfect

    @property
    def get_figure_type(self):
        return self.type

    @property
    def get_figure_length(self):
        return self.type  # робимо помилку

    @property
    def is_figure_perfect(self):
        return self.isPerfect


class TestFigure(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        """Виконається лише раз на початку тестів
        """
        pass

    def setUp(self) -> None:
        """Виконується кожного разу коли запускається тест
        """
        self.figure = choice(Figure.FIGURES)
        self.length = randint(1, 10)
        self.isPerfect = choice(list([True, False]))
        self.obj = Figure(self.figure, self.length, self.isPerfect)
        return super().setUp()

    def tearDown(self) -> None:
        del self.obj
        return super().tearDown()

    def test_figure_type(self):
        print(
            f"Тестуємо вивід, має бути: {self.figure} == {self.obj.get_figure_type}")
        self.assertEqual(self.figure, self.obj.get_figure_type,
                         "Властивість get_figure_type повертає непривильну фігуру!")

    def test_figure_lengh(self):
        print(
            f"Тестуємо вивід, має бути: {self.length} == {self.obj.get_figure_length}")
        self.assertEqual(self.length, self.obj.get_figure_length,
                         "Властивість get_figure_length повертає непривильну довжину!")

    def test_figure_is_perfect(self):
        print(
            f"Тестуємо вивід, має бути: {self.isPerfect} == {self.obj.is_figure_perfect}")
        self.assertEqual(self.isPerfect, self.obj.is_figure_perfect,
                         "Властивість is_figure_perfect повертає непривильне значення!")

    def test_obj(self):
        print(
            f"Тестуємо вивід, має бути: {self.length} == {self.obj.get_figure_length}")
        with self.assertRaises(AssertionError):
            # Спробуємо створити обєкт з недозволеними параметрими, в нас має бути помилка AssertionError
            Figure("коло", 1)


if __name__ == '__main__':
    unittest.main()  # unittest.main(verbosity=2) щоб був більш детальний вивід
