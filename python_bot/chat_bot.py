import socket
import threading

import random
import json
import pickle
import numpy as np
import os

import nltk
from nltk.stem import WordNetLemmatizer

import tensorflow as tf

from pymystem3 import Mystem

m = Mystem()

# SERVER SETTINGS
SERVER = ''
PORT = 3777
ADDR = (SERVER, PORT)
FORMAT = 'utf-8'

# BOT SETTINGS
lemmatizer = WordNetLemmatizer()
intents = json.loads(open('intents.json', 'r', encoding='utf-8').read())
words = pickle.load(open('words.pkl','rb'))
classes = pickle.load(open('classes.pkl','rb'))
model = tf.keras.models.load_model('chatbot_model.h5')

counter_before_transfer_to_support = 3          # Количество неудачных попыток распознования информации от поьлзователя до перевода на поддержку

ignore_letters = ['?', '!', '.', ',', ')', '(', ' (', ') ', '), ', ', ', '-', '/']

def clean_up_sentence(sentence):
    #sentence_words = nltk.word_tokenize(sentence)
    #print('Запрос после токенизации', sentence_words)
    #sentence_words = [lemmatizer.lemmatize(word) for word in sentence_words]
    sentence_words = [word.lower() for word in m.lemmatize(sentence) if word not in ignore_letters and word != '\n' and word != ' ']
    print('Запрос после лемматизации', sentence_words)
    return sentence_words

def bag_of_words(sentence):
    sentence_words = clean_up_sentence(sentence)
    bag = [0] * len(words)
    for w in sentence_words:
        for i, word in enumerate(words):
            if word == w:
                bag[i] = 1          
    return np.array(bag)        

def predict_class(sentence):
    bow = bag_of_words(sentence)
    print(f'Мешок: {bow}')
    res = model.predict(np.array([bow]))[0]
    ERROR_THRESHOLD = 0.1
    results = [[i, r] for i, r in enumerate(res) if r > ERROR_THRESHOLD]
    results.sort(key=lambda x: x[1], reverse=True)
    return_list = []
    for r in results:
        return_list.append({'intent': classes[r[0]], 'probability': str(r[1])})
        print(f'Класс {classes[r[0]]} с вероятностью: {str(r[1])}')
    
    return return_list

def get_response(intents_list, intents_json):
    tag = intents_list[0]['intent']
    list_of_intents = intents_json['intents']
    for i in list_of_intents:
        if i['tag'] == tag:
            result = random.choice(i['responses'])
            break
    return result


# CREATE TCP socket
serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
try:
    serversocket.bind(ADDR)
except socket.error as e:
    print(str(e))

# Функция для перехвата подключения клиента в отдельный поток
def handle_client(clientsocket, addr):
    сount_err = 0
    connected_to_bot = True
    print(f'Клиент {addr} подключился к серверу')
    print('Ждем сообщений ... ')
    msg = clientsocket.recv(1024)
    if msg.decode(FORMAT) == '[SUPPORT_TOCKEN]: a7di32dvf3quco87wcv82vcdsac': connected_to_bot = False
    print(f'Клиент {addr}: ', msg.decode(FORMAT))
    clientsocket.sendto(str('Здравствуйте, я Ваш персональный робот-помощник. Какой у Вас вопрос?').encode(FORMAT), addr)
    
    while connected_to_bot:                                                                                     # Слушаем клиента, отвечает бот
        msg = clientsocket.recv(4096)
        msg = msg.decode(FORMAT)
        print(f'Клиент {addr}: ', msg)

        if msg.lower() == '':
            msg = ('Вы отправили пустой запрос, на него я не могу ответить. Задайте свой вопрос.').encode(FORMAT)
        elif msg.lower() in ['привет', 'ghbdtn', 'хай', "здравствуйте", "здравствуй", "здорова", "хай"]:
            msg = ('Здравствуйте, я Ваш персональный робот-помощник. Какой у Вас вопрос?').encode(FORMAT)
        elif msg.lower() in ['quit', 'пока', "всего хорошего", "пока", "прощай", "до свидания", "до скорого", "до скорой встречи", "приятного вечера", "доброй ночи", "прощайте", "позвольте откланяться", "позвольте попрощаться", "до встречи", "бай", "бывай", "всего"]:                                                                   # Если нейросеть нашла соответствие с высокой вероятностью, то берем ее ответ
            msg = ('Рад был помочь! Обращайтесь ещё.').encode(FORMAT)
            clientsocket.sendto(msg, addr)
            clientsocket.shutdown(socket.SHUT_RDWR)
            clientsocket.close()
            connected_to_bot = False
            break
        else:
            ints = predict_class(msg)
            if float(ints[0]['probability']) > 0.9:
                res = get_response(ints, intents)
                msg = res.encode(FORMAT)
            else:
                сount_err += 1
                msg = ('Я Вас не понял, попробуйте сформулировать вопрос точнее').encode(FORMAT)
        if сount_err >= counter_before_transfer_to_support:
            msg = ('Соединяю Вас с оператором').encode(FORMAT)
            connected_to_bot = False      
        clientsocket.sendto(msg, addr)
    
    
    connected_to_support = True
    while connected_to_support:
        msg = clientsocket.recv(2048)
        msg = msg.decode(FORMAT)
        print(f'Клиент {addr}: ', msg)
        msg = input('Оператор поддержки: ').encode(FORMAT)
        clientsocket.sendto(msg, addr)


def start_server():
    serversocket.listen()
    print(f'Сервер запущен: {SERVER}, {PORT}')
    print('Ожидаем подключение клиентов...')
    while True:
        clientsocket, addr = serversocket.accept()
        thread = threading.Thread(target=handle_client, args=(clientsocket, addr))
        thread.start()
        print(f'Активных подключений: {threading.activeCount() - 1}')


# Запускаем сервер
start_server()