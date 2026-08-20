import pandas as pd
import numpy as np
from faker import Faker
import random

fake = Faker("en_IN")

random.seed(42)
np.random.seed(42)

departments = ["IT", "HR", "Sales", "Finance", "Marketing"]
designations = ["Analyst", "Senior Analyst", "Team Lead", "Manager"]
locations = ["Bangalore", "Hyderabad", "Pune", "Chennai", "Mumbai"]
education = ["BCA", "B.Tech", "MCA", "MBA", "M.Tech"]

rows = []

for i in range(1, 10001):

    dept = random.choice(departments)

    exp = random.randint(0, 20)

    if dept == "IT":
        salary = random.randint(50000, 150000)
    elif dept == "Finance":
        salary = random.randint(45000, 120000)
    elif dept == "Sales":
        salary = random.randint(30000, 100000)
    elif dept == "Marketing":
        salary = random.randint(35000, 90000)
    else:
        salary = random.randint(30000, 80000)

    if dept == "Sales":
        attrition = random.choices(["Yes", "No"], weights=[20,80])[0]
    else:
        attrition = random.choices(["Yes", "No"], weights=[10,90])[0]

    rows.append({
        "Employee_ID": f"EMP{i:05}",
        "Name": fake.name(),
        "Gender": random.choice(["Male","Female"]),
        "Age": random.randint(22,60),
        "Department": dept,
        "Designation": random.choice(designations),
        "Education": random.choice(education),
        "Experience": exp,
        "Salary": salary,
        "Joining_Date": fake.date_between(start_date="-10y", end_date="today"),
        "Location": random.choice(locations),
        "Performance_Rating": random.randint(1,5),
        "Overtime": random.choice(["Yes","No"]),
        "Attrition": attrition
    })

df = pd.DataFrame(rows)

from pathlib import Path

output_dir = Path(__file__).parent.parent / "Dataset"
output_dir.mkdir(exist_ok=True)

output_file = output_dir / "employee_data.csv"

df.to_csv(output_file, index=False)

print("Dataset Created Successfully!")
print(df.head())