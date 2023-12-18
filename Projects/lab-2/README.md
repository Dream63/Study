# Звіт до роботи

## Тема: Основи програмування на Python

## Мета: навчитися основам мови програмування Python

1.  Я створив файл python .ipynb в якому буду виконувати базові приклади.

    1.  Ознайомився з онвоними типами даних:
        ```py
        a = "text" #Типи Python
        b = 1 # числова Змінна
        c = ['a', 1, 1.1, "lel"] # List
        d = {"a": "Слово", "b": 1} # Dict
        e = ("a", "v",) # Tuple
        f = {"ss", } # Set
        ```
    1.  Вивів вбудовані констнати:
        ```py
        print("text const", True) #Виведення констант
        ```
    1.  Вивів результат вбудованих функцій:
        ```py
        print(abs(-12.5), f"є рівним {abs(12.5)}") #Використання стандартних функцій
        ```
    1.  Ознайомився з циклами:
        ```py
        letters = ["a", "b", "c"] #Використання циклу
        for i in range(len(letters)):
        print(f"На позиції {i} знаходиться буква {letters[i]}")
        ```
    1.  Ознайомився з розгалуженнями
        ```py
        A = True #Використання розгалужень
        print("Значить А=True" if A else "Значить А=False")
        ```
    1.  Ознайомився з конструкцією try>exept>finally:
        ```py
        A = 0 #Конструкція try>exept>finally
        try:
            print("Що буде якщо", 10/A, "?")
        except Exception as e:
            print(e)
        finally:
            print("А вот воно що!")
        ```
    1.  Ознайомився з контекст-менеджером with:
        ```py
        with open("README.md", "r") as f: #оператор with
            for line in f:
                print(line)
                break
        ```
    1.  Ознайомився з lambda:
        ```py
        this_is_lambda = lambda first, last: f'Цей код написав: {first} {last}' #lambda
        print("Це просто функція:", this_is_lambda)
        print("Це її виклик:", this_is_lambda('Богдан', 'Бугиль'))
        ```

### ChatGPT про основи python

Python - це потужна, високорівнева мова програмування, яка використовується для розробки різноманітних застосунків, від веб-сайтів до наукових досліджень. Ось основи мови програмування Python:

1. **Змінні та Типи Даних:**

   ```python
   # Змінні
   x = 5
   y = "Hello, World!"

   # Типи даних
   int_var = 10
   float_var = 3.14
   str_var = "текст"
   bool_var = True
   ```

2. **Оператори:**

   ```python
   # Арифметичні операції
   result = 10 + 5
   result = 10 * 2
   result = 10 / 3  # результат - float
   result = 10 // 3  # результат - int (цілочисельне ділення)
   result = 10 % 3  # залишок від ділення

   # Логічні операції
   is_true = True and False
   is_false = True or False
   not_true = not True
   ```

3. **Умовні Конструкції:**

   ```python
   if condition:
       # код, що виконується, якщо умова вірна
   elif another_condition:
       # код, що виконується, якщо попередня умова невірна, а ця - вірна
   else:
       # код, що виконується, якщо всі попередні умови невірні
   ```

4. **Цикли:**

   ```python
   # for-цикл
   for i in range(5):
       print(i)

   # while-цикл
   count = 0
   while count < 5:
       print(count)
       count += 1
   ```

5. **Функції:**

   ```python
   def greet(name):
       print("Hello, " + name + "!")

   greet("John")
   ```

6. **Структури Даних:**

   - **Списки:**

     ```python
     my_list = [1, 2, 3, 4, 5]
     ```

   - **Кортежі:**

     ```python
     my_tuple = (1, 2, 3)
     ```

   - **Словники:**
     ```python
     my_dict = {"key1": "value1", "key2": "value2"}
     ```

7. **Робота з Файлами:**

   ```python
   # Зчитування з файлу
   with open('file.txt', 'r') as file:
       content = file.read()

   # Запис у файл
   with open('new_file.txt', 'w') as file:
       file.write('Hello, File!')
   ```

8. **Обробка Винятків:**
   ```python
   try:
       # код, який може викликати виняток
   except ExceptionType as e:
       # код обробки винятку
   finally:
       # необов'язковий блок, який виконується завжди
   ```

Це лише огляд основ Python. Мова є дуже гнучкою та має багато функцій і бібліотек для різноманітних завдань. Для глибшого розуміння рекомендується пройти додаткові матеріали та вправи.

## Висновок: я навчився основам мови програмування python
