-- DROP TABLE IF EXISTS public.jmesh_l1;

CREATE TABLE public.jmesh_l1 AS
SELECT
 TRUNC( y*150 )  + x-100  AS meshcode 
 ,  ST_MakeEnvelope( x , y , x+1.0 ,  y+(40.0/60.0) , 4326 )  AS the_geom
FROM 
 generate_series( 20.0 , 46.0 , 40.0/60.0) AS y
LEFT OUTER JOIN 
 generate_series( 122, 153 , 1) AS x  
ON y > 0
 ;
