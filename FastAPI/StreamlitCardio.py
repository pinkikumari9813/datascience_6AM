import streamlit as st
import requests

API_URL = 'https://cardio-8.onrender.com/predict-cardio'

st.title('Cardiovascular Disease Prediction', text_alignment='left')
st.subheader('_Using_ :red[Logistic] _Regression_ :blue[Model]', text_alignment='left')

st.sidebar.header(
    '_Features_'
)


age = st.sidebar.slider(
    'Age',
    min_value=27,
    max_value=70,
    value=35,
    step=1
)

# radio button
gender_options = {1: 'Female', 2: 'Male'}
gender = st.sidebar.radio(
    'Gender',
    options = list(gender_options.keys()),
    format_func = lambda values : gender_options.get(values)
)

height = st.sidebar.slider(
    'Height',
    min_value=120,
    max_value=207,
    value=130,
    step=1
)

weight = st.sidebar.slider(
    'Weight',
    min_value=40,
    max_value=140,
    value=70,
    step=1    
)

ap_hi = st.sidebar.slider(
    'Systolic Pressure',
    min_value=100,
    max_value=200,
    value=120,
    step=1
)

ap_lo = st.sidebar.slider(
    'Di-Systolic Pressure',
    min_value=50,
    max_value=90,
    value=80,
    step=1
)

cholesterol_options = {1: 'Healthy', 2: 'Mild', 3:'High Cholesterol'}
cholesterol = st.sidebar.selectbox(
    'Cholesterol',
    options = list(cholesterol_options.keys()),
    format_func = lambda values : cholesterol_options.get(values)
) 

gluc_options = {1: 'Healthy', 2: 'Mild', 3:'High Glucose'}
gluc = st.sidebar.selectbox(
    'Glucose',
    options = list(gluc_options.keys()),
    format_func = lambda values : gluc_options.get(values)
) 

smoke_options = {0: 'Doesnot Smoke', 1: 'Does Smoke'}
smoke = st.sidebar.radio(
    'Smoke',
    options = list(smoke_options.keys()),
    format_func = lambda x : smoke_options.get(x)
)

# 'alco', 
alco_options = {0: 'Doesnot Drink Alcohol', 1: 'Does Drink Alcohol'}
alco = st.sidebar.radio(
    'Alcohol Consumption',
    options = list(alco_options.keys()),
    format_func = lambda x : alco_options.get(x)
)

# 'active'
active_options = {0: 'Doesnot do PA', 1: 'Does PA'}
active = st.sidebar.radio(
    'Physical Activities',
    options = list(active_options.keys()),
    format_func = lambda x : active_options.get(x)
)

# button
if st.button('Predict Cardio'):
    # Payload -> bridge to send data from application to schema
    payload = {
        'age': age,
        'gender': gender,
        'height': height,
        'weight': weight,
        'ap_hi': ap_hi,
        'ap_lo': ap_lo,
        'cholesterol': cholesterol,
        'gluc': gluc,
        'smoke': smoke,
        'alco': alco,
        'active': active
    }
    try:
        response = requests.post(API_URL,json=payload)
        
        if response.status_code == 200:
            result = response.json()
            
            if result['Prediction_Status'] == 0:
                st.write('No cardiovascular disease found!!')
                st.success('Patient is likely to be healthy.')
            else:
                st.write('Cardiovascular disease found!!')
                st.warning('Patient is likely to be unhealthy.')
        else:
            st.error(f'Status Code: {response.status_code} Error.')
    except requests.exceptions.RequestException:
        st.error('API Link Error!! Server Not Working!!')
    
    
    
    
    # input_data = pd.DataFrame([[
    #     age, gender, height, weight, ap_hi, ap_lo, cholesterol, gluc, smoke, alco, active
    # ]], columns=features)
    
    # input_scaler = scaler.transform(input_data)
    # prediction = model.predict(input_scaler)
    
    # if prediction[0] == 0:
    #     st.write('No cardiovascular disease found!!')
    #     st.success('Patient is likely to be healthy.')
    # else:
    #     st.write('Cardiovascular disease found!!')
    #     st.warning('Patient is likely to be unhealthy.')
