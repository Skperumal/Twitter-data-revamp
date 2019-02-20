
---#User_table consists of the user details along with followers,language and description
---#Here we consider user_id as primary key because there can not be redunant instances of user details
CREATE TABLE user_table (	
    user_id bigint PRIMARY KEY,
    user_name varchar(255),
    user_screen_name varchar(255),
    user_location varchar(255), 
    user_utc_offset int,
    user_time_zone varchar(255),
    user_followers_count int,
    user_friends_count int,
    user_lang varchar(10),
    user_description varchar(255),
    user_status_count varchar(255),
    user_created_at timestamp with time zone
);

---#tweet_table is one of the key tables of this project which handles the user tweets and retweets refering to the user_id
CREATE TABLE tweet_table (
    created_at timestamp with time zone,
    text varchar(255),
    tweet_id bigint PRIMARY KEY,   
    in_reply_to_screen_name  varchar(255),
    in_reply_to_status_id bigint,
    in_reply_to_user_id bigint,
    retweet_count int,
    tweet_source varchar(255),
    retweet_of_tweet_id bigint,
	user_id bigint,
	foreign key (user_id) references user_table);

---#hash_table references tweet_id and consists of hashtags used. We may or may not use a hash_number as reference for each hashtags. 
---#Here i have not opted for hash_number	
CREATE TABLE hash_table (
	tweet_id bigint references tweet_table(tweet_id),
    hashtag1 varchar(144),
    hashtag2 varchar(144),
    hashtag3 varchar(144),
    hashtag4 varchar(144),
    hashtag5 varchar(144),
    hashtag6 varchar(144));

