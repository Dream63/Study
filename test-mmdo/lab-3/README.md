# Звіт до роботи

## Тема: Тестування

### Мета: навчитись основам роботи з тестуваннями

### Перевірка assert

Власний метод assert

```py
a = input("Введіть місяць Народження: ")
assert a.isdigit() & a > 0 & a <= 12, "Неправильне значення!"
print(f"Місяць Народження: {a}")
```

Власні тестові провірки класу:

```py
class Figure:
    def __init__(self, type, length) -> None:
        assert length > 0, "Довжина має бути більшою за 0!"
        assert type in ["квадрат", "прямокутник", "трикутник"], "Дозволені фігури: квадрат, прямокутник, трикутник"
        self.type = type
        self.length = length

#a = Figure("трапеція", 12)
#b = Figure("квадрат", 0)
c = Figure("прямокутник", 123456789)
#d = Figure("паралелограм", -6)
```

Модифікація заданого класу:

```py
class Name:
    def __init__(self, name, hobby) -> None:
        if name not in ["Богдан", "Анонім", "Дмитро"]:
            raise ValueError("Дозволені імена: Богдан, Анонім")
        self.name = name
        assert hobby == "", "Хоббі обов'якове >:((("
        self.hobby = hobby

#a = Name("Богдан" , "")
b = Name("Дмитро", "Програмування")
```

### Юніт тести

Даний клас

```py
class Figure:
    FIGURES = ["квадрат", "прямокутник", "трикутник"]
    def __init__(self, type, length) -> None:
        assert length > 0, "Довжина має бути більшою за 0!"
        assert type in self.FIGURES, "Дозволені фігури: квадрат, прямокутник, трикутник"
        self.type = type
        self.length = length

    @property
    def get_figure_type(self):
        return self.type

    @property
    def get_figure_length(self):
        return self.type # робимо помилку

```

Створені мною об'єкти та виклик методів:

```py
a = Figure("квадрат", 5)
b = Figure("трикутник", 2)

print(a.get_figure_type)
print(b.get_figure_length)
```

Виконується `test_figure_type`. Провалюється `test_figure_lengh` (оскільки допущена помилка)

Я розширив функціонал класу добавивши bool `isPerfect` (Чи рівностороння фігура) та метод, що повертає це значення.

```py
    def __init__(self, type, length, isPerfect) -> None:
        assert length > 0, "Довжина має бути більшою за 0!"
        assert type in self.FIGURES, "Дозволені фігури: квадрат, прямокутник, трикутник"
        self.type = type
        self.length = length
        self.isPerfect = isPerfect

    @property
    def is_figure_perfect(self):
        return self.isPerfect
```

Розширив функціонал тесту добавивши перевірку на це значення:

```py
    def test_figure_is_perfect(self):
        print(
            f"Тестуємо вивід, має бути: {self.isPerfect} == {self.obj.is_figure_perfect}")
        self.assertEqual(self.isPerfect, self.obj.is_figure_perfect,
                         "Властивість is_figure_perfect повертає непривильне значення!")
```

### Юніт тести з використання бібліотеки PyTest

Створення простого тесту, що знаходиться в файлі з класом фігури:

```py
def test_app_triangle():
    """Test if we create triangle figure.
    """
    fig = "трикутник"
    triangle = Figure(fig, 4)
    assert triangle.type == fig, f"Фігура має бути {fig}"
```

Тест виконався та пinstall coverage --devрограма вивела наступне:

```
test session starts
platform win32 -- Python 3.11.8, pytest-8.1.1, pluggy-1.4.0
rootdir: D:\Study\test-mmdo\lab-3
collected 1 item

test.py . [100%]

1 passed in 0.02s
```

### Візуалізація результатів та покриття коду Coverage (pytest-cov)

Dізуалізація результаів через браузер:

[website](/test-mmdo/lab-3/htmlcov/index.html)
