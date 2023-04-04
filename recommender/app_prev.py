#Necessary Libraries
# import streamlit as st
# import streamlit.components.v1 as stc
# from flask import Flask
# import random

from flask import *
#Load EDA
import pandas as pd
import numpy as np
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity,linear_kernel
import nltk #for stemming process
from nltk.stem.porter import PorterStemmer
from sklearn.feature_extraction.text import TfidfVectorizer
import codecs, json
import re
from sklearn.metrics.pairwise import linear_kernel
from joblib import Memory
from timeit import default_timer as timer


app = Flask(__name__)

# Path for our main Svelte page
@app.route("/")
def base():
    return send_from_directory('../notus-svelte-main/public', 'index.html')

# Path for all the static files (compiled JS/CSS, etc.)
@app.route("/<path:path>")
def home(path):
    return send_from_directory('../notus-svelte-main/public', path)

# Route for handling 404 errors
@app.errorhandler(404)
def not_found(e):
    return send_from_directory('../notus-svelte-main/public', 'index.html')


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


# set up caching directory
cachedir = './cache'
memory = Memory(cachedir, verbose=0)

@memory.cache
def load_data_cached(filename):
    df = pd.read_csv(filename)
    return df

@memory.cache
def compute_cosine_sim_matrix(tags):
    tfidf = TfidfVectorizer(stop_words='english')
    tfidf_matrix = tfidf.fit_transform(tags)
    cosine_sim = linear_kernel(tfidf_matrix, tfidf_matrix)
    return cosine_sim
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

# #preprocessing data
# df = load_data_cached("data/Coursera.csv")
# df = df[['Course Name','Difficulty Level','Course Description','Skills']]
# df['Course Name'] = df['Course Name'].apply(lambda x: re.sub('[^0-9a-zA-Z]+', ' ', x))
# df['Course Description'] = df['Course Description'].apply(lambda x: re.sub('[^0-9a-zA-Z]+', ' ', x))
# df['Skills'] = df['Skills'].apply(lambda x: re.sub('[^0-9a-zA-Z]+', ' ', x))
# df['tags'] = df['Course Name'] + ' ' + df['Difficulty Level'] + ' ' + df['Course Description'] + ' ' + df['Skills']
# new_df = df[['Course Name','Difficulty Level','tags']]
# new_df = new_df.rename(columns={'Course Name':'course_title'})
# new_df = new_df.rename(columns = {'Difficulty Level':'diff_lvl'})
# new_df['tags'] = new_df['tags'].apply(lambda x : x.lower())
# new_df['tags'] = new_df['tags'].apply(stem)
# new_df['tags'] = new_df['tags'].fillna('')

# # compute the indices of all titles and store them in a dictionary
# indices_dict = {}
# for i, title in enumerate(new_df['course_title']):
#     indices_dict[title] = i

users = load_data_cached("data/Users.csv")
books = load_data_cached("data/Books.csv")
ratings = load_data_cached("data/Ratings.csv")
    #Recommend System
# @app.route("/recommend")
def get_recommendation(title,num_of_rec=5):
    # find the index of the title using the dictionary
    # try:
    #     idx = indices_dict[title]
    # except KeyError:
    #     print("Title not found")
    #     return []
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

    similarity = vectorize_text_to_cosine_mat(new_df['tags'])
    tfidf = TfidfVectorizer(stop_words='english')
    # new_df['tags'] = new_df['tags'].fillna('')
    tfidf_matrix = tfidf.fit_transform(new_df['tags'])
    cosine_sim = compute_cosine_sim_matrix(new_df['tags'])
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
    start = timer()
    df2 = load_data("data/student_courses.csv")
    titles = df2['Course_taken'].values.tolist()
    final_rec_list = []
    for i in range(len(titles)):
        final_rec_list += get_recommendation(titles[i],num_of_rec)
    end = timer()
    print("Time taken:", end - start, "seconds.")
    return final_rec_list

