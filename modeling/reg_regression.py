# Regression in Python ----

# Linear ----

# Classification ----
import sklearn
import numpy as np
import pandas as pd
import os
from sklearn import utils
from sklearn import preprocessing

os.chdir("C:/Users/wongs/Desktop/final-project")

data = pd.read_csv("data/data.csv")

data['timestamp'] = pd.to_datetime(data['timestamp'])

breakeven_inflation = data['breakeven_inflation']
data = data.drop(columns = ['breakeven_inflation', 'timestamp'])

X = data
y = breakeven_inflation
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=1)
y_test = y_test.astype('int')
y_train = y_train.astype('int')
X_train = X_train.astype('int')
X_test = X_test.astype('int')

from sklearn.linear_model import LogisticRegression
model = LogisticRegression(solver='lbfgs',
multi_class ='multinomial')
model.fit(X_train, y_train)
from sklearn.metrics import confusion_matrix
# Test result
y_predict = model.predict(X_test)
confusion_matrix(y_test, y_predict)
from sklearn.metrics import accuracy_score
accuracy_score(y_test, y_predict)*100
