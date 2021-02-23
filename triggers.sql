DROP PROCEDURE IF EXISTS ADDTOFAVOURITE;
DROP TRIGGER IF EXISTS like_genre_trigger;
DROP TRIGGER IF EXISTS like_playback_trigger;
DELIMITER ;;

CREATE PROCEDURE ADDTOFAVOURITE( IN material_title VARCHAR(256), IN profile_name VARCHAR(256) )
BEGIN
DECLARE n INT DEFAULT 0;
DECLARE i INT DEFAULT 0;
DECLARE genre_name_atr VARCHAR(45);
SELECT COUNT(*) FROM genres_materials WHERE genres_materials.material_title = material_title INTO n;
SET i=0;
	WHILE i < n DO 
		SELECT genre_name INTO genre_name_atr FROM genres_materials WHERE genres_materials.material_title = material_title LIMIT i, 1;
		INSERT IGNORE INTO favourite_genres(genre_name, profile_name) VALUES ( genre_name_atr, profile_name );
		SET i = i + 1;
	END WHILE;
End;
;;

CREATE TRIGGER like_genre_trigger
AFTER INSERT
ON likes FOR EACH ROW
	CALL ADDTOFAVOURITE( NEW.material_title, NEW.profile_name );;

CREATE TRIGGER like_playback_trigger
AFTER INSERT
ON playbacks FOR EACH ROW
	CALL ADDTOFAVOURITE( NEW.ref_title, NEW.profile_name );;
