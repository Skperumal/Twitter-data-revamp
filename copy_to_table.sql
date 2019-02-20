---Data from big_giant_table has been copied to each of our newly normalized table. Please run in the same order.###

insert into user_table select user_id,user_name,user_screen_name,user_location,user_utc_offset,user_time_zone,user_followers_count,user_friends_count,
user_lang,user_description,user_status_count,user_created_at from bad_giant_table
where user_id in (select distinct user_id from bad_giant_table) on conflict(user_id) do nothing;

insert into tweet_table select created_at,text,tweet_id,in_reply_to_screen_name,in_reply_to_status_id,
in_reply_to_user_id,retweet_count,tweet_source,retweet_of_tweet_id,user_id from bad_giant_table where tweet_id in 
(select distinct tweet_id from bad_giant_table);

insert into hash_table select tweet_id,hashtag1,hashtag2,hashtag3,hashtag4,hashtag5,hashtag6 from bad_giant_table where tweet_id in (select distinct tweet_id from tweet_table);