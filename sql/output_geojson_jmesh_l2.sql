WITH jmesh_l2 AS(
SELECT 
  TRUNC( y*1.5 ) *10000  + 
  TRUNC(x - 100)*100 + 
  TRUNC(TRUNC( (((y*60)::int)%40 )/5)*10) +
  TRUNC (( x -TRUNC(x))/(45.0/360.0) )
 AS meshcode 
 ,  ST_MakeEnvelope( x , y , x+(45.0/360.0) ,  y+(5.0/60.0) , 4326 )  AS the_geom
FROM 
 generate_series( 20.000000, 46.0 - (5.0/60.0) , 5.0/60.0) AS y
LEFT OUTER JOIN 
 generate_series( 122.000000, 154 -(45.0/360.0), (45.0/360.0) ) AS x  
ON y > 0
)
SELECT 
('{ "type": "FeatureCollection",  "features": [' ||

 array_to_string( array_agg( 
   '{ "type": "Feature","geometry": '
 || ST_Asgeojson( the_geom )  
 || ',"properties":{"meshcode":'  || meshcode 
 || '}}' )  
 , ',' ) 
 || ']}' )::text
 
FROM jmesh_l2;