----------------------------------------------
#Acceso a lista de reproducción de un profile
----------------------------------------------

Select DISTINCT playbacks.ref_material_title, IF (playbacks.minutes / chapters.duration > 0.90, 1, 0) as FINISHED from chapters 
INNER JOIN playbacks ON (chapters.title = playbacks.ref_title AND playbacks.ref_type = 'chapters'  )  
WHERE playbacks.minutes / chapters.duration <= 0.90 AND playbacks.profile_name = 'luciano'
UNION
Select playbacks.ref_material_title, IF (playbacks.minutes / movies.duration > 0.90, 1, 0) as FINISHED  from movies 
INNER JOIN playbacks ON (movies.material_title = playbacks.ref_title AND playbacks.ref_type = 'movies')  
WHERE playbacks.minutes / movies.duration <= 0.90;

----------------------------------------------
#Acceso a material seleccionado de un profile
----------------------------------------------
SELECT * FROM materials_profiles WHERE materials_profiles.profile_name = "luciano";


----------------------------------------------
#Acceso a lista con el material popular
----------------------------------------------

SELECT materials.*, COUNT(1) AS PlaybackCount 
FROM materials 
LEFT JOIN playbacks ON materials.title = playbacks.ref_title
GROUP BY materials.title
ORDER BY PlaybackCount DESC;

------------------------------------------------------------------------------------------------------------------------------------------
#Acceso a lista por cada género de preferencia del perfil con el material ordenado descendentemente por grado de afinidad
------------------------------------------------------------------------------------------------------------------------------------------

SELECT * 
FROM materials 
INNER JOIN genres_materials ON genres_materials.material_title = materials.title
INNER JOIN recommendations ON recommendations.material_title = materials.title AND recommendations.profile_name = "luciano"
WHERE genres_materials.genre_name = "accion"
ORDER BY recommendations.similarity DESC;
