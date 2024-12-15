#!/bin/bash

# Получение списка добавленных/изменённых .txt файлов
txt_files=$(git diff --cached --name-only --diff-filter=AM | grep '\.txt$')

# Если нет .txt файлов, пропускаем проверку
if [ -z "$txt_files" ]; then
    echo "Нет .txt файлов для проверки."
    exit 0
fi

# Функция для проверки строки "Борись!" в файле
check_txt_file() {
    local file="$1"
    # Проверяем, содержит ли файл строку "Борись!"
    if ! grep -q "Борись!" "$file"; then
        echo "Ошибка: файл $file не содержит строку 'Борись!'."
        return 1
    fi
    return 0
}

# Проверяем каждый .txt файл
for file in $txt_files; do
    # Убедимся, что файл существует в рабочей директории
    if [ -f "$file" ]; then
        check_txt_file "$file" || exit 1
    else
        echo "Ошибка: файл $file не найден в рабочей директории."
        exit 1
    fi

done

echo "Все .txt файлы содержат строку 'Борись!'."
exit 0