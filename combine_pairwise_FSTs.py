import pandas as pd
import os

# Get list of the pairwise files outputted by poolfstat script
list_of_pairwise_files = os.listdir("/path/to/snppairwises")

# Get the first file, this will be used to reorder the resulting dataframe to get a similarity matrix
first_file = pd.read_csv("/path/to/snppairwises/first_sample_of_dataset.csv")
first_file.rename(columns={'Unnamed: 0': 'Samples'}, inplace=True)

# create a list of all the pairwiseFST dataframes
df_list = []
for file_name in list_of_pairwise_files:
    df1 = pd.read_csv(f"/path/to/snppairwises/{file_name}")
    df1.rename(columns={'Unnamed: 0': 'Samples'}, inplace=True)
    df_list.append(df1)

# reindex all dataframes in the df list
dfs = [df.set_index('Samples') for df in df_list]

# combine the list of dataframes into one
combined_pairwise_df = pd.concat(dfs, axis=1)

# get the order of the samples from the first file
L = first_file["Samples"].tolist()

# reindex the columns and rows using this correct order
combined_pairwise_df = combined_pairwise_df.reindex(columns=L)
combined_pairwise_df = combined_pairwise_df.reindex(L)

# output the dataframe to a file
combined_pairwise_df.to_csv("/path/to.output/dir/full_snppairwise.csv")
