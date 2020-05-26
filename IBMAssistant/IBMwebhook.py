

import sys
import requests
import json
import math
import urllib3

def getRiskParams(params):
    
    gender=params['gender']
    if gender=='patient_male':
        gender='male'
    elif gender=='patient_female':
        gender='female'
    else:
        gender='other'
    ######################
    age=int(params['age'])
    if 1<=age<10:
        age='1_10'
    elif 10<=age<20:
        age='10_20'
    elif 20<=age<30:
        age='20_30'
    elif 30<=age<40:
        age='30_40'
    elif 40<=age<50:
        age='40_50'
    elif 50<=age<60:
        age='50_60'
    elif 60<=age<70:
        age='60_70'
    elif 70<=age<80:
        age='70_80'
    elif 80<=age<90:
        age='80_90'
    elif 90<=age<100:
        age='90_100'
    else:
        age='100_110'
    #########################
    smoker=params['smoker']
    if smoker=='patientsmoker_yeslight':
        smoker='yeslight'
    elif smoker=='patientsmoker_yes':
        smoker='yesheavy'
    elif smoker=='patientsmoker_usedto':
        smoker='quit5'
    else:
        smoker='never'
    #######################
    housecount=int(params['housecount'])
    #######################
    hcw=params['hcw']
    if hcw=='hcw_no':
        hcw=0
    else:
        hcw=1
    ######################
    nh=params['nh']
    if nh=="liveinnh_no":
        nh=0
    else:
        nh=1
    #####################
    singleeffort=params['singleeffort']
    if singleeffort=="singleeffort_yes":
        singleeffort=1
    elif singleeffort=="singleeffort_maybe":
        singleeffort=0
    else:
        singleeffort=-1
    #####################
    socialdist=params['socialdist']
    if socialdist=="psd_yes":
        socialdist=1
    elif socialdist=="psd_maybe":
        socialdist=0
    else:
        socialdist=-1
    ######################
    handwash=params['handwash']
    if handwash=="handwash_yes":
        handwash=1
    elif handwash=="handwash_maybe":
        handwash=0
    else:
        handwash=-1
    #######################
    fam_socialdist=params['fam_socialdist']
    if fam_socialdist=="pfamsd_yes":
        fam_socialdist=1
    elif fam_socialdist=="pfamsd_maybe":
        fam_socialdist=0
    else:
        fam_socialdist=-1
    ########################
    diabetic=params['diabetic']
    if diabetic=='diabetic_no':
        diabetic=0
    else:
        diabetic=1
    ###########################
    lungdis=params['lungdis']
    if lungdis=='pld_no':
        lungdis=0
    else:
        lungdis=1
    ############################
    heartdis=params['heartdis']
    if heartdis=='phdis_no':
        heartdis=0
    else:
        heartdis=1
    #######################
    hyper=params['hyper']
    if hyper=="hyper_no":
        hyper=0
    else:
        hyper=1
    ######################
    other=params['other']
    if other=="patientotherdis_no":
        other=0
    else:
        other=1
    ######################
    symptoms=params['symptoms']
    if symptoms=="pse_no":
        symptoms=0
    else:
        symptoms=1
    ###########################
    contact=params['contact']
    if contact=="pc_no":
        contact=0
    else:
        contact=1
    ##############################
    travel=params['travel']
    if travel=="travel_no":
        travel=0
    else:
        contact=1
    #############################
    #["Unnamed: 0", "sex", "age", "house_count", "rate_reducing_risk_single",
        #"rate_reducing_risk_single_social_distancing", "rate_reducing_risk_single_washing_hands", "rate_reducing_risk_house",
        #"rate_reducing_risk_house_social_distancing", "rate_reducing_risk_house_washing_hands", "smoking", "covid19_symptoms", "covid19_contact",
       # "heart_disease", "lung_disease", "diabetes", "hiv_positive", "hypertension", "other_chronic", "nursing_home", "health_worker"]
    
    finalArray=[0,gender,age,housecount,singleeffort,socialdist,handwash,0,fam_socialdist,0,smoker,symptoms,contact,heartdis,lungdis,diabetic,0,hyper,other,nh,hcw]
    return finalArray
    
    
def getzone(params):
    location= params['location']
        
    try:
        state=params['state']
        if len(state.strip())>0:
            statepresent=True
        else:
            statepresent=False
    except:
        statepresent=False
        
    
    url = 'https://api.covid19india.org/zones.json'
    raw_data = requests.get(url=url).json()
    data = raw_data['zones']
    
    
    if statepresent:
        for i in data:
            if i['state'].lower()==state.lower():
                if i['district'].lower()==location.lower():
                    return {"zone":i['zone']}
    else:
        
        for i in data:
            if i['district'].lower()==location.lower():
                #return{"zone":location}
                return {"zone":i['zone'], "where":location}

