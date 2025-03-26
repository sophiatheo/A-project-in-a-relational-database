Create database StaffEvaluation;
use StaffEvaluation;



CREATE TABLE IF NOT EXISTS company(
afm CHAR(9) NOT NULL  DEFAULT '0',
doy VARCHAR(15) NOT NULL,
name VARCHAR(35) NOT NULL DEFAULT 'unknown', 
phone BIGINT(16) NULL,
street VARCHAR(15) NOT NULL,
num TINYINT(4) NULL,
city VARCHAR(15) NOT NULL DEFAULT 'unknown', 
country VARCHAR(15) NOT NULL ,

PRIMARY KEY (afm),
UNIQUE KEY (name)
);




/* INSERT για company */
INSERT INTO company VALUES
('107120000','PATRAS', 'EASYTECH' ,'2610555510' ,'AGIOY NIKOLAOY' ,'180' , 'PATRA', 'ELLADA'),
('107120001', 'ATHINAS', 'COMPULAND', '2104563895', 'PANTANASSI' , '68' ,'ATHINA', 'ELLADA'),
('107120002', 'MESOLOGGI','CSA','2631025471','KYPROY', '13', 'MESOLOGGI','ELLADA');







CREATE TABLE IF NOT EXISTS user (
username VARCHAR(12) NOT NULL DEFAULT 'unknown',
password VARCHAR(10) NOT NULL,
name VARCHAR(25) NOT NULL,
surname VARCHAR(35) NOT NULL, 
reg_date DATETIME NOT NULL,
email VARCHAR(30) NOT NULL,

PRIMARY KEY (username)
);

/* INSERT για user */
INSERT INTO user VALUES
('PapaA','107123','Aristea' , 'Papaspyrou', '2017-01-20 15:30:00','AristeaPap@gmail.com'),
('ChristA', '592134','Kleiw', 'Christopoulou', '2018-04-25 14:40:00', 'KleiwChrist@hotmail.com'),
('TheoS','263514', 'Sofia','Theotokatou', '2016-9-14 10:00:00','SofiaTheot@gmail.com'),
('KonsK','1453','Konstadinos', 'Katakouzinos','2011-02-20 14:35:24','Katakouzinos@gmail.com'),
('ElV','1997','Eleni','Vlaxaki','2012-10-05 09:30:14','Eleni@gmail.com'),
('PeK','1256','Pegi','Kara','2011-02-20 20:30:55','Pegi@gmail.com'),
('ElS','2000', 'Eleni', 'Stamiri','2011-02-20 16:06:47', 'EleniS@gmail.com'),
('SpD','2001', 'Spyros', 'Deloglou','2010-04-03 00:00:00','Spyros@gmail.com'),
('StP','2002','Stela', 'Papalimneou','2009-02-20 00:00:00 ','Stela@hotmail.com');







CREATE TABLE IF NOT EXISTS manager(
managerUsername VARCHAR(12) NOT NULL DEFAULT 'unknown',
exp_years TINYINT(4) NULL,
firm CHAR(9) NOT NULL DEFAULT 'unknown',

PRIMARY KEY (managerUsername),
CONSTRAINT firm_has_afm
FOREIGN KEY (firm) REFERENCES company (afm) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT manager_antikeim
FOREIGN KEY (managerUsername) REFERENCES user(username) ON DELETE CASCADE ON UPDATE CASCADE 

);

 /* INSERT για manager */ 
INSERT INTO manager VALUES 
('KonsK' , '3' , '107120000'),
('ElV' , '2' , '107120001') , 
('PeK' , '7', '107120002');







CREATE TABLE IF NOT EXISTS antikeim(
title VARCHAR(36) NOT NULL,
descr TINYTEXT NOT NULL,
belongs_to VARCHAR(36) NOT NULL,

PRIMARY KEY(title),
CONSTRAINT titlecorrelation
FOREIGN KEY(belongs_to) REFERENCES antikeim(title) ON DELETE CASCADE ON UPDATE CASCADE
);

/*INSERT για antikeim */
INSERT INTO antikeim VALUES
('mixanikos','dimiourgia ylikou ypologsti', 'mixanikos'),
('plhroforikarios','dimiourgia programmatvn ','plhroforikarios'),
('oikonomologos', 'elegxos forologikvn eggrafvn','oikonomologos');





CREATE TABLE IF NOT EXISTS evaluator (
username VARCHAR(12) NOT NULL DEFAULT 'unknown',
exp_years TINYINT(4)  NULL,
firm CHAR(9) NOT NULL ,
PRIMARY KEY (username),
CONSTRAINT evaluator_username
FOREIGN KEY (username) REFERENCES user(username) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT evaluator_firm
FOREIGN KEY (firm) REFERENCES company(afm)  ON DELETE CASCADE ON UPDATE CASCADE
);

 /* INSERT για evaluator */
