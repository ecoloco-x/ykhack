

-- killer name : 'Miranda Priestly'



-- start with crime scene --        
select * from crime_scene_report
where date = '20180115' and type = 'murder' and city = 'SQL City'
-- Northwestern Dr; Annabel,Franklin Ave


-- find first witness --
select * from person
where lower(address_street_name) like '%northwestern%'
order by address_number desc
-- id = 14887  license_id = 118009 ssn = 111564949

-- find second witness
select * from person
where lower(name) like '%annabel%'
-- 16371 license_id = 490173 ssn = 318771143


-- check out interview 
select * from interview
where person_id in (14887, 16371)
-- suspect profile: 
-- man, membership num starts with 48Z, gold member, car plate with H42W
-- gym check in jan 9th


-- check out gym data
select * from get_fit_now_member where membership_status = 'gold' and id like '48Z%'
-- suspect person_id 28819, 67318
select * from get_fit_now_check_in where check_in_date = 20180109 and membership_id like '48Z%'
-- two suspects remain

-- get their license
select * from person where id in (28819, 67318)
-- person_id 28819 license_id = 173289
-- person_id 67318 license_id = 423327


-- get car info
select * from drivers_license where id in (173289, 423327) 
-- 67318 is the only suspect


-- check interview log
select * from interview where person_id = 67318
-- client profile: 
-- income high, height 5'5" (65") or 5'7" (67"), female, red hair, Tesla Model S
-- attended SQL Symphony Concert 3 times in December 2017.


-- look for suspects
select * from drivers_license where gender = 'female' and car_make like '%Tesla%' and hair_color = 'red'
-- main suspect license_id = 918773
-- other two sus 202298, 291182


-- check their income
select * from person p
left join income i 
	on i.ssn = p.ssn
where license_id in (918773,202298, 291182)
-- remaining sus 78881 (main), 99716

-- check out fb event
select person_id, count(date) as cnt from facebook_event_checkin where date > 20171200 and date < 20180000
group by 1
having cnt = 3

-- it's 99716

-- get killer's name
select * from person where id = 99716


'Miranda Priestly'