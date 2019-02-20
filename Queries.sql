---Queries for questions asked on the new normalized design tables.

--A.  Tweets, users and languages:
	--1.  How many tweets are there in total?

		select count(tweet_id) as total_tweets from tweet_table;
	
	--2. How are these tweets distributed across languages? Write a query that shows, for every language (user_lang) the number of tweets in that language.

		select 	usr.user_lang, count(tweet.tweet_id) as num_of_tweets 
		from tweet_table tweet, user_table usr
		where tweet.user_id = usr.user_id
		group by usr.user_lang;

	--3. Compute, for each language, the fraction of total tweets that have that language setting, as well as the fraction of the number of users that have that language setting.

		 select each_lang.user_lang, cast(each_lang.num_of_tweets as decimal) / each_usr.totalnumoftweets 
		 as tweetsoflang, cast(each_lang.num_of_user as decimal) / each_usr.totalnumofusers as usersoflang 
		 from (select u.user_lang, 'd' as dum_var, count(tw.tweet_id) as num_of_tweets, count(distinct u.user_id) as num_of_user
		 from	tweet_table tw,	user_table u where tw.user_id = u.user_id group by u.user_lang) as each_lang, 
	     (select 'd' as dum_var, count(tw.tweet_id) as totalnumoftweets, count(distinct u.user_id) as totalnumofusers
	     from tweet_table tw, user_table u where tw.user_id = u.user_id) as each_usr
		 where each_lang.dum_var = each_usr.dum_var;


--B. Retweeting habits
	--1. What fraction of the tweets are retweets?

		select 	cast(count(retweet_of_tweet_id) as decimal)/count(tweet_id) as distinct_retweets
		from 	tweet_table;

	--2. Compute the average number of retweets per tweet.
		select avg(retweet_count) as avg_retweets from tweet_table;

	--3. What fraction of the tweets are never retweeted? 

		select 	cast(count(tweet_id) as decimal)/(select count(tweet_id) from tweet_table) as never_retweetd
		from 	tweet_table
		where  retweet_of_tweet_id is null;

	--4. What fraction of the tweets are retweeted fewer times than the average number of retweets (and what does this say about the distribution)?

		select cast(count(tweet_id) as decimal)/(select count(tweet_id) from tweet_table) as retweet_blw_avg
	    from tweet_table where retweet_count < (select avg(retweet_count) from tweet_table);


--C. Hashtags
	--1. What is the number of distinct hashtags found in these tweets?
		with hash_table_view as(
		select count(distinct hashtag1) from hash_table where hashtag1 is not null union
		select count(distinct hashtag2) from hash_table where hashtag2 is not null union
		select count(distinct hashtag3) from hash_table where hashtag3 is not null union
		select count(distinct hashtag4) from hash_table where hashtag4 is not null union
		select count(distinct hashtag5) from hash_table where hashtag5 is not null union
		select count(distinct hashtag6) from hash_table where hashtag6 is not null)
		select sum(hash_table_view.count) as counts from hash_table_view;
		
	--2. What are the top ten most popular hashtags, by number of usages?
		with hashtag_view as (
		select hashtag1 as val,count(tweet_id) as counts from hash_table group by hashtag1 union 
		select hashtag2,count(tweet_id) from hash_table group by hashtag2 union 
		select hashtag3,count(tweet_id) from hash_table group by hashtag3 union 
		select hashtag4,count(tweet_id) from hash_table group by hashtag4 union 
		select hashtag5,count(tweet_id) from hash_table group by hashtag5 union 
		select hashtag6,count(tweet_id) from hash_table group by hashtag6
		)
		select val,sum(counts) as counts from hashtag_view where val is not null group by val order by sum(counts) desc Limit 10;
	
	--3. Write a query giving, for each language, the top three most popular hashtags in that language.
		



--D. Replies
	--1. How many tweets are neither replies, nor replied to? 
	
		select count(tweet_id) from tweet_table
		where in_reply_to_status_id is null 
		and tweet_id not in (select in_reply_to_status_id from tweet_table where in_reply_to_status_id is not null);

	--2. If a user user1 replies to another user user2, what is the probability that they have the same language setting?
		

	--3. How does this compare to the probability that two arbitrary users have the same language setting?
	