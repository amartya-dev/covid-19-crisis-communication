import requests
from datetime import datetime


def getStateCaseCount(s):
    statekeys = {'andaman and nicobar islands': 'an',
                 'andhra pradesh': 'ap',
                 'arunachal pradesh': 'ar',
                 'assam': 'as',
                 'bihar': 'br',
                 'chandigarh': 'ch',
                 'chhattisgarh': 'ct',
                 'national capital territory of delhi': 'dl',
                 'dadra and nagar haveli': 'dn',
                 'daman and diu': 'dn',
                 'goa': 'ga',
                 'gujarat': 'gj',
                 'himachal pradesh': 'hp',
                 'haryana': 'hr',
                 'jharkhand': 'jh',
                 'jammu and kashmir': 'jk',
                 'karnataka': 'ka',
                 'kerala': 'kl',
                 'ladakh': 'la',
                 'lakshadweep': 'ld',
                 'maharashtra': 'mh',
                 'meghalaya': 'ml',
                 'manipur': 'mn',
                 'madhya pradesh': 'mp',
                 'mizoram': 'mz',
                 'nagaland': 'nl',
                 'odisha': 'or',
                 'punjab': 'pb',
                 'puducherry': 'py',
                 'rajasthan': 'rj',
                 'sikkim': 'sk',
                 'telangana': 'tg',
                 'tamil nadu': 'tn',
                 'tripura': 'tr',
                 'uttar pradesh': 'up',
                 'uttarakhand': 'ut',
                 'west bengal': 'wb'}

    state = statekeys[s]

    url = 'https://api.covid19india.org/states_daily.json'
    raw_data = requests.get(url=url).json()
    dictionary = {}
    dates = []

    for i in raw_data['states_daily']:
        if i['status'].lower() == 'confirmed':
            date = i['date']
            if date not in dictionary.keys():
                x = i
                del x['date']
                del x['tt']
                del x['status']
                datetime_object = datetime.strptime(date, '%d-%b-%y').date()
                date = datetime_object.strftime("%m/%d/%Y")
                dates.append(date)
                dictionary.update({date: x})
    newcases = {}
    for i in dictionary:
        ans = dictionary[i][state]
        newcases.update({i: int(ans)})

    total_cases = {}
    for i in range(len(dates)):
        if i == 0:
            total_cases.update({dates[i]: int(newcases[dates[i]])})
            continue
        d = dates[i]
        prev_d = dates[i-1]
        total_cases.update({d: int(total_cases[prev_d])+int(newcases[d])})

    return total_cases
