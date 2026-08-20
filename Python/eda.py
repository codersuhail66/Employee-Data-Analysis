import pandas as pd

df = pd.read_csv("Dataset/employee_data.csv")

print("\n========== FIRST 5 ROWS ==========")
print(df.head())

print("\n========== LAST 5 ROWS ==========")
print(df.tail())

print("\n========== SHAPE ==========")
print(df.shape)

print("\n========== COLUMN NAMES ==========")
print(df.columns)

print("\n========== DATA TYPES ==========")
print(df.dtypes)

print("\n========== MISSING VALUES ==========")
print(df.isnull().sum())

print("\n========== SUMMARY ==========")
print(df.describe())

print("\n===== Employees by Department =====")
print(df["Department"].value_counts())

print("\n===== Gender Distribution =====")
print(df["Gender"].value_counts())

print("\n===== Attrition =====")
print(df["Attrition"].value_counts())

print("\n===== Average Salary by Department =====")
print(df.groupby("Department")["Salary"].mean().round(2))

print("\n===== Average Experience by Department =====")
print(df.groupby("Department")["Experience"].mean().round(2))