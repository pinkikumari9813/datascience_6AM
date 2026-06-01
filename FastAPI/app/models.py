import joblib

MODEL_PATH = 'models/model.pkl'
SCALER_PATH = 'models/scaler.pkl'

def load_model_scaler():
    model = joblib.load(MODEL_PATH)
    scaler = joblib.load(SCALER_PATH)
    return model, scaler


# import pandas as pd
# from sklearn.linear_model import LogisticRegression
# from sklearn.model_selection import train_test_split
# from sklearn.preprocessing import StandardScaler

# df = pd.read_csv('data/Cardiovascular_Disease.csv')


# # Data Cleaning
# df['age'] = round(df['age']/365, 2)
# pressure = (df['ap_hi'].between(100, 200)) & (df['ap_lo'].between(50, 90))
# df = df[pressure]
# weight_data = (df['weight'] >= 40) & (df['weight'] <= 140)
# df = df[weight_data]
# height = (df['height']>=120)
# df = df[height]

# def predict_cardio():
#     features = ['age', 'gender', 'height', 'weight', 'ap_hi', 'ap_lo', 'cholesterol', 
#             'gluc', 'smoke', 'alco', 'active']
#     target = 'cardio'
    
#     X = df[features]
#     Y = df[target]
    
#     X_train, X_test, Y_train, Y_test = train_test_split(
#         X, Y, test_size=0.2, random_state=42, stratify=Y
#     )
    
#     scaler = StandardScaler()
#     X_train_scale = scaler.fit_transform(X_train)
#     X_test_scale = scaler.transform(X_test)
    
#     model = LogisticRegression(
#         solver = 'lbfgs',
#         class_weight='balanced',
#         random_state=42
#     )
#     model.fit(X_train_scale, Y_train)
#     model.predict(X_test_scale)
    
#     joblib.dump(model, MODEL_PATH)
#     joblib.dump(scaler, SCALER_PATH)
    
#     return model, scaler
    
    