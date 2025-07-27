import firebase_admin
from firebase_admin import credentials, firestore
import pandas as pd

# Initialize Firebase Admin SDK
cred = credentials.Certificate("pythonScripts/generalizeddpp-firebase-adminsdk-fbsvc-82c88683bf.json")  # Path to your key
firebase_admin.initialize_app(cred)
db = firestore.client()

# Load the CSV file
df = pd.read_csv("pythonScripts/data/KitchenRawDummyData.csv")

# Specify the Firestore collection
collection_name = "kitchen_raw_materials"

# Insert rows into Firestore
for index, row in df.iterrows():
    doc_id = str(row['ID'])  # Optional: use ID as doc ID
    doc_data = row.to_dict()
    db.collection(collection_name).document(doc_id).set(doc_data)


# Load the CSV file
df_alumil = pd.read_csv("pythonScripts/data/alumilDummyData.csv")

# Specify the Firestore collection
collection_name_alumil = "alumil_dummy"

# Insert rows into Firestore
for index, row in df_alumil.iterrows():
    doc_id = str(row['profile_code'])  # Optional: use ID as doc ID
    doc_data = row.to_dict()
    db.collection(collection_name_alumil).document(doc_id).set(doc_data)

print("Data uploaded successfully to Firestore!")
