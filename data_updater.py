from bs4 import BeautifulSoup
from selenium import webdriver
import time
from selenium.webdriver.firefox.options import Options
from pymongo import MongoClient

client = MongoClient('mongodb+srv://<username>:<password>@cluster0.1g6nx.azure.mongodb.net/<dbname>?retryWrites=true&w=majority')
db = client['nasa']['launch_schedule']
options = Options()
options.headless = True
driver = webdriver.Firefox(options=options)
driver.get('https://www.nasa.gov/launchschedule/')
time.sleep(5)
soup = BeautifulSoup(driver.page_source, 'lxml')
driver.close()
tags = soup.find_all('div', {'class': 'launch-event clearfix'})
launch_schedule = []
for i in tags:
    data = {}
    data['mission'] = i.find('div', {'class': 'launch-info'}).find('div', {'class': 'title'}).find('a').text
    data['description'] = i.find('div', {'class': 'launch-info'}).find('div', {'class': 'description'}).text.split('Description:')[1].strip()
    data['date'] = i.find('div', {'class': 'launch-info'}).find('div', {'class': 'date'}).text.replace('\n', '')
    data['image'] = 'https://www.nasa.gov'+i.find('div', {'class': 'launch-image'}).find('img')['src']
    print(data)
    launch_schedule.append(data)
db.insert_many(launch_schedule)