# Preprocess the data
def preprocess_data():
    # For the popularity based recommender system
    ratings_with_name = ratings.merge(books,on='ISBN')
    num_rating_df = ratings_with_name.groupby('Book-Title').count()['Book-Rating'].reset_index()
    num_rating_df.rename(columns={'Book-Rating': 'num_ratings'},inplace=True)
    avg_rating_df = ratings_with_name.groupby('Book-Title').mean()['Book-Rating'].reset_index()
    avg_rating_df.rename(columns={'Book-Rating': 'avg_ratings'},inplace=True)
    popular_df = num_rating_df.merge(avg_rating_df)
    # Top 50 books from the platform is stored in this dataframe 
    popular_df = popular_df[popular_df['num_ratings']>=250].sort_values('avg_ratings',ascending=False).head(50)
    # Since we want all the information on the other fields of these 50 books
    popular_df = popular_df.merge(books,on='Book-Title').drop_duplicates('Book-Title')[['Book-Title','Book-Author','Image-URL-M','num_ratings','avg_ratings']]

    # For the Collabrative Filtering based Recommender System
    x = ratings_with_name.groupby('User-ID').count()['Book-Rating']>200 #Filtering out those users who has rated more than 200 books
    user_idxes = x[x].index
    filtered_rating = ratings_with_name[ratings_with_name['User-ID'].isin(user_idxes)]
    y = filtered_rating.groupby('Book-Title').count()['Book-Rating']>=50
    famous_books = y[y].index
    final_ratings = filtered_rating[filtered_rating['Book-Title'].isin(famous_books)]
    user_book_table = final_ratings.pivot_table(index='Book-Title',columns='User-ID',values='Book-Rating')
    user_book_table.fillna(0,inplace=True)
    similarity_scores = cosine_similarity(user_book_table)
    
    return popular_df, user_book_table, similarity_scores

popular_df, user_book_table, similarity_scores = preprocess_data()

@app.route("/trendingbooks")
def get_trendingbooks(num_of_rec=5):
    #For the popularity based recommender system
    ratings_with_name = ratings.merge(books,on='ISBN')
    popular_df = (ratings_with_name.groupby('Book-Title')
                  .agg(num_ratings=('Book-Rating', 'count'),
                       avg_ratings=('Book-Rating', 'mean'))
                  .reset_index())
    #Top 50 books from the platform is stored in this dataframe 
    popular_df = popular_df[popular_df['num_ratings']>=250].sort_values('avg_ratings',ascending=False).head(50)
    #Since we want all the information on the other fields of these 50 books
    popular_df = popular_df.merge(books,on='Book-Title').drop_duplicates('Book-Title')[['Book-Title','Book-Author','Image-URL-M','num_ratings','avg_ratings']]
    popular_df.rename(columns={'Book-Title': 'book_title', 'Book-Author': 'book_author', 'Image-URL-M': 'image_url'}, inplace=True)
    final_rec_co_list = popular_df.to_dict('records')
    return final_rec_co_list
    # #For the popularity based recommender system
    # ratings_with_name = ratings.merge(books,on='ISBN')
    # num_rating_df = ratings_with_name.groupby('Book-Title').count()['Book-Rating'].reset_index()
    # num_rating_df.rename(columns={'Book-Rating': 'num_ratings'},inplace=True)
    # avg_rating_df = ratings_with_name.groupby('Book-Title').mean()['Book-Rating'].reset_index()
    # avg_rating_df.rename(columns={'Book-Rating': 'avg_ratings'},inplace=True)
    # popular_df = num_rating_df.merge(avg_rating_df)
    # #Top 50 books from the platform is stored in this dataframe 
    # popular_df = popular_df[popular_df['num_ratings']>=250].sort_values('avg_ratings',ascending=False).head(50)
    # #Since we want all the information on the other fields of these 50 books
    # popular_df = popular_df.merge(books,on='Book-Title').drop_duplicates('Book-Title')[['Book-Title','Book-Author','Image-URL-M','num_ratings','avg_ratings']]
    # popular_df.rename(columns={'Book-Title': 'book_title'},inplace=True)
    # popular_df.rename(columns={'Book-Author': 'book_author'},inplace=True)
    # popular_df.rename(columns={'Image-URL-M': 'image_url'},inplace=True)
    # final_rec_co_list = popular_df.to_dict('records')
    # return final_rec_co_list

@app.route('/passing/<title>', methods=['GET','POST'])
def get_book_recommendation(title):
    if request.method == 'GET': # POST request

        # Get the request data
        # data = request.json
        # title = data.get('title')
        #num_of_rec = data.get('num_of_rec', 5)
        num_of_rec = 5

        # Find the index of the given book name by the user
        try:
            index = user_book_table.index.get_loc(title)
        except KeyError:
            return jsonify(error='Book not found'), 404

        # Calculate the similarity scores
        similar_books = np.argsort(similarity_scores[index])[::-1][1:num_of_rec+1]

        # Get the recommended books
        attributes = ('book_title', 'book_author', 'image_url')
        final_rec_co = []
        for i in similar_books:
            item = dict.fromkeys(attributes)
            temp_df = books[books['Book-Title'] == user_book_table.index[i]]
            item['book_title'] = list(temp_df.drop_duplicates('Book-Title')['Book-Title'].values)
            item['book_author'] = list(temp_df.drop_duplicates('Book-Title')['Book-Author'].values)
            item['image_url'] = list(temp_df.drop_duplicates('Book-Title')['Image-URL-M'].values)
            final_rec_co.append(item)

        return final_rec_co

