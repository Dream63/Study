from buff import Buff
from random import choice
from swords import SwordsSecond


def test_buff_berserk():
    """Тестуємо правильність берсерка"""
    # 1 - задання початкових даних - передане
    obj = SwordsSecond.create_with_random_rarity(
        'Супер крутий меч який точно пройде всі тести')
    baseDmg = obj.damage
    baseVit = obj.vitality
    # 2 - виклик коду який тестується
    result = obj.apply_buff("berserk")

    # 3 - перевірка тведржень
    assert (baseVit == obj.vitality * 2) & (baseDmg * 2 ==
                                            obj.damage), "Неправильні значення після накладення бафу!"
    assert (isinstance(result, str)), "Результат має бути стрічкою!"
