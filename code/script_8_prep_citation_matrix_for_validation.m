%% load table

clear;

T1 = readtable('../data/data.xlsx','Sheet','citation_matrix', 'VariableNamingRule', 'preserve');

%% extract info from table

T2 = T1;

primary_studies = string(T2.("STUDY ID"));

T2.("STUDY ID") = [];

num_reviews = size(T2, 2);

review_names = string(T2.Properties.VariableNames)';

data = logical(T2{:,:});

max_num_primary_studies_in_a_review = max(sum(data));

%% make new table with reviews as rows and studies listed per review

str = strings(num_reviews,max_num_primary_studies_in_a_review);


for review_counter = 1 : num_reviews

    review = review_names(review_counter);

    data_for_review = data(:,review_counter);

    primary_studies_in_review = primary_studies(data_for_review)';


    num_studies_in_review = length(primary_studies_in_review);

    str(review_counter, 1:num_studies_in_review) = primary_studies_in_review;

end

T3 = array2table(str);

T3.Properties.RowNames = review_names;

%% fix up table

oldNames = T3.Properties.VariableNames;

newNames = string(1 : max_num_primary_studies_in_a_review);

T4 = renamevars(T3,oldNames,newNames);


%% save table

writetable(T4,"../results/citation_matrix_for_validation.xlsx", 'WriteRowNames',true);
