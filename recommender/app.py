#Necessary Libraries
# import streamlit as st
# import streamlit.components.v1 as stc
# from flask import Flask
# import random

from flask import Flask, send_from_directory
#Load EDA
import pandas as pd
import numpy as np
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity,linear_kernel
import nltk #for stemming process
from nltk.stem.porter import PorterStemmer
from sklearn.feature_extraction.text import TfidfVectorizer


app = Flask(__name__)

# Path for our main Svelte page
@app.route("/")
def base():
    return send_from_directory('../notus-svelte-main/public', 'index.html')

# Path for all the static files (compiled JS/CSS, etc.)
@app.route("/<path:path>")
def home(path):
    return send_from_directory('../notus-svelte-main/public', path)

#Load your dataset
def load_data(data):
    df = pd.read_csv(data)
    return df

#defining the stemming function
def stem(text):
    y=[]
    ps = PorterStemmer()
    
    for i in text.split():
        y.append(ps.stem(i))
    
    return " ".join(y)


#Functions
#Vectorize + cosine similarity
def vectorize_text_to_cosine_mat(data):
    count_vect = CountVectorizer()
    cv_mat = count_vect.fit_transform(data)  #text to vectors
    #Get the cosine
    cosine_sim_mat = cosine_similarity(cv_mat)
    return cosine_sim_mat

def vectorize_text_to_cosine_mat2(data):
    cv = CountVectorizer(max_features=5000,stop_words='english')
    vectors = cv.fit_transform(data).toarray()
    #Get the cosine
    cosine_sim_mat = cosine_similarity(vectors)
    return cosine_sim_mat

# #Recommend System
# @app.route("/recommend")
# def get_recommendation(num_of_rec=5):
#     df = load_data("data/udemy_courses.csv")
#     df2 = load_data("data/student_courses.csv")
#     title = df2['Course_taken'][0]
#     cosine_sim_mat = vectorize_text_to_cosine_mat(df['course_title'])
#     #get indices of all the courses w.r.t their title
#     courses_indices = pd.Series(df.index,index=df['course_title']).drop_duplicates()
#     #Index of the course
#     idx = courses_indices[title]
#     #Look into the cosine matrix
#     sim_scores = list(enumerate(cosine_sim_mat[idx]))
#     sim_scores = sorted(sim_scores,key=lambda x:x[1],reverse=True)
#     selected_course_indices = [i[0] for i in sim_scores[1:num_of_rec]]
#     selected_course_scores = [i[0] for i in sim_scores[1:num_of_rec]]
#     result_df = df.iloc[selected_course_indices]
#     result_df['sim_score'] = selected_course_scores
#     final_rec_co = result_df[['course_title','sim_score','price','num_subscribers','url']]
#     title_list = [title,title,title,title]
#     final_rec_co['rectitle'] = title_list
#     final_rec_co_list = final_rec_co.to_dict('records')
#     return final_rec_co_list

    #Recommend System
