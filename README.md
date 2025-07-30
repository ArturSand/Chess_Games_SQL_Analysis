# Chess_Games_SQL_Analysis
This analysis shows what kind of data I could find regarding this chess dataset.
Data sourced from (https://[kajodataavenanalytics.io/data-playground](https://kajodata.mailingr.co/dashboard/products/prod_ORUMgGefoYHZVf?tab=resources&resource=a5e217e5-2aee-46c3-9a2e-0937057633e6)) 
The dataset contains data for 20,000+ chess games played on Lichess.

My SQL queries for player and game analysis: Key insights revealed:

1. Total number of players:
   15,635

2. Player who won the most games:
id: Taranga 72/154, where 50% of his won games were played with higher-ranked players. 

3. I determined that the most frequently first move in a won game was:
      a) by black was e4 (5,651 times)
      b) by white was e4 (6,371 times)


4. Most common openings -> The 3 most frequent openings used by Black AND White:

    a) Sicilian Defence
    b) French Defence
    c) Queen's Pawn Game
  
5.  Percentage of Games Won:
    a) by White -> 49.86%
    b) By Black -> 45.40%
    c) Games Drawn -> 4.74%


6. What percentage of games does the higher-ranked player won as White, and when playing as Black?

   a) games won by white 6,529 with ratio 32,6%
   b) games won by black 5,823 with ratio 29,0%