INSERT INTO evaluator VALUES
('ElS' , '2', '107120000'),
('SpD', '5' , '107120001'),
('StP', '7' , '107120002' );



CREATE TABLE IF NOT EXISTS job(
	id 	INT(4) NOT NULL AUTO_INCREMENT,
	start_date DATE NOT NULL,
	salary FLOAT(6,1) NOT NULL,
	position VARCHAR(40) NOT NULL,
	edra VARCHAR(45) NOT NULL,
	evaluator VARCHAR(12) NOT NULL,
	announce_date DATETIME,
	submission_date DATE NOT NULL,
	PRIMARY KEY(id),
	CONSTRAINT EVAL_USERNAMED 
	FOREIGN KEY(evaluator) REFERENCES evaluator(username)
	ON DELETE CASCADE ON UPDATE CASCADE
);



/* INSERT για job */
INSERT INTO job VALUES
(1070, '2014-10-03', 1500, 'Hardware Programmer', 'Thessaloniki', 'ElS', '2014-10-01 10:01:32', '2014-10-02'),
(1071, '2016-09-24', 2300, 'Software Programmer', 'Athens', 'SpD', '2016-09-22 12:10:23', '2016-09-23'),
(1072, '2015-11-14', 1000, 'Research Department','Patras','StP' , '2015-11-12 13:35:09', '2014-11-13');










