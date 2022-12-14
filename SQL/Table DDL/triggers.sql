# TRIGGERS
DROP TABLE IF EXISTS user_verification_log;
DROP TRIGGER IF EXISTS user_verification_trigger;

CREATE TABLE user_verification_log (
user_id VARCHAR(200),
user_display_name VARCHAR(150),
log_date DATE,
log_message VARCHAR(100)
);

delimiter //
CREATE TRIGGER user_verification_trigger
AFTER UPDATE ON tweet_user
FOR EACH ROW
BEGIN
IF !(NEW.verified_account <=> OLD.verified_account) THEN
  INSERT INTO user_verification_log(user_id, user_display_name, log_message, log_date)
  VALUES(NEW.user_id, NEW.user_display_name, "USER VERIFIED!", NOW());
END IF;
END;
//
delimiter ;

UPDATE tweet_user SET verified_account="true" WHERE twitter_handle="10josalu";