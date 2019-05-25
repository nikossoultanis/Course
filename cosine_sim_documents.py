import re
import io
import sys
from sklearn.feature_extraction.text import CountVectorizer
from nltk.tokenize import word_tokenize
import numpy as np
mylist = list()
scoreboard = list()
data = list()

class Score():          #object that has all the results for each comparison.
        def __init__(self,score,filename1,filename2):
                self.score = score
                self.file1 = filename1
                self.file2 = filename2

def readFile():         #reading file function.
    counter = 1
    for item in sys.argv:
        with io.open(sys.argv[counter], 'rU',)  as file:
                content = data.append(file.read().replace('\n', ''))
        counter = counter + 1
        if counter >= len(sys.argv):
            break;
    return content

def vectoryzen():       #creating vectors from files.
        readFile()
        vectorizer = CountVectorizer()
        vector = vectorizer.fit_transform(data)
        vector = vector.todense()
        return vector

def cos_sim(a, b):     #implementing cosine_similarity function.
        vec1 = np.squeeze(np.asarray(a))
        vec2 = np.squeeze(np.asarray(b))        
        dot_product = np.dot(vec1,vec2)
        norm_a = np.linalg.norm(a)
	norm_b = np.linalg.norm(b)
	return dot_product / (norm_a * norm_b)

def comparison():      #use the cosine similarity for all the entries.
        final_vector = vectoryzen()
        filesNum = len(sys.argv) #elements of argv.
        for x in range(0,filesNum-1): #looping over those elements.
                for y in range(x, filesNum):
                        if x==y:
                                continue;
                        if y>=filesNum-1:
                                break;     
                        mylist.append(Score(cos_sim(final_vector[x],final_vector[y])*100, sys.argv[x+1], sys.argv[y+1])) #adding the results to the list of objects.
        return mylist

def top_k_scoreboard():         # function to print the top-k most similar documents.
        items = int(raw_input("How many files do you want to show as the most similar?   "))
        if items == 0:
                print("With zero nothing will be printed.")
        elif items == 1:
                print("The top score is shown.")
        mylist = comparison()
        mylist.sort(key = lambda x: x.score, reverse = True)            #sorting the list, to have top score at the beginning
        for counter in range(0,items):
                print(mylist[counter].score, mylist[counter].file1, mylist[counter].file2 ) 
        if items == 1:
                print("The result has been printed.")
        else:
                print("All the results have been printed.")

top_k_scoreboard()