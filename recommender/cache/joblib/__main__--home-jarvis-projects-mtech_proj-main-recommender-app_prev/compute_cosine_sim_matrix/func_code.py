# first line: 66
@memory.cache
def compute_cosine_sim_matrix(tags):
    tfidf = TfidfVectorizer(stop_words='english')
    tfidf_matrix = tfidf.fit_transform(tags)
    cosine_sim = linear_kernel(tfidf_matrix, tfidf_matrix)
    return cosine_sim
