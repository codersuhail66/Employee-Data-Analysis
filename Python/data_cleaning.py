from pathlib import Path
import pandas as pd

project_root = Path(__file__).parent.parent

csv_path = project_root / "Dataset" / "employee_data.csv"

df = pd.read_csv(csv_path)

print(df.head())

# Missing Names
df.loc[10, "Name"] = None
df.loc[500, "Name"] = None

# Missing Salary
df.loc[25, "Salary"] = None
df.loc[2500, "Salary"] = None

# Wrong Department Names
df.loc[50, "Department"] = "it"
df.loc[60, "Department"] = "I.T"
df.loc[70, "Department"] = "Information Technology"

# Wrong Gender Values
df.loc[100, "Gender"] = "M"
df.loc[101, "Gender"] = "male"

# Wrong Age
df.loc[200, "Age"] = 5
df.loc[201, "Age"] = 150

# Wrong Salary
df.loc[300, "Salary"] = -10000
df.loc[301, "Salary"] = 9999999

# Duplicate Rows
df = pd.concat([df, df.iloc[[20]]], ignore_index=True)


# Fill missing values
df["Name"] = df["Name"].fillna("Unknown")
df["Salary"] = df["Salary"].fillna(df["Salary"].median())

# Remove duplicates
df = df.drop_duplicates()

# Standardize Department names
df["Department"] = df["Department"].replace({
    "it": "IT",
    "I.T": "IT",
    "Information Technology": "IT"
})

# Standardize Gender values
df["Gender"] = df["Gender"].replace({
    "M": "Male",
    "male": "Male",
    "F": "Female",
    "female": "Female"
})

# Keep only valid ages
df = df[(df["Age"] >= 22) & (df["Age"] <= 60)]

# Keep only valid salaries
df = df[(df["Salary"] >= 30000) & (df["Salary"] <= 150000)]

# Fill missing values
df["Name"] = df["Name"].fillna("Unknown")
df["Salary"] = df["Salary"].fillna(df["Salary"].median())

# Remove duplicates
df = df.drop_duplicates()

# Standardize Department names
df["Department"] = df["Department"].replace({
    "it": "IT",
    "I.T": "IT",
    "Information Technology": "IT"
})

# Standardize Gender values
df["Gender"] = df["Gender"].replace({
    "M": "Male",
    "male": "Male",
    "F": "Female",
    "female": "Female"
})

# Keep only valid ages
df = df[(df["Age"] >= 22) & (df["Age"] <= 60)]

# Keep only valid salaries
df = df[(df["Salary"] >= 30000) & (df["Salary"] <= 150000)]

# Fill missing values
df["Name"] = df["Name"].fillna("Unknown")
df["Salary"] = df["Salary"].fillna(df["Salary"].median())

# Remove duplicates
df = df.drop_duplicates()

# Standardize Department names
df["Department"] = df["Department"].replace({
    "it": "IT",
    "I.T": "IT",
    "Information Technology": "IT"
})

# Standardize Gender values
df["Gender"] = df["Gender"].replace({
    "M": "Male",
    "male": "Male",
    "F": "Female",
    "female": "Female"
})

# Keep only valid ages
df = df[(df["Age"] >= 22) & (df["Age"] <= 60)]

# Keep only valid salaries
df = df[(df["Salary"] >= 30000) & (df["Salary"] <= 150000)]

print("\n========== AFTER CLEANING ==========")
print("\nMissing Values:")
print(df.isnull().sum())

print("\nDuplicate Rows:")
print(df.duplicated().sum())

print("\nDepartment Values:")
print(df["Department"].value_counts())

print("\nGender Values:")
print(df["Gender"].value_counts())

print("\nSalary Summary:")
print(df["Salary"].describe())

print("\nAge Summary:")
print(df["Age"].describe())

from pathlib import Path

clean_path = Path(__file__).parent.parent / "Dataset" / "employee_data_cleaned.csv"
df.to_csv(clean_path, index=False)

print("\n✅ Clean dataset saved as employee_data_cleaned.csv")