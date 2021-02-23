----------------------------------------------
Acceso a lista de reproducción de un profile
----------------------------------------------


----------------------------------------------
Acceso a material seleccionado de un profile
----------------------------------------------
SELECT * FROM materials_profiles WHERE materials_profiles.profile_name = "luciano";


----------------------------------------------
Acceso a lista con el material popular
----------------------------------------------

SELECT materials.*, COUNT() AS PlaybackCount 
FROM materials 
LEFT JOIN playbacks ON materials.title = playbacks.ref_title
GROUP BY materials.title
ORDER BY PlaybackCount DESC;

------------------------------------------------------------------------------------------------------------------------------------------
Acceso a lista por cada género de preferencia del perfil con el material ordenado descendentemente por grado de afinidad
------------------------------------------------------------------------------------------------------------------------------------------

SELECT * 
FROM materials 
INNER JOIN genres_materials ON genres_materials.material_title = materials.title
INNER JOIN recommendations ON recommendations.material_title = materials.title AND recommendations.profile_name = "luciano"
WHERE genres_materials.genre_name = "Accion"
ORDER BY recommendations.similarity DESC;