CREATE TABLE IF NOT EXISTS needs(
job_id INT(4) NOT NULL DEFAULT '0',
antikeim_title VARCHAR(36) NOT NULL,
PRIMARY KEY(job_id , antikeim_title),
CONSTRAINT needs_job
FOREIGN KEY(job_id)REFERENCES job(id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT needs_antikeim
FOREIGN KEY (antikeim_title) REFERENCES antikeim(title) ON DELETE CASCADE ON UPDATE CASCADE
);

/* INSERT για needs */ 
INSERT INTO needs VALUES
("1070" ,'mixanikos' ),
("1071",'plhroforikarios'),
("1072" ,'oikonomologos');




















CREATE TABLE IF NOT EXISTS employee(
   username VARCHAR(12) NOT NULL,
   bio TEXT NOT NULL,
   sistatikes VARCHAR(35),
   certificates VARCHAR(35),
   awards VARCHAR(35),
   am VARCHAR(8) NOT NULL,		/*επιπλεον τα δυο αυτα πεδια */
   afm VARCHAR(9) NOT NULL,
   PRIMARY KEY(username),
   CONSTRAINT USERNAMEDEMPLOYEE
   FOREIGN KEY(username) REFERENCES user(username) ON DELETE CASCADE ON UPDATE CASCADE
);

/* INSERT για employee */
INSERT INTO employee VALUES
('PapaA', 'Graduator Computer Engineering and Informatics at University of Patras. Worked 3 years as a hardware engineer at Vodafone Business.', 'Mrs. Filipou','C2 at English and German', NULL,'1070739','12345'),
('ChristA', ' Graduated from Informatics and Telecommunication at University of Tripolis. Worked 5 years as a programmer at Eurobank', 'Mr. Papadopoulos', 'C2 at English and Spanish', NULL,'1070927','6789'),
('TheoS', 'Garduated from Department of Statistics at University of Athens. Worked 4 years as a statistical analyst at DAILY advertising company ', 'Mrs. Anagnostou', 'C2 at English and French.', NULL,'1071111','12369');








CREATE TABLE IF NOT EXISTS project(
   empl VARCHAR(12) NOT NULL,
   num TINYINT(4) NOT NULL ,
   descr TEXT NOT NULL,
   URL VARCHAR(60) NOT NULL,
   PRIMARY KEY(empl,num),
   UNIQUE (URL),
   CONSTRAINT EMPL_USERNAMED
   FOREIGN KEY(empl) REFERENCES employee(username)  ON DELETE CASCADE ON UPDATE CASCADE
);


/* INSERT για project */
INSERT INTO project VALUES
('PapaA', 12, 'Research in new and more economical ways of designing hardware.','https://github.com/papasp/hardware'),
('ChristA',13, 'Created new virtual graphics for user applications.', 'https://github.com/christop/graphics'),
('TheoS', 14, 'Worked at the new advertising campaing, based on new statistics results','https://github.com/theot/campain'); 







CREATE TABLE IF NOT EXISTS languages(
   employee_lang VARCHAR(12) NOT NULL,
   lang set('EN','FR','SP','GR'),
   PRIMARY KEY(employee_lang, lang),
   CONSTRAINT EMPL_LANGUAGE
   FOREIGN KEY(employee_lang) REFERENCES employee(username)  ON DELETE CASCADE ON UPDATE CASCADE
);

/* INSERT για languages */ 
INSERT INTO languages VALUES
('PapaA', 'GR,EN,FR'),
('ChristA', 'GR,EN,SP'),
('TheoS', 'GR,EN,FR');








CREATE TABLE IF NOT EXISTS requestevaluation(
   empl_username VARCHAR(12) NOT NULL,
   job_id INT(4) NOT NULL AUTO_INCREMENT,
   PRIMARY KEY(empl_username, job_id),
   CONSTRAINT EVAL_EMPLUSERNAMED 
   FOREIGN KEY(empl_username) REFERENCES employee(username) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT IDOFJOB 
   FOREIGN KEY(job_id) REFERENCES job(id) ON DELETE CASCADE ON UPDATE CASCADE
);


/* INSERT για requestavaluation */
INSERT INTO requestevaluation VALUES
('PapaA', 1070),
('ChristA', 1071),
('TheoS', 1072);





/* OΛΑ ΤΑ CONSTRAINT ΤΑ ΓΡΑΦΩ ΩΣ ΕΞΗΣ : ονομαπινακα_constr */


CREATE TABLE IF NOT EXISTS degree(
titlos VARCHAR(50) NOT NULL,
idryma VARCHAR(40) NOT NULL,
bathmida ENUM('LYKEIO', 'UNIV', 'MASTER','PHD'),

PRIMARY KEY(titlos,idryma)

)ENGINE=INNODB;

/* ΙΝΣΕΡΤ για degree */
INSERT INTO degree VALUES
('computer engineering and informatics', 'university of Patras', 'MASTER'),
('informatics and telecommunication', 'university of Tripolis', 'PHD'),
('department of statistics','university of Athens', 'UNIV');








CREATE TABLE IF NOT EXISTS has_degree(
degr_title VARCHAR(50) NOT NULL,
degr_idryma VARCHAR(40) NOT NULL,
empl_username VARCHAR(12) NOT NULL,
etos YEAR(4) NOT NULL,
grade FLOAT(3,1) NOT NULL,

PRIMARY KEY(degr_title,degr_idryma,empl_username),  

CONSTRAINT degr_title_titlos1
FOREIGN KEY (degr_title,degr_idryma) REFERENCES degree(titlos,idryma) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(empl_username) REFERENCES employee(username) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB;







/* INSERT για has_degree */
INSERT INTO has_degree VALUES
('computer engineering and informatics','university of Patras', 'PapaA', 2003, 7 ),
('informatics and telecommunication','university of Tripolis', 'ChristA', 2004, 6),
('department of statistics','university of Athens', 'TheoS',2005, 8);














CREATE TABLE IF NOT EXISTS evaluationresult (
Evid INT(4) NOT NULL,
empl_username VARCHAR(12) NOT NULL,
job_id INT(4) NOT NULL,
grade INT(4) NOT NULL,
comments VARCHAR(255),

PRIMARY KEY (Evid, empl_username),
UNIQUE (job_id),           

CONSTRAINT empl_username_username
FOREIGN KEY(empl_username) REFERENCES employee(username) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT job_id_id
FOREIGN KEY(job_id) REFERENCES job(id) ON DELETE CASCADE ON UPDATE CASCADE 

);

/* INSERT για evaluatioresult */
INSERT INTO evaluationresult VALUES
(1234,'PapaA', 1070, 3, 'organizational skills' ),
(2569, 'ChristA', 1071, 3, 'flexible work schedule'),
(6598, 'TheoS', 1072, 3, ' works well with other people');








/*ΔΙΚΟΙ ΜΑΣ ΠΙΝΑΚΕΣ */   /*Τα βαζω ολα ως primary key και ως foreign key εκτος απο τους βαθμους που θα τα βαλω ως unique*/


/* DEN EXEI PERASTEI */

CREATE TABLE IF NOT EXISTS axiologisi(
empl_username VARCHAR(12) NOT NULL,
job_id INT(4) NOT NULL,
onoma_evaluator VARCHAR(12) NOT NULL DEFAULT 'unknown',
grade_a INT(4)  NULL,
garde_b INT(4)  NULL,
grade_c INT(4) NULL,
comments VARCHAR(255),
imeronia DATE,


PRIMARY KEY(empl_username,job_id,onoma_evaluator),


CONSTRAINT empl_username_username1
FOREIGN KEY(empl_username) REFERENCES employee(username) ON DELETE CASCADE ON UPDATE CASCADE ,
CONSTRAINT job_id_id1
FOREIGN KEY(job_id) REFERENCES job(id) ON DELETE CASCADE ON UPDATE CASCADE ,
CONSTRAINT onoma_evaluator_username
FOREIGN KEY(onoma_evaluator) REFERENCES evaluator(username) ON DELETE CASCADE ON UPDATE CASCADE 

);

/* INSERT για axiologisi */
INSERT INTO axiologisi VALUES 
('PapaA', 1070, 'ElS ', 4, 3, 1, 'organizational skills','2019-04-20' ),
('ChristA',1071, 'SpD', 3, 3, 2, 'flexible work schedule', '2021-05-06');












CREATE TABLE IF NOT EXISTS ypovoli_aitiseon(
empl_username VARCHAR(12) NOT NULL,
job_id INT(4) NOT NULL,
aitisi_ID INT(10) NOT NULL,
aitisi_date DATE,


PRIMARY KEY(empl_username,job_id,aitisi_ID),

CONSTRAINT empl_username_username2
FOREIGN KEY(empl_username) REFERENCES employee(username) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT job_id_id2
FOREIGN KEY(job_id) REFERENCES job(id) ON DELETE CASCADE ON UPDATE CASCADE


);

/*INSERT για ypovoli_aitiseon */
INSERT INTO ypovoli_aitiseon VALUES
('PapaA', 1070, 369874, '2020-02-20'),
('ChristA',1071, 365987, '2020-02-26'),
('TheoS', 1072, 365792, '2020-02-18');










CREATE TABLE IF NOT EXISTS log(
eidos ENUM('insert', 'update', 'delete') NOT NULL,
username_xristi VARCHAR(12) NOT NULL,
datetime_energeias DATETIME NOT NULL,
state ENUM('SUCCESS ', 'FAILED') NOT NULL,
onoma_pinaka ENUM ('job', 'employee', 'requestsevaluation') NOT NULL
);







/******************************  PROCEDURES  **********************************/


/********PROCEDURE 3.1 *************/

DELIMITER $
CREATE PROCEDURE tria_ena (IN onoma VARCHAR(25), IN eponymo VARCHAR(35))
	BEGIN
	DECLARE olesaitiseis INT(10); 

	DECLARE onoma_axiologiti VARCHAR(25);
	DECLARE eponymo_axiologiti VARCHAR(35);  

	DECLARE kodikos_aitisis INT(10);



/*na emfanizontai oles oi aitiseis tou  ,  na symplirosoume gia na einai gia polles aitiseis kai oxi gia mia */
	SELECT aitisi_ID 
	INTO olesaitiseis 
	FROM ypovoli_aitiseon 
		INNER JOIN employee ON employee.username=empl_username
		INNER JOIN user ON user.username=employee.username 
		WHERE name=onoma AND surname=eponymo;






/*na emfanizontai to onoma kai to eponimo tou antistixou axiologiti */
/* Den mas ebgaze error alla otan to trexame px gia to onoma (Aristea,Papaspyrou) ebgaze to onoma axiologiti Aristea Papaspyrou */
	SELECT name,surname
	INTO onoma_axiologiti,eponymo_axiologiti
	FROM axiologisi
	  	INNER JOIN employee ON empl_username = username
	  	INNER JOIN user ON user.username = empl_username
	  	WHERE user.name=onoma AND user.surname=eponymo;  

	 SELECT onoma_axiologiti,eponymo_axiologiti;







	 SELECT aitisi_ID
	 INTO  kodikos_aitisis
	 FROM ypovoli_aitiseon 
	 	INNER JOIN employee ON ypovoli_aitiseon.empl_username=employee.username
	 	INNER JOIN user ON user.username = employee.username
	 	INNER JOIN axiologisi ON axiologisi.empl_username = employee.username 
	 	WHERE  name=onoma AND surname=eponymo AND axiologisi.imeronia < '2021-01-16';



	 	SELECT kodikos_aitisis ;





 SELECT olesaitiseis; 

END$
DELIMITER ;













/********PROCEDURE 3.2 *************/




DELIMITER $
CREATE PROCEDURE tria_dyo(IN kodikos_thesis INT(4), IN name_of_evaluator VARCHAR(12) )
   BEGIN
   DECLARE telikos_vathmos INT(4);
   DECLARE vathmos_a INT(4);
   DECLARE vathmos_b INT(4);
   DECLARE vathmos_c INT(4);
   DECLARE code INT(4);
     


   SELECT grade_a FROM axiologisi INTO vathmos_a;
   SELECT grade_b FROM axiologisi INTO vathmos_b;
   SELECT grade_c FROM axiologisi INTO vathmos_c;
   SELECT id INTO code FROM evaluationresult INNER JOIN job ON evaluationresult.job_id=job.id 
   INNER JOIN evaluator ON evaluator.username=job.evaluator 
   INNER JOIN user ON evaluator.username=user.username WHERE name=name_of_evaluator AND id=kodikos_thesis;
   


   IF(vathmos_a IS NOT NULL AND vathmos_b IS NOT NULL AND vathmos_c IS NOT NULL) THEN
            SET telikos_vathmos = (vathmos_a + vathmos_b + vathmos_c ) / 3 ;
    
    UPDATE evaluationresult SET grade=telikos_vathmos WHERE job_id=code;





END IF;
SELECT telikos_vathmos;


END$
DELIMITER ;














/**********PROCEDURE 3.3 *************/

DELIMITER $

CREATE PROCEDURE tria_tria(IN code_thesis INT(4))
BEGIN 

DECLARE date_of_axiologisi DATE;

DECLARE id_of_aitiseis INT(10);


SELECT imeronia INTO date_of_axiologisi FROM axiologisi WHERE code_thesis=job_id;


IF (date_of_axiologisi < '2021-01-16') THEN 
      SELECT 'Oristikopoiimenoi pinakes';
      SELECT name FROM evaluationresult
      INNER JOIN employee ON empl_username=username
      INNER JOIN user ON user.username=employee.username WHERE code_thesis=job_id
      ORDER BY grade DESC;


ELSE  
	  SELECT aitisi_ID
	  INTO id_of_aitiseis 
	  FROM ypovoli_aitiseon
	  		INNER JOIN employee ON ypovoli_aitiseon.empl_username = employee.username
	  		INNER JOIN axiologisi ON axiologisi.empl_username = employee.username
	  		WHERE imeronia > '2021-01-16' ;

	  	SELECT 'axiologisi se exelixi,ekremoun ';
	  	SELECT id_of_aitiseis;
	  	SELECT 'aitiseis';	








END IF;



END$ 
DELIMITER ;




/************************************************TRIGGER***********************************************/


/*************************TRIGGER1********************/


/*******TRIGGER FOR job ********/

DELIMITER $
CREATE TRIGGER after_update_job
AFTER UPDATE ON job 
FOR EACH ROW
		BEGIN 
	
		DECLARE eidos_log1 ENUM('insert', 'update', 'delete');
		DECLARE username_xristi_log1 VARCHAR(12);
		DECLARE datetime_energeias_log1 DATETIME;
		DECLARE state_log1 ENUM('SUCCESS ', 'FAILED');
		DECLARE onoma_pinaka_log1 ENUM ('job', 'employee', 'requestsevaluation');


		SET eidos_log1 = 'update';
		SET datetime_energeias_log1 = CURDATE();

		IF(New.id <> Old.id AND NEW.start_date IS NOT NULL AND NEW.salary IS NOT NULL AND NEW.position IS NOT NULL AND NEW.edra IS NOT NULL AND NEW.evaluator IS NOT NULL AND NEW.submission_date IS NOT NULL ) 
		THEN
				SET state_log1 = 'SUCCESS';


		ELSE SET state_log1 = 'FAILED' $

		END IF;		

		SET onoma_pinaka_log1 = 'job';		

		SELECT user.username
		INTO username_xristi_log1 
		FROM user
				INNER JOIN evaluator ON user.username = evaluator.username 
				INNER JOIN job ON evaluator.username = job.evaluator
				WHERE New.evaluator = Old.evaluator;



		INSERT INTO log VALUES(eidos_log1,username_xristi_log1, datetime_energeias_log1, state_log1, onoma_pinaka_log1);			
			

		END $












/*************************TRIGGER2********************/
DELIMITER $
CREATE TRIGGER before_update_company
BEFORE UPDATE ON company
FOR EACH ROW
	BEGIN

	SET NEW.afm = OLD.afm ;
	SET NEW.doy = OLD.doy;
	SET NEW.name = OLD.name; 

	END $ 

DELIMITER ;






/*************************TRIGGER3********************/

DELIMITER $
CREATE TRIGGER user_administrator
AFTER UPDATE ON user 
FOR EACH ROW 
	BEGIN

	IF (New.username <> Old.username) THEN
		SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'Username can only changed by the administrator';
		
	END IF ;
	
	END $