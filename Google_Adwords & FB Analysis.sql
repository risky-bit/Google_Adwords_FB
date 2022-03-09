
--Performance Data for Google Ads Campaigns by Date (SUM & AVG)
SELECT CONVERT(VARCHAR(30), day, 23) AS Date_D, 
       SUM(clicks) AS Total_Clicks, 
       AVG(clicks) AS AVG_Clicks, 
       SUM(cost) AS Total_COST, 
       AVG(cost) AS AVG_COST, 
       SUM(conversions) AS Total_CONVERSIONS, 
       AVG(conversions) AS AVG_CONVERSIONS, 
       SUM(convrate) Total_CONVERSION_RATE, 
       AVG(convrate) AVG_CONVERSION_RATE, 
       SUM(ctr) AS Total_CTR, 
       AVG(ctr) AS _CTR
FROM GoogleAdsCampaigns
GROUP BY GoogleAdsCampaigns.day
ORDER BY day;

--Performance Data for FB by Date (SUM & AVG)
SELECT CONVERT(VARCHAR(30), date_start, 23) AS Date_D, 
       SUM(clicks) AS Total_Clicks,
	   AVG(clicks) AS Total_Clicks, 
       SUM(spend) AS Total_SPEND, 
	   AVG(spend) AS Total_SPEND,
       SUM(conversions) AS Total_CONVERSIONS,
	   AVG(conversions) AS Total_CONVERSIONS, 
       SUM(cpc) Total_CPC,
	   AVG(cpc) Total_CPC, 
       SUM(ctr) AS Total_CTR,
	   AVG(ctr) AS Total_CTR,
	   SUM(cpm) AS Total_CPM,
	   AVG(cpm) AS Total_CPM
FROM FB_Raw
GROUP BY date_start
ORDER BY date_start;


--Performance Data for recent & previous day for Google Ads Campaign by Date
SELECT CONVERT(VARCHAR(30), day, 23) AS Date_D, 
       SUM(clicks) AS Total_Clicks, 
       LAG(SUM(clicks)) OVER(
ORDER BY day) AS Previous_Day_CLICKS, 
       LAG(SUM(clicks), 7) OVER(
ORDER BY day) AS Seven_Days_Ago_CLICKS, 
       SUM(cost) AS Total_COST, 
       LAG(SUM(cost)) OVER(
ORDER BY day) AS Previous_Day_COST, 
       LAG(SUM(cost), 7) OVER(
ORDER BY day) AS Seven_Days_Ago_COST, 
       SUM(conversions) Total_CPM, 
       LAG(SUM(conversions)) OVER(
ORDER BY day) AS Previous_Day_CPM, 
       LAG(SUM(conversions), 7) OVER(
ORDER BY day) AS Seven_Days_Ago_CPM, 
       SUM(convrate) AS Total_CTR, 
       LAG(SUM(convrate)) OVER(
ORDER BY day) AS Previous_Day_CTR, 
       LAG(SUM(convrate), 7) OVER(
ORDER BY day) AS Seven_Days_Ago_CTR, 
       SUM(ctr) AS Total_SPEND, 
       LAG(SUM(ctr)) OVER(
ORDER BY day) AS Previous_Day_SPEND, 
       LAG(SUM(ctr), 7) OVER(
ORDER BY day) AS Seven_Days_Ago_SPEND,
       SUM(avgcpc) AS Total_SPEND, 
       LAG(SUM(avgcpc)) OVER(
ORDER BY day) AS Previous_Day_SPEND, 
       LAG(SUM(avgcpc), 7) OVER(
ORDER BY day) AS Seven_Days_Ago_SPEND
FROM GoogleAdsCampaigns
GROUP BY day
ORDER BY day;