# @app.route("/recommend")
def get_recommendation(title,num_of_rec=5):
    df = load_data("data/Coursera.csv")
    # df2 = load_data("data/student_courses.csv")
    # title = df2['Course_taken'][0]
    df = df[['Course Name','Difficulty Level','Course Description','Skills']]
    # Removing spaces between the words (Lambda funtions can be used as well)

    df['Course Name'] = df['Course Name'].str.replace(' ',',')
    df['Course Name'] = df['Course Name'].str.replace(',,',',')
    df['Course Name'] = df['Course Name'].str.replace(':','')
    df['Course Description'] = df['Course Description'].str.replace(' ',',')
    df['Course Description'] = df['Course Description'].str.replace(',,',',')
    df['Course Description'] = df['Course Description'].str.replace('_','')
    df['Course Description'] = df['Course Description'].str.replace(':','')
    df['Course Description'] = df['Course Description'].str.replace('(','')
    df['Course Description'] = df['Course Description'].str.replace(')','')

    #removing paranthesis from skills columns 
    df['Skills'] = df['Skills'].str.replace('(','')
    df['Skills'] = df['Skills'].str.replace(')','')
    df['Skills']=df['Skills'].str.replace('-',' ')
    df['Skills']=df['Skills'].str.replace('.',' ')
    df['Skills']=df['Skills'].str.replace(':',' ')
    df['Skills']=df['Skills'].str.replace(',',' ')
    #creating tags column
    df['tags'] = df['Course Name'] + ' ' + df['Difficulty Level'] + ' ' + df['Course Description'] + ' ' + df['Skills']
    new_df = df[['Course Name','Difficulty Level','tags']]
    new_df['tags'] = df['tags'].str.replace(',',' ')
    new_df['Course Name'] = df['Course Name'].str.replace(',',' ')
    new_df = new_df.rename(columns={'Course Name':'course_title'})
    #new_df.rename(columns = {'Course URL':'course_url'}, inplace = True)
    new_df = new_df.rename(columns = {'Difficulty Level':'diff_lvl'})
    new_df['tags'] = new_df['tags'].apply(lambda x : x.lower()) #lower casing the tags column

    new_df['tags'] = new_df['tags'].apply(stem) #applying stemming on the tags column
    #removing the 
    # similarity = vectorize_text_to_cosine_mat(new_df['tags'])
    tfidf = TfidfVectorizer(stop_words='english')
    new_df['tags'] = new_df['tags'].fillna('')
    tfidf_matrix = tfidf.fit_transform(new_df['tags'])
    cosine_sim = linear_kernel(tfidf_matrix, tfidf_matrix)
    indices=pd.Series(new_df.index,index=new_df['course_title'])
    idx = indices[title]
    sim_scores = list(enumerate(cosine_sim[idx]))
    sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
    sim_scores = sim_scores[1:11]
    course_indices = [i[0] for i in sim_scores[1:num_of_rec]]
    # similarity = cosine_similarity(tfidf_matrix)
    
    # sim_scores = list(enumerate(similarity[idx]))
    # sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
    # sim_scores = sim_scores[1:num_of_rec]
    # courses = [i[0] for i in sim_scores]
    # sim_scores = list(enumerate(cosine_sim_mat[course_index]))
    # sim_scores = sorted(sim_scores,key=lambda x:x[1],reverse=True)
    result_df = new_df.iloc[course_indices]
    result_df['sim_score'] = course_indices
    final_rec_co = result_df[['course_title','sim_score','diff_lvl']]
    title_list = [title,title,title,title]
    final_rec_co['rectitle'] = title_list
    final_rec_co_list = final_rec_co.to_dict('records')
    return final_rec_co_list

@app.route("/recommend")
def get_recommendations2(num_of_rec=5):
    df2 = load_data("data/student_courses.csv")
    titles = df2['Course_taken'].values.tolist()
    final_rec_list = []
    for i in range(len(titles)):
        final_rec_list += get_recommendation(titles[i],num_of_rec)
    return final_rec_list


if __name__ == "__main__":
    app.run(debug=True)






RESULT_TEMP = """
<div style="width:90%;height:100%;margin:1px;padding:5px;position:relative;border-radius:5px;border-bottom-right-radius: 60px;
box-shadow:0 0 15px 5px #ccc; background-color: #a8f0c6;
  border-left: 5px solid #6c6c6c;">
<h4>{}</h4>
<p style="color:blue;"><span style="color:black;">📈Score::</span>{}</p>
<p style="color:blue;"><span style="color:black;">🔗</span><a href="{}",target="_blank">Link</a></p>
<p style="color:blue;"><span style="color:black;">💲Price:</span>{}</p>
<p style="color:blue;"><span style="color:black;">🧑‍🎓👨🏽‍🎓 Students:</span>{}</p>
</div>
"""
#Search for Courses

# def main():
#     st.title("Course Recommendation App")
#     menu = ["Home", "Recommend", "About"]
#     choice = st.sidebar.selectbox("Menu", menu)

#     df = load_data("data/udemy_courses.csv")
#     if choice == "Home":
#         st.subheader("Home")
#         st.dataframe(df.head(10))
#     elif choice == "Recommend":
#         st.subheader("Recommend Courses")
#         cosine_sim_mat = vectorize_text_to_cosine_mat(df['course_title'])
#         search_term = st.text_input("Search")
#         num_of_rec = st.sidebar.number_input("Number",4,30,7)
#         if st.button("Recommend"):
#             if search_term is not None:
#                 try:
#                     result = get_recommendation(search_term,cosine_sim_mat,df,num_of_rec)
#                     for row in result.iterrows():
#                         rec_title = row[1][0]
#                         rec_score = row[1][1]
#                         rec_url = row[1][2]
#                         rec_price = row[1][3]
#                         rec_num_sub = row[1][4]
#                         #st.write(rec_title)
#                         stc.html(RESULT_TEMP.format(rec_title,rec_score,rec_url,rec_url,rec_num_sub),height=350)
#                 except:
#                     result = "Not Found"
#                # st.write(result)
                
#     else:
#         st.subheader("About")
#         st.text("Built with streamlit & pandas")

# if __name__ == '__main__':
#     main()