def get_params(params):
    
    gender=params['gender']
    if gender=='patient_male':
        gender=0
    else:
        gender=1
    age=int(params['age'])
    
    intubation=params['intubation']
    if intubation=='patientintubated_no':
        intubation=0
    else:
        intubation=1
        
    icu=params['icu']
    if icu=='patient_icu_yes':
        icu=1
    else:
        icu=0
    pneumonia=params['pneumonia']
    if pneumonia=='patientpneumonia_no':
        pneumonia=0
    else:
        pneumonia=1
    
    diabetic=params['diabetic']
    if diabetic=='diabetic_no':
        diabetic=0
    else:
        diabetic=1
        
    copd=params['copd']
    if copd=='copd_no':
        copd=0
    else:
        copd=1
        
    hyper=params['hyper']
    if hyper=="hyper_no":
        hyper=0
    else:
        hyper=1
        
        
    other=params['other']
    if other=='patientotherdis_yes':
        age+=1
    other=0
    
    smoker=params['smoker']
    if smoker=='patientsmoker_yes':
        age+=3
    smoker=0
    #["sex", "intubated", "pneumonia", "age", "diabetes", "copd", "hypertension", "other_diseases", "smoker", "icu"]
    finalArray=[gender,intubation,pneumonia,age,diabetic,copd,hyper,other,smoker,icu]
    
    return finalArray
        
        
        
        
        
        
    

def state_count(state,raw_data):
    deaths=0
    active=0
    confirmed=0
    recovered=0
    for i in raw_data:
        states= raw_data[i]['districtData']

        if i.lower()==state.lower():
            for district in states:
                #print(district)
                deaths+=states[district]['deceased']
                active+=states[district]['active']
                confirmed+=states[district]['confirmed']
                recovered+=states[district]['recovered']
    case_dict={'deaths':deaths,'recovered':recovered,'active':active,'confirmed':confirmed}
        
    return case_dict


def district_count(district_s,raw_data):
    deaths=0
    active=0
    confirmed=0
    recovered=0
    
    for i in raw_data:
        states=raw_data[i]['districtData']
        for district in states:
            if district_s.lower()==district.lower():
                deaths+=states[district]['deceased']
                active+=states[district]['active']
                confirmed+=states[district]['confirmed']
                recovered+=states[district]['recovered']
                #print('yes',district)
    case_dict={'deaths':deaths,'recovered':recovered,'active':active,'confirmed':confirmed}
    return case_dict
    
    
    
def india_count(raw_data):
    
    #print('hey')
    deaths=0
    active=0
    confirmed=0
    recovered=0
    for i in raw_data:
        states= raw_data[i]['districtData']

      
        for district in states:
            #print(district)
            deaths+=states[district]['deceased']
            active+=states[district]['active']
            confirmed+=states[district]['confirmed']
            recovered+=states[district]['recovered']
    case_dict={'deaths':deaths,'recovered':recovered,'active':active,'confirmed':confirmed}
        
    return case_dict
    
    
    
def check_if_state(s):
    #print('2')
    states=['Andaman and Nicobar Islands','Andhra Pradesh','Arunachal Pradesh',
    'Assam','Bihar','Chandigarh','Chhattisgarh','Delhi','Dadra and Nagar Haveli and Daman and Diu','Goa',
    'Gujarat','Himachal Pradesh','Haryana','Jharkhand','Jammu and Kashmir','Karnataka','Kerala',
    'Ladakh','Lakshadweep','Maharashtra','Meghalaya','Manipur','Madhya Pradesh','Mizoram','Nagaland',
    'Odisha','Punjab','Puducherry','Rajasthan','Sikkim','Telangana','Tamil Nadu','Tripura','Uttar Pradesh','Uttarakhand','West Bengal']
    
    for i in states:
        if s.lower() in i.lower():
            return True


