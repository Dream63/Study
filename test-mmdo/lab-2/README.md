# Звіт до роботи

## Тема: Знайомство з ООП

### Мета: навчитись основам роботи з ООП

### Створюємо перший class

Я скопіював даний код в свій проєкт та запустив його:

```py

class MyName:
    """Опис класу / Документація
    """
    total_names = 0 #Class Variable

    def __init__(self, name=None) -> None:
        self.name = name if name is not None else self.anonymous_user().name #Class attributes / Instance variables
        MyName.total_names += 1 #modify class variable
        self.my_id = self.total_names

    @property
    def whoami(self):
        """Class property
        return: повертаємо імя
        """
        return f"My name is {self.name}"

    @property
    def my_email(self) -> str:
        """Class property
        return: повертаємо емейл
        """
        return self.create_email()

    def create_email(self) -> str:
        """Instance method
        """
        return f"{self.name}@itcollege.lviv.ua"

    @classmethod
    def anonymous_user(cls):
        """Classs method
        """
        return cls("Anonymous")

    @staticmethod
    def say_hello(message="Hello to everyone!"):
        """Static method
        """
        return f"You say: {message}"


print("Let's Start!")

names = ("Bohdan", "Marta", None)
all_names = {name: MyName(name) for name in names}

for name, me in all_names.items():
    print(f"""{">*<"*20}
This is object: {me}
This is object attribute: {me.name} / {me.my_id}
This is {type(MyName.whoami)}: {me.whoami} / {me.my_email}
This is {type(me.create_email)} call: {me.create_email()}
This is static {type(MyName.say_hello)} with defaults: {me.say_hello()}
This is class variable {type(MyName.total_names)}: from class {MyName.total_names} / from object {me.total_names}
{"<*>"*20}""")

print(f"We are done. We create {me.total_names} names! ??? Why {MyName.total_names}?")
```

Програма вивела наступний результат:

```
Let's Start!
>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<
This is object: <__main__.MyName object at 0x00000247381D2F50>
This is object attribute: Bohdan / 1
This is <class 'property'>: My name is Bohdan / Bohdan@itcollege.lviv.ua
This is <class 'method'> call: Bohdan@itcollege.lviv.ua
This is static <class 'function'> with defaults: You say: Hello to everyone!
This is class variable <class 'int'>: from class 4 / from object 4
<*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*>
>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<
This is object: <__main__.MyName object at 0x00000247381D0350>
This is object attribute: Marta / 2
This is <class 'property'>: My name is Marta / Marta@itcollege.lviv.ua
This is <class 'method'> call: Marta@itcollege.lviv.ua
This is static <class 'function'> with defaults: You say: Hello to everyone!
This is class variable <class 'int'>: from class 4 / from object 4
<*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*>
>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<>*<
This is object: <__main__.MyName object at 0x00000247381D0C90>
This is object attribute: Anonymous / 4
This is <class 'property'>: My name is Anonymous / Anonymous@itcollege.lviv.ua
This is <class 'method'> call: Anonymous@itcollege.lviv.ua
This is static <class 'function'> with defaults: You say: Hello to everyone!
This is class variable <class 'int'>: from class 4 / from object 4
<*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*>
We are done. We create 4 names! ??? Why 4?
```

Я модифікував програму додавши до неї своє ім'я

> Чому коли передаємо значення None створюється обєкт з іменем Anonymous?

За умови, якщо створюється об'єкт класу з ім'ям None, викликається метод `anonymous_user()`, що змінює ім'я на Anonymous

> Як змінити текст привітання при виклику методу say_hello()? Допишіть цю частину коду.

Змінивши текст змінної `message` в описі функції `say_hello()`.

```py
def say_hello(message="Hello World"):
```

> Допишіть функцію в класі яка порахує кількість букв і імені (підказка: використайте функцію len());

```py
def name_length(self) -> int:
    return len(self.name)
```

> Порахуйте кількість імен у списку names та порівняйте із виведеним результатом. Дайте відповідь чому маємо різну кількість імен?

Якщо задати ім'я `None` клас викликається двічі, раз як `None`, інший як `Anonymous`
