# for loading/processing the images  
from keras.preprocessing.image import load_img 
from keras.preprocessing.image import img_to_array 
from keras.applications.vgg16 import preprocess_input 

# models 
from keras.applications.vgg16 import VGG16 
from keras.models import Model

# clustering and dimension reduction
from sklearn.cluster import KMeans
from sklearn.decomposition import PCA

# for everything else
import os
import numpy as np
import matplotlib.pyplot as plt
from random import randint
import requests
import pandas as pd
import pickle

# data request using alpha vantage
symbol = str(sys.argv[1])
API_KEY = ''

# setup for the functions (query) for the url, csv notation was used:
url = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY" + f"&symbol={symbol}&apikey={API_KEY}&outputsize=full&datatype=csv"
response = requests.get(url)
contents = response.text
contents_list = list(csv.reader(contents.splitlines()))

"""write different file (using f string for file name) with all stock prices following the
date, ignore the first list (elemental list) inside the 2D list contents_list"""

doc = open(f"prices.{symbol}.txt", 'w')
# for loop will be used to write (full outputsize) the date (index position [i][0])
for i in range (1, len(contents_list)):
    doc.write(f"{contents_list[i][0]} ${float(contents_list[i][4]):.2f} \n")
doc.close()
# program output (not doc.write) for the stock symbol written through command line (argv)
print(f"Wrote historical price data for {symbol} to file price.{symbol}.txt")
