from random import choice
from buff import Buff


class SwordsSecond:
    """Це наш перший клас який використовує конструктор для визначення наперед заданих атрибутів"""
    # Це класова глобальна змінна, її можна використовувати будь-де всередині класі або ж передавати кудиінде
    rarity_map = {
        "White": "Предмет має Базову якість.",
        "Blue": "Предмет має Покращену якість та збільшені характеристики.",
        "Green": "Предмет має Продвинута якість та достатньо високі показники нанесення шкоди та витривалості.",
        "Epic": "Предмет має Епічну якість, найвищі характеристики та бонуси."
    }
    total_swords = 0

    def __init__(self, name: str, rarity: str, damage: int, vitality: int, bonus: list = []) -> None:
        """Це Конструктор, він ініціалізує Обєкт за допомогою Аргументів які передаються в нього та присвоюються Атрибутам

        :param name: Цей аргумент визначає назву Меча;
        :param rarity: Цей аргумент відповідає за рідкісність предмету Меча;
        :param damage: Характеристика нанесення шкоди нашим Мечем;
        :param vitality: Характеристика міцності Меча;
        :param bonus: Список додаткових бонусів для Меча (Не реалізований функціонал);
        """
        self.name = name
        self.rarity = rarity if rarity in list(
            SwordsSecond.rarity_map.keys()) else None
        self.damage = damage
        self.vitality = vitality
        self.bonus = bonus
        self.buff: list = []
        # Тут просто будемо контролювати скільки мечів було створено
        SwordsSecond.total_swords += 1

    # Створимо альтернативний конструктор, який буде створювати предмет меча відповідно до заданої рідкісності
    @classmethod
    def create_with_rarity(cls, name: str, rarity: str):
        """Альтернативний конструктор, створює обєкт Меча відповідно до переданої рідкісності
        :param name: Імя меча 
        :param rarity: Рідкісність
        """
        l = list(SwordsSecond.rarity_map.keys())
        if rarity in l:
            # тут ми знайдемо під яким індексом знаходиться задана якість меча
            i = l.index(rarity)
            return cls(name, rarity, 3 + i, 5 + i**2)
        raise ValueError(
            f"Введено направильне значення рідкісності предмету, повинно бути: {l}")

    @classmethod
    def create_with_random_rarity(cls, name: str):
        """Альтернативний конструктор, створює обєкт Меча з випадковою рідкісністю
        :param name: Імя меча
        """
        return cls.create_with_rarity(name, choice(list(SwordsSecond.rarity_map.keys())))

    @property
    def hit(self):
        """Визначає кількісь шкоди яку ми можемо нанести супротивнику"""
        return self.damage

    @property
    def rarity_type(self):
        """Дана проперті буде нам надавати інформацію про рідкісність предмету та визначати чи відповідає вона умовам"""
        if self.rarity in SwordsSecond.rarity_map.keys():
            return SwordsSecond.rarity_map[self.rarity]
        return "Предмет зломаний, можете викинути його у сміття."

    @property
    def info(self) -> str:
        """Виводить інформацію про Меч.
        :param self: Нам потрібен лише вказівник на обєкт з яким ми працюємо; 
        """
        p = f"""<<< Характеристика предмету {self.name} >>>
Рідкісність: {self.rarity}, {self.rarity_type}
Нанесення Шкоди: {self.damage}
Витривалість: {self.vitality}
Унікальний ефект: {self.bonus}
Накладені Бафи: {self.buff}"""
        # print(p)
        return p

    def apply_random_buff(self) -> str:
        """Накладає випадковий Баф на меч. Бафи реалізовані як окремий клас."""
        # Вибираємо випадковий баф з можливих та уникаємо магачних методів з подвійним підкресленням
        m = choice([method for method in dir(Buff)
                   if method.startswith('__') is False])
        # застосовуємо випадковий баф до меча, але не викликаємо його
        bb = Buff(self)
        b = getattr(bb, m)  # тут в нас повертається функція
        # викликаємо власне вибраний метод для накладання бафу
        b()  # тут викличеться функція та будуть змінені характеристики меча
        self.buff.append(bb)
        return f"Наклали баф {bb.name} що додає Шкоди: {bb.damage} та Витривалості: {bb.vitality} на меч {self.name}"
        # return "Неправильний баф, нічого не накладено"

    def apply_buff(self, buff_name) -> str:
        """Накладає випадковий Баф на меч. Бафи реалізовані як окремий клас."""
        bb = Buff(self)
        b = getattr(bb, buff_name)  # тут в нас повертається функція
        # викликаємо власне вибраний метод для накладання бафу
        b()  # тут викличеться функція та будуть змінені характеристики меча
        self.buff.append(bb)
        return f"Наклали баф {bb.name} що додає Шкоди: {bb.damage} та Витривалості: {bb.vitality} на меч {self.name}"
        # return "Неправильний баф, нічого не накладено"

    def expire_buff(self):
        """Завершує дію накледених бафів"""
        if self.buff:
            b = self.buff.pop()
            self.damage -= b.damage
            self.vitality -= b.vitality
            return f"Завершилась дія бафу {b.name}"
        return "На мечі немає ніяких бафів"

    def attack(self, item):
        if isinstance(item, SwordsSecond):
            item.vitality -= self.damage
            return f"{self.name} замахнувся та наніс {self.damage} шкоди мечу {item.name} у якого залишилось витривалосьті {item.vitality}"
        else:
            return f"{self.name} промахнулись та попали НЕ по мечу а по {item}!"
