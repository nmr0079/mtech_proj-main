# first line: 61
@memory.cache
def load_data_cached(filename):
    df = pd.read_csv(filename)
    return df
