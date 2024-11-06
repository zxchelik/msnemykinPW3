### Домашнее задание 2

## Вопросы и ответы

### 1. Почему сториборды не подходят для крупных проектов?

В крупных проектах от сторибордов часто отказываются по следующим причинам:

- **Проблемы с масштабируемостью**: По мере увеличения количества экранов в проекте сториборды становятся сложными в навигации и управлении.
- **Ограниченная гибкость**: Программный подход позволяет создавать интерфейсы динамически и проще адаптировать их под изменения.
- **Контроль над жизненным циклом**: Сториборды скрывают часть деталей реализации, что может сказаться на производительности и затруднить отладку.

---
```swift
private func configureUI() {
    view.backgroundColor = .systemPink

    configureTitle()
}

private func configureTitle() {
    let title = UILabel() // объявить переменную titleView вверху, перед viewDidLoad()
    title.translatesAutoresizingMaskIntoConstraints = false
    title.text = "WishMaker"
    title.font = UIFont.systemFont(ofSize: 32)
    
    view.addSubview(title)
    NSLayoutConstraint.activate([
        title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
    ])
}
```
---

### 2. Что делают строки 25 и 29?

- **Строка 25** (`title.translatesAutoresizingMaskIntoConstraints = false`): Отключает автоматическое создание ограничений (autoresizing masks) для `UILabel`, чтобы использовать собственные ограничения Auto Layout.
- **Строка 29** (`view.addSubview(title)`): Добавляет `UILabel` (`title`) как подвид (subview) к основному представлению (`view`), что позволяет отображать его на экране и применять к нему ограничения.

---

### 3. Что такое Safe Area Layout Guide?

**Safe Area Layout Guide** — это область на экране, не перекрываемая системными элементами, такими как статус-бар, домашний индикатор или панели навигации. Использование Safe Area помогает корректно размещать элементы интерфейса, чтобы они не пересекались с этими системными компонентами.

---
```swift
private func configureSliders() {
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    view.addSubview(stack)
    stack.layer.cornerRadius = 20
    stack.clipsToBounds = true

    let sliderRed = CustomSlider(title: "Red", min: 0, max: 1)
    let sliderBlue = CustomSlider(title: "Blue", min: 0, max: 255)
    let sliderGreen = CustomSlider(title: "Green", min: 0, max: 255)

    for slider in [sliderRed, sliderBlue, sliderGreen] {
        stack.addArrangedSubview(slider)
    }

    NSLayoutConstraint.activate([
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
    ])

    sliderRed.valueChanged = { [weak self] value in
        self?.view.backgroundColor = ...
    }
}
```
---

### 4. Для чего используется `[weak self]` в строке 23 и почему это важно?

**`[weak self]`** используется для предотвращения создания сильной циклической зависимости (retain cycle) в замыкании (closure). В данном случае замыкание отслеживает изменения значения слайдера и изменяет цвет фона `view`. Без `[weak self]`, `self` (контроллер) удерживался бы в памяти замыканием, что могло бы привести к утечке памяти. С `[weak self]`, замыкание не создает сильной ссылки на контроллер, что позволяет корректно освободить его из памяти при необходимости.

---

### 5. Что означает `clipsToBounds`?

**`clipsToBounds = true`** указывает, что любые подвиды (subviews), выходящие за пределы видимых границ `stack`, будут обрезаны. Это особенно полезно при закругленных углах у `stack`, так как эта настройка ограничивает содержимое границами самого `stack`.

---

### 6. Что такое тип `valueChanged`? Что обозначают `Void` и `Double`?

- **`valueChanged`** — это замыкание с типом `(Double) -> Void`.
- **`Double`** — тип данных, который передает значение слайдера.
- **`Void`** — возвращаемый тип замыкания, указывающий на то, что замыкание ничего не возвращает.
