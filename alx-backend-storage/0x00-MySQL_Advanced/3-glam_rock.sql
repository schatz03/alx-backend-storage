--  a SQL script that lists all bands with Glam rock as their main style, ranked by their longevity
-- 
-- Requirements:
-- 
-- Column names must be: band_name and lifespan (in years until 2022 - please use 2022 instead of YEAR(CURDATE()))
-- You should use attributes formed and split for computing the lifespan
-- Your script can be executed on any database

SELECT `band_name`, IFNULL(`split` - `formed`, 2022 - `formed`) as `lifespan`
FROM `metal_bands`
WHERE  FIND_IN_SET('Glam rock', style) > 0
ORDER BY `lifespan` DESC;
