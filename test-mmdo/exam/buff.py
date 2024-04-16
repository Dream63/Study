class Buff:
    def __init__(self, obj) -> None:
        """Задаємо початкові атрибути із значенням None, яке буде перевизначене при накладенні бафів"""
        self.name = None
        self.damage = None
        self.vitality = None
        self.obj = obj

    def __format_return_value(self):
        """Форматує значення яке буде повіртатись після накладення бафу"""
        return f"Застосовано {self.name}: Шкода {self.damage} ||| Витривалість {self.vitality}"
    
    def sharpening(self):
        """Заточення"""
        # Базові значення накладених бафів
        if self.obj.buff:
            return "Неможливо накласти 2 Бафи"
        
        self.name = "Заточення"
        self.damage = 4
        self.vitality = -1
        # я тут зробив помилку і замість += поставив =, тому в мене не проходили тести
        self.obj.damage += self.damage
        self.obj.vitality += self.vitality
        return self.__format_return_value()
    
    def poisoning(self):
        """Змазуємо Меч отрутою"""
        if self.obj.buff:
            return "Неможливо накласти 2 Бафи"
        self.name = "Отрута"
        self.damage = 2
        self.vitality = 0
        self.obj.damage += self.damage
        return self.__format_return_value()
    
    def enchantment(self):
        """Зачаровуємо Меч на витривалість"""
        if self.obj.buff:
            return "Неможливо накласти 2 Бафи"
        self.name = "Зачарування"
        self.damage = int(0)
        self.vitality = int(5)
        self.obj.vitality += self.vitality
        return self.__format_return_value()
    
    def crystals(self):
        """Застосовуємо криста Мани"""
        if self.obj.buff:
            return "Неможливо накласти 2 Бафи"
        self.name = "Кристал Мани"
        self.damage = -1
        self.vitality = 3
        self.obj.vitality += 3
        self.obj.damage -= 1
        return self.__format_return_value()

    def berserk(self):
        """Впадаємо в стан Берсерка"""
        if self.obj.buff:
            return "Неможливо накласти 2 Бафи"
          
        self.name = "Берсерк"
        self.damage = self.obj.damage * 2 # вдвічі збільшуємо значення шкоди 
        self.vitality = self.obj.vitality / 2
        self.obj.vitality = self.vitality
        self.obj.damage = self.damage
        return self.__format_return_value()