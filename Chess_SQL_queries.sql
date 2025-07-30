-- all data_set
select * 
from chess_games


-- Total number of games. I confirmed using DISTINCT that game_id values are unique, ensuring COUNT(game_id) is accurate. For efficiency, DISTINCT was omitted in the final query.
select
	COUNT(game_id)			as Total_games
	,COUNT(distinct game_id)	as Unique_Total_games
from chess_games;


-- Total number of games
select
	COUNT(game_id)			as Total_games
from chess_games;


-- Total number of players

select count(distinct id)		as Total_nr_of_players
from 
	(
    select white_id as id
    from chess_games
    UNION ALL 
    select black_id as id
    from chess_games
    ) all_players;


--  Which player won the most games?

select	
	id			as winner
	,count(id)		as games_won
from 
	(
  	select 
    		white_id	as id
  	from chess_games
  	where winner = "White"
  	UNION ALL
  	select 
    		black_id	as id
  	from chess_games
  	where winner = "Black"
  	) temp
group by 1
order by games_won desc
limit 1;


-- What percentage of Taranga's won games were played with a higher ranking?

-- create view vw_higher_rank_win_perc as 
	select 	temp.*
		,case 
			when white_rating > black_rating and white_id ='taranga' then '1'
			when black_rating > white_rating and black_id ='taranga' then '1'
		else '0'
		end as Winner_with_higher_rank
from
(
select
	winner
	,white_id
	,white_rating
	,black_id
	,black_rating
from chess_games
where (winner = 'black' and black_id ='taranga') or (winner = 'white' and white_id = 'taranga')
order by 2 desc, 3 asc
) temp;


select SUM(Winner_with_higher_rank) as nr_of_wins_with_highrank
from vw_higher_rank_win_perc;

-- Number of wins with the higher-ranked players for the player 'Taranga'
Select
    round((36 * 100.0 / 72),2)	as Tarangas_win_rate;

		

-- Which first move was most frequently used in games won by Black? And in the case of White's victories?

select 
	winner
	,substring(moves,1,2)		as first_move
	,count(substring(moves,1,2))	as most_frequent_first_move
from chess_games
group by 1, 2
order by 3 desc
limit 2; 


-- Most common openings -> The 3 most frequent openings used by Black AND White:

select
	opening_shortname
	,COUNT(opening_shortname)		as frequency
from chess_games
group by 1
order by 2 desc
limit 3;

  
-- What percentage of games do White and Black win? How many of them end in a draw? 
select 
	winner
	,COUNT(distinct game_id)									as total_games_per_winner
	,(select COUNT(game_id ) as total_games from chess_games)					as total_games
	,ROUND((COUNT(game_id)/(select COUNT(game_id ) as total_games from chess_games))*100,2)		as winning_ratio_percent	
	from chess_games
group by 1
order by 2 desc;

-- What percentage of games does the higher-ranked player win as White, and when playing as Black?
-- I have first created a table to have an overview of the higher_rank_winners

 -- create table higher_rank_winner as
select 	t.*
		,case 
			when white_rating > black_rating then 'White_rank_higher'
			when black_rating > white_rating then 'Black_rank_higher'
			else 'Equal rank'
		end as Winner_with_higher_rank
from
(
select
	game_id
	,winner
	,white_rating
	,black_rating
from chess_games
) t


select*
from higher_rank_winner;

-- then calculated the number of games won by higher-ranked players for white and black.

select 
	winner
	,(select COUNT(game_id) from higher_rank_winner)							as total_games
	,COUNT(game_id) 											as games_won_by_white_higher_rank
	,ROUND((COUNT(game_id)/(select COUNT(game_id) as total_games from higher_rank_winner))*100,1)		as white_winning_ratio_percent
from higher_rank_winner
where Winner_with_higher_rank = 'White_rank_higher' and winner = 'white'
group by 1;


select 
	winner
	,(select COUNT(game_id) from higher_rank_winner)							as total_games
	,COUNT(game_id)												as games_won_by_black_higher_rank
	,ROUND((COUNT(game_id)/(select COUNT(game_id) as total_games from higher_rank_winner))*100,1)		as black_winning_ratio_percent
from higher_rank_winner
where Winner_with_higher_rank = 'Black_rank_higher' and winner = 'Black'
group by 1;