--Performance Data for recent & previous day for FB by Date
SELECT CONVERT(VARCHAR(30), date_start, 23) AS Date_D, 
       SUM(clicks) AS Total_Clicks, 
       LAG(SUM(clicks)) OVER(
ORDER BY date_start) AS Previous_Day_CLICKS, 
       LAG(SUM(clicks), 7) OVER(
ORDER BY date_start) AS Seven_Days_Ago_CLICKS, 
       SUM(cpc) AS Total_CPC, 
       LAG(SUM(cpc)) OVER(
ORDER BY date_start) AS Previous_Day_CPC, 
       LAG(SUM(cpc), 7) OVER(
ORDER BY date_start) AS Seven_Days_Ago_CPC, 
       SUM(cpm) Total_CPM, 
       LAG(SUM(cpm)) OVER(
ORDER BY date_start) AS Previous_Day_CPM, 
       LAG(SUM(cpm), 7) OVER(
ORDER BY date_start) AS Seven_Days_Ago_CPM, 
       SUM(ctr) AS Total_CTR, 
       LAG(SUM(ctr)) OVER(
ORDER BY date_start) AS Previous_Day_CTR, 
       LAG(SUM(ctr), 7) OVER(
ORDER BY date_start) AS Seven_Days_Ago_CTR, 
       SUM(spend) AS Total_SPEND, 
       LAG(SUM(spend)) OVER(
ORDER BY date_start) AS Previous_Day_SPEND, 
       LAG(SUM(spend), 7) OVER(
ORDER BY date_start) AS Seven_Days_Ago_SPEND, 
       SUM(conversions) AS Total_CONVERSIONS, 
       LAG(SUM(conversions)) OVER(
ORDER BY date_start) AS Previous_Day_CONVERSIONS, 
       LAG(SUM(conversions), 7) OVER(
ORDER BY date_start) AS Seven_Days_Ago_CONVERSIONS
FROM FB_Raw
GROUP BY FB_Raw.date_start
ORDER BY date_start;



--Total Spend of RT Campaigns Vs. Total Spend of PROS Campaigns, Google Ads Campaigns
SELECT
(
    SELECT SUM(spend) AS PROS_Campaigns
    FROM FB_Raw
    WHERE campaign_name LIKE '%[[]PROS]%'
) AS Total_SPEND_of_PROS_Campaigns, 
(
    SELECT SUM(spend) AS RT_Campaigns
    FROM FB_Raw
    WHERE campaign_name LIKE '%[[]RT]%'
) AS Total_SPEND_of_RT_Campaigns;


--Total Cost of RT Campaigns Vs. Total Spend of PROS Campaigns, Google Ads Campaigns
SELECT
(
    SELECT SUM(cost) AS PROS_Campaigns
    FROM GoogleAdsCampaigns
    WHERE campaign LIKE '%[[]pros]%'
) AS Total_SPEND_of_PROS_Campaigns, 
(
    SELECT SUM(cost) AS RT_Campaigns
    FROM GoogleAdsCampaigns
    WHERE campaign LIKE '%[[]rt]%'
) AS Total_SPEND_of_RT_Campaigns;



--Total Cost for RT_Campaigns Daily Vs. Pros_Campaigns Daily | Google Ads Campaigns
SELECT A.Date_D, A.RT_Campaigns, A.Total_COST, B.PROS_Campaigns, B.Total_COST FROM 
(
SELECT CONVERT(VARCHAR(30), day, 23) AS Date_D, 'RT_Campaigns' AS RT_Campaigns, SUM(cost) AS Total_COST
    FROM GoogleAdsCampaigns
    WHERE campaign LIKE '%[[]rt]%'
    GROUP BY day
) AS A
JOIN 
(
SELECT CONVERT(VARCHAR(30), day, 23) AS Date_D, 'PROS_Campaigns' AS PROS_Campaigns, SUM(cost) AS Total_COST
    FROM GoogleAdsCampaigns
    WHERE campaign LIKE '%[[]pros]%'
    GROUP BY day
) AS B
ON A.Date_D = B.Date_D


--Total Spend for RT_Campaigns Daily Vs. Pros_Campaigns Daily | FB_Raw
SELECT A.Date_D, A.RT_Campaigns, A.Total_SPEND, B.PROS_Campaigns, B.Total_SPEND FROM 
(
SELECT CONVERT(VARCHAR(30), date_start, 23) AS Date_D, 'RT_Campaigns' AS RT_Campaigns, SUM(spend) AS Total_SPEND
    FROM FB_Raw
    WHERE campaign_name LIKE '%[[]RT]%'
    GROUP BY date_start
) AS A
JOIN 
(
SELECT CONVERT(VARCHAR(30), date_start, 23) AS Date_D, 'PROS_Campaigns' AS PROS_Campaigns, SUM(spend) AS Total_SPEND
    FROM FB_Raw
    WHERE campaign_name LIKE '%[[]PROS]%'
    GROUP BY date_start
) AS B
ON A.Date_D = B.Date_D