def main(params):
    if params['type'] == "api":
        url = 'https://api.covid19india.org/state_district_wise.json'
        raw_data = requests.get(url=url).json()

        try:
            
            where=params['where']
            what=params['searchvalue']
            if where.lower()=='india':
                case_dict=india_count(raw_data)
            elif check_if_state(where):
                case_dict=state_count(where,raw_data)
            else:
                case_dict=district_count(where,raw_data)
        except Exception as e:
            {'result':e}

        
        Text=""""""
        return {'result':case_dict,'searchval':what,'ans':case_dict[what]}
        
    elif params['type'] == 'discovery':
        
        url = 'https://eu-gb.functions.cloud.ibm.com/api/v1/web/saishrawan.malyala2017%40vitstudent.ac.in_dev/default/discoverycall.json'
        #raw_data = requests.get(url=url).json()
        #return raw_data
        
        header = {'Content-Type': 'application/json'}
        vals={"inputtext":params['inputtext']}
         
        response = requests.post(url, headers=header,json=vals).json()
        return response
        
    elif params['type'] == 'zone':
        
        
        
        location= params['location']
        
        try:
            state=params['state']
            if len(state.strip())>0:
                statepresent=True
            else:
                statepresent=False
        except:
            statepresent=False
            
        
        url = 'https://api.covid19india.org/zones.json'
        raw_data = requests.get(url=url).json()
        data = raw_data['zones']
        
        
        if statepresent:
            for i in data:
                if i['state'].lower()==state.lower():
                    if i['district'].lower()==location.lower():
                        return {"zone":i['zone']}
        else:
            
            for i in data:
                if i['district'].lower()==location.lower():
                    #return{"zone":location}
                    return {"zone":i['zone'], "where":location}
                    
                    
                    
                    
    elif params['type'] == 'essentials':
        
        
        location=params['location']
        category=params['category']
        url = 'https://api.covid19india.org/resources/resources.json'
        raw_data = requests.get(url=url).json()
        data = raw_data['resources']
        #return {"response":category}
        retval=''''''
        cityfound=False
        for i in data:
            #print(i)
            if location.lower()==i['city'].lower():
                cityfound=True
                #print('check1')
                
                #print()
                if category.strip().lower()==i['category'].strip().lower():
                    #print('check2')
    
    
                    retval+=' \n\n '
                    retval+='OrganizationName:'+i['nameoftheorganisation']+'\n'
                    retval+='Description:' +i['descriptionandorserviceprovided'] +'\n'
                    retval+='Phone Number: ' +i['phonenumber'] +'\n'
                    retval+='Contact: ' +i['contact'] +'\n'
                    #print(retval)
    
        if len(retval.strip())<1:
            retval='''We could not find any organizations in your location that belong to the category: '''+category

    
        if not cityfound:
            
            #return {"response": location+category}
            return {"response":"We're unable to find information for this location at the moment"}
        
        else:
            return {"response":retval}
            
    elif params['type'] =="riskprediction":
        
        vals=getRiskParams(params)
        zone=getzone(params)
        zone=zone['zone']
        #vals=[0,'male','20_30',9,1,1,1,1,1,1,'yeslight',0,0,0,0,0,0,0,0,0,0]
        apikey=params['apikey']
        ml_instance_id=params['ml_instance_id']
        
        url     = "https://iam.bluemix.net/oidc/token"
        headers = { "Content-Type" : "application/x-www-form-urlencoded" }
        data    = "apikey=" + apikey + "&grant_type=urn:ibm:params:oauth:grant-type:apikey"
        IBM_cloud_IAM_uid = "bx"
        IBM_cloud_IAM_pwd = "bx"
        response  = requests.post( url, headers=headers, data=data, auth=( IBM_cloud_IAM_uid, IBM_cloud_IAM_pwd ) )
        iam_token = response.json()["access_token"]
        
        
        header = {'Content-Type': 'application/json', 'Authorization': 'Bearer ' + iam_token, 'ML-Instance-ID': ml_instance_id}

        # NOTE: manually define and pass the array(s) of values to be scored in the next line
        payload_scoring = {"input_data": [{"fields": ["Unnamed: 0", "sex", "age", "house_count", "rate_reducing_risk_single",
        "rate_reducing_risk_single_social_distancing", "rate_reducing_risk_single_washing_hands", "rate_reducing_risk_house",
        "rate_reducing_risk_house_social_distancing", "rate_reducing_risk_house_washing_hands", "smoking", "covid19_symptoms", "covid19_contact",
        "heart_disease", "lung_disease", "diabetes", "hiv_positive", "hypertension", "other_chronic", "nursing_home", "health_worker"], "values": [vals]}]}
        
        response_scoring = requests.post('https://eu-gb.ml.cloud.ibm.com/v4/deployments/3f7636e2-1413-4308-a8c8-a8535b315644/predictions', json=payload_scoring, headers=header)
        #print("Scoring risk response")
        #print(json.loads(response_scoring.text))
        temp1=json.loads(response_scoring.text)
        temp2=temp1['predictions']
        answer=int(temp2[0]['values'][0][0])
        if answer<60:
            advice='Stay home and take care of yourself in home isolation'
        elif 60<=answer<85:
            advice='Call and consult your physician. Monitor your symptoms and get medical attention if your situation worsens'
        else:
            advice='Seek immediate medical attention and get yourself tested. Please visit a physician as there may be a requirement for further care. Further, monitor your symptoms and isolate yourself'
            
        zoneaddition='You are currently in a '+zone+' zone. So necessary caution is advised'
        return {"response" :answer,'advice':advice,'zoneaddition':zoneaddition}
        
        #return {"response" :json.loads(response_scoring.text)}
        
        
            
    elif params['type'] == 'recoveryrate':
        
        vals=get_params(params)
        #print(vals)
        
        #return {"response" :"yes success"}
        apikey=params['apikey']
        ml_instance_id=params['ml_instance_id']
        #vals=[0,0,0,24,0,0,0,0,0,0]
        
        url     = "https://iam.bluemix.net/oidc/token"
        headers = { "Content-Type" : "application/x-www-form-urlencoded" }
        data    = "apikey=" + apikey + "&grant_type=urn:ibm:params:oauth:grant-type:apikey"
        IBM_cloud_IAM_uid = "bx"
        IBM_cloud_IAM_pwd = "bx"
        response  = requests.post( url, headers=headers, data=data, auth=( IBM_cloud_IAM_uid, IBM_cloud_IAM_pwd ) )
        iam_token = response.json()["access_token"]
        
        header = {'Content-Type': 'application/json', 'Authorization': 'Bearer ' + iam_token, 'ML-Instance-ID': ml_instance_id}

        # NOTE: manually define and pass the array(s) of values to be scored in the next line
        payload_scoring = {"input_data": [{"fields": ["sex", "intubated", "pneumonia", "age", "diabetes", "copd", "hypertension", "other_diseases", "smoker", "icu"], "values": [vals]}]}
        
        response_scoring = requests.post('https://eu-gb.ml.cloud.ibm.com/v4/deployments/4641d4d1-0037-4c01-8f9c-0ae86fec3c30/predictions', json=payload_scoring, headers=header)
        #print("Scoring response")
        #print(json.loads(response_scoring.text))
        
        temp1=json.loads(response_scoring.text)
        temp2=temp1['predictions']
        
        #print('_______'+temp2+'________')
        answer=temp2[0]['values'][0][0][0]
        
        return {"response" :math.ceil((1-answer)*100)}
        #return {"response" :temp2[0]['values'][0][0][0]}
        
    
    elif params['type']=='appointment':
        
        token=params['accesstoken']
        header = {'Content-Type': 'application/json','Authorization': 'TOKEN  ' + token}
        date=params['date']
        time=params['time']
        vals={"date":date,"time":time}
        
        response_scoring = requests.post('https://communiquer.herokuapp.com/api/checkup_request/', headers=header,json=vals)
        #print(type(response_scoring.json()))
        mes=response_scoring.json()['message']
        #print(mes)
        #mes='hi'
        
        if 'success' in mes.lower():
            mes='Your online appointment has been successfully set for '+dict(response_scoring.json())['date']+' at '+response_scoring.json()['time']
        else:
            mes='You already have an appointment set for '+response_scoring.json()['date']+' at '+response_scoring.json()['time']
           
        return {"response":mes}
        
    elif params['type']=='vendors':
        
         token=params['accesstoken']
         header = {'Authorization': 'TOKEN  ' + token}
         response_scoring = requests.post('https://communiquer.herokuapp.com/api/get_vendors/', headers=header)
         #print(response_scoring)
         vends={}
         
         i=response_scoring.json()['vendors_available'][0]
         vends.update({"FirstDN":i['displayName']})
         vends.update({"Firstusername":i['username']})
         i=response_scoring.json()['vendors_available'][1]
         vends.update({"SecondDN":i['displayName']})
         vends.update({"Secondusername":i['username']})
         
         
             
             
         #response_scorinresponse_scoring['vendors_available']
         return {"response":vends}
        
    elif params['type']=='sendorder':
        
         token=params['accesstoken']
         header = {'Authorization': 'TOKEN  ' + token}
         order=params['order']
         vendor=params['vendor']
         header = {'Content-Type': 'application/json','Authorization': 'TOKEN  ' + token}
         vals={"items":order,"vendor":vendor}
         
         response = requests.post('https://communiquer.herokuapp.com/api/delivery_request/', headers=header,json=vals)
         
         #print(response.json())
         
         return {"response":response.json()}