# @app.route('/passing/<title>', methods=['GET', 'POST'])
# def get_bookrecommendation(title):
#     if request.method == 'GET': # POST request
#     #     print(request.get_text())  # parse as text
#     #     return 'OK', 200
#     # else: # GET request
#         num_of_rec = 5
#         print("Without json loads")
#         print(title)
#         #title = json.loads(title)
#         print("With json loads")
#         print(title)
#         #For the popularity based recommender system
#         ratings_with_name = ratings.merge(books,on='ISBN')
#         num_rating_df = ratings_with_name.groupby('Book-Title').count()['Book-Rating'].reset_index()
#         num_rating_df.rename(columns={'Book-Rating': 'num_ratings'},inplace=True)
#         avg_rating_df = ratings_with_name.groupby('Book-Title').mean()['Book-Rating'].reset_index()
#         avg_rating_df.rename(columns={'Book-Rating': 'avg_ratings'},inplace=True)
#         popular_df = num_rating_df.merge(avg_rating_df)
#         #Top 50 books from the platform is stored in this dataframe 
#         popular_df = popular_df[popular_df['num_ratings']>=250].sort_values('avg_ratings',ascending=False).head(50)
#         #Since we want all the information on the other fields of these 50 books
#         popular_df = popular_df.merge(books,on='Book-Title').drop_duplicates('Book-Title')[['Book-Title','Book-Author','Image-URL-M','num_ratings','avg_ratings']]

#         #For the Collabrative Filtering based Recommender System
#         x = ratings_with_name.groupby('User-ID').count()['Book-Rating']>200 #Filtering out those users who has rated more than 200 books
#         user_idxes = x[x].index
#         print("user indexes")
#         print(user_idxes)
#         filtered_rating = ratings_with_name[ratings_with_name['User-ID'].isin(user_idxes)]
#         y = filtered_rating.groupby('Book-Title').count()['Book-Rating']>=50
#         famous_books = y[y].index
#         print("famous books")
#         print(famous_books)
#         final_ratings = filtered_rating[filtered_rating['Book-Title'].isin(famous_books)]
#         user_book_table = final_ratings.pivot_table(index='Book-Title',columns='User-ID',values='Book-Rating')
#         print("usr book table")
#         print(user_book_table)
#         user_book_table.fillna(0,inplace=True)
#         print("After filling 0's inplace of NAN")
#         print(user_book_table)
#         similarity_scores = cosine_similarity(user_book_table)
#         print("similarity scores")
#         print(similarity_scores)
#         print("index of 4 Blondes")
#         print(np.where(user_book_table.index == '4 Blondes')[0][0])
#             #Now find the index of the given book name by the user
#         index = np.where(user_book_table.index == title)[0][0]
#         print(index)
#         similar_books = sorted(list(enumerate(similarity_scores[index])),key=lambda x:x[1],reverse=True)[1:num_of_rec]
#         final_rec_co = []
#         attributes = ('book_title','book_author', 'image_url')

#         for i in similar_books:
#             item = dict.fromkeys(attributes)
#             temp_df = books[books['Book-Title'] == user_book_table.index[i[0]]]
#             item['book_title'] = list(temp_df.drop_duplicates('Book-Title')['Book-Title'].values)
#             item['book_author'] = list(temp_df.drop_duplicates('Book-Title')['Book-Author'].values)
#             item['image_url'] = list(temp_df.drop_duplicates('Book-Title')['Image-URL-M'].values)
#             final_rec_co.append(item)
#             # temp_df = [books[books['Book-Title'] == user_book_table.index[i[0]]] for i in similar_books[1:num_of_rec]]
#             # final_rec_co = temp_df[['Book-Title','Book-Author','Image-URL-M']]
#             # final_rec_co.rename(columns={'Book-Title': 'book_title'},inplace=True)
#             # final_rec_co.rename(columns={'Book-Author': 'book_author'},inplace=True)
#             # final_rec_co.rename(columns={'Image-URL-M': 'image_url'},inplace=True)
#         #final_rec_co_list = final_rec_co.to_dict('records')
#         print("final_rec_co")
#         print(final_rec_co)
#         #final_rec_co_list = final_rec_co.tolist()
#         return final_rec_co







    


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