--For Visualization
--Total Spend for RT_Campaigns Daily Vs. Pros_Campaigns Daily | FB_Raw
SELECT A.Dates, A.RT_Campaigns, A.Total_SPEND, B.PROS_Campaigns, B.Total_SPEND FROM 
(
SELECT date_start AS Dates, 'RT_Campaigns' AS RT_Campaigns, SUM(spend) AS Total_SPEND
    FROM FB_Raw
    WHERE campaign_name LIKE '%[[]RT]%'
    GROUP BY date_start
) AS A
JOIN 
(
SELECT date_start AS Dates, 'PROS_Campaigns' AS PROS_Campaigns, SUM(spend) AS Total_SPEND
    FROM FB_Raw
    WHERE campaign_name LIKE '%[[]PROS]%'
    GROUP BY date_start
) AS B
ON A.Dates = B.Dates




--For Visualization



--Performance Data for Google Ads Campaigns by Date (SUM)
SELECT CONVERT(VARCHAR(30), day, 23) AS Date_D, 
       SUM(clicks) AS Total_Clicks, 
       AVG(clicks) AS AVG_Clicks, 
       SUM(cost) AS Total_COST, 
       AVG(cost) AS AVG_COST, 
       SUM(conversions) AS Total_CONVERSIONS, 
       AVG(conversions) AS AVG_CONVERSIONS, 
       SUM(convrate) Total_CONVERSION_RATE, 
       AVG(convrate) AVG_CONVERSION_RATE, 
       SUM(ctr) AS Total_CTR, 
       AVG(ctr) AS _CTR
FROM GoogleAdsCampaigns
GROUP BY GoogleAdsCampaigns.day
ORDER BY day;

--Performance Data for FB by Date (SUM & AVG)
SELECT CONVERT(VARCHAR(30), date_start, 23) AS Date_D, 
       SUM(clicks) AS Total_Clicks,
	   AVG(clicks) AS Total_Clicks, 
       SUM(spend) AS Total_SPEND, 
	   AVG(spend) AS Total_SPEND,
       SUM(conversions) AS Total_CONVERSIONS,
	   AVG(conversions) AS Total_CONVERSIONS, 
       SUM(cpc) Total_CPC,
	   AVG(cpc) Total_CPC, 
       SUM(ctr) AS Total_CTR,
	   AVG(ctr) AS Total_CTR,
	   SUM(cpm) AS Total_CPM,
	   AVG(cpm) AS Total_CPM
FROM FB_Raw
GROUP BY date_start
ORDER BY date_start;

Select CONVERT(VARCHAR(30), date_start, 23) AS Date_D, clicks, spend
FROM FB_Raw






----Metrics for Each Date & Specific Campaign For FB
--SELECT CONVERT(VARCHAR(30), date_start, 23) AS Date, 
--(
--    SELECT campaign_name, 
--           SUM(spend) AS Total_SPEND
--    FROM FB_Raw
--    WHERE campaign_name LIKE '%[[]PROS]%'
--    GROUP BY campaign_name
--) AS Total_SPEND_of_PROS_Campaigns, 
--(
--    SELECT CONVERT(VARCHAR(30), date_start, 23) AS Date, 
--           campaign_name, 
--           SUM(spend) AS Total_SPEND
--    FROM FB_Raw
--    WHERE campaign_name LIKE '%[[]RT]%'
--    GROUP BY campaign_name
--) AS Total_SPEND_of_RT_Campaigns
--FROM FB_raw
--GROUP BY date_start;


----Performance Data for recent & previous day for Google Ads Campaigns by Date
--SELECT CONVERT(VARCHAR(30), date_start, 23) AS Date_D, 
--       SUM(clicks) AS Total_Clicks, 
--       LAG(SUM(clicks)) OVER(
--ORDER BY date_start) AS Previous_Days_CLICKS
--FROM FB_Raw
--GROUP BY FB_Raw.date_start
--ORDER BY date_start;



----Metrics for Each Date & Specific Campaign
--SELECT campaign,
--       SUM(clicks) AS Total_Clicks, 
--       SUM(cost) AS Total_COST, 
--       SUM(conversions) AS Total_CONVERSIONS, 
--       SUM(convrate) Total_CONVERSION_RATE, 
--       SUM(ctr) AS Total_CTR
--FROM GoogleAdsCampaigns
--GROUP BY campaign
--HAVING campaign LIKE '[brand]%'




----Performance Data for FB by Date
--SELECT CONVERT(VARCHAR(30), date_start, 23) AS Date_D, 
--       SUM(clicks) AS Total_Clicks, 
--       SUM(cpc) AS Total_CPC, 
--       SUM(conversions) AS Total_CONVERSIONS, 
--       SUM(cpm) Total_CPM, 
--       SUM(ctr) AS Total_CTR, 
--       SUM(spend) AS Total_SPEND
--FROM FB_Raw
--GROUP BY date_start
--ORDER BY date_start;