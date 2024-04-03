# Звіт до роботи

## Тема: Віртуальні середовища

### Мета: навчитись основам роботи з віртуальними середовмщами

---

### Основи роботи з сторонніми бібліотеками

На ноутбуці встановлена версія pip 24.0.

Встановлені пакети:

![Packages](/test-mmdo/lab-1/screenshots/packages.png 'Packages')

Бібліотека requests:

```
08:37:57.913 [info] Kernel acknowledged execution of cell 0 @ 1712122677913
08:37:58.768 [info] End cell 0 execution after 0.855s, completed @ 1712122678768, started @ 1712122677913
```

```py
import requests
r = requests.get('https://api.github.com/events')
r = requests.post('https://httpbin.org/post', data={'key': 'value'})
```

```
08:37:57.913 [info] Kernel acknowledged execution of cell 0 @ 1712122677913
08:37:58.768 [info] End cell 0 execution after 0.855s, completed @ 1712122678768, started @ 1712122677913
08:40:34.452 [info] Handle Execution of Cells 0 for d:\Study\test-mmdo\lab-1\lab-1.ipynb
08:40:34.456 [info] Kernel acknowledged execution of cell 0 @ 1712122834456
08:40:35.229 [info] End cell 0 execution after 0.773s, completed @ 1712122835229, started @ 1712122834456
08:42:41.969 [info] Handle Execution of Cells 0 for d:\Study\test-mmdo\lab-1\lab-1.ipynb
08:42:41.974 [info] Kernel acknowledged execution of cell 0 @ 1712122961974
08:42:43.374 [info] End cell 0 execution after 1.4s, completed @ 1712122963374, started @ 1712122961974
```

Операції над requests:

![request](/test-mmdo/lab-1/screenshots/uninstal_requests.png 'Packrequestages')

### Робота у віртуальному середовищі

Встановлення VENV:

![request](/test-mmdo/lab-1/screenshots/Venv.png 'Packrequestages')

Команда вивела інформацію про бібліотеку requests тому що був проведений запит

### Робота з Pipenv

Команди pipenv:

```
  --where                         Output project home information.
  --venv                          Output virtualenv information.
  --py                            Output Python interpreter information.
  --envs                          Output Environment Variable options.
  --rm                            Remove the virtualenv.
  --bare                          Minimal output.
  --man                           Display manpage.
  --support                       Output diagnostic information for use in
                                  GitHub issues.
  --site-packages / --no-site-packages
                                  Enable site-packages for the virtualenv.
                                  [env var: PIPENV_SITE_PACKAGES]
  --python TEXT                   Specify which version of Python virtualenv
                                  should use.
  --clear                         Clears caches (pipenv, pip).  [env var:
                                  PIPENV_CLEAR]
  -q, --quiet                     Quiet mode.
  -v, --verbose                   Verbose mode.
  --pypi-mirror TEXT              Specify a PyPI mirror.
  --version                       Show the version and exit.
  -h, --help                      Show this message and exit.
```

В файлах Pipfile та Pipfile.lock знаходиться інформація про середовище.
