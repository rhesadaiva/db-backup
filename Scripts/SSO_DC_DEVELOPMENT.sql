-- nib oss
--2411230081199
--2411230081199
--2711230297509
--2711230256875
--2711230256875
--2311230114158
--2411230087152
--2411230087152
--2711230408174
--0712230236771
--0712230236771
--0712230236771
--2311230113225
--2311230113225
--2411230021808
--2411230021808
--2411230021808
--2411230021808
--2311230087026
--1312230272257
--2811230069272

select * from access_tools.user_registration where payload::jsonb->>'nib' = '2704220034789'

select * from access_tools.users where id_user='408727';


select * from access_tools.user_groups as ug where id_user=408727


select * from access_tools."groups" where id_organization='406296';


select * from access_tools.user_groups as ug where id_user='408727';

select * from access_tools."groups" as g where id_;


select * from access_tools."groups" as g;

--27582

select * from access_tools.users;

select * from access_tools.users where username ='test_NLE';

select * from access_tools.user_groups as ug;

select * from access_tools.user_registration as ur where id_user='408727';
--408728

select id_group from access_tools."groups" as g where group_name ilike 'Admin NLE%';


select * from access_tools.user_groups as ug;

select * from nsw_sso."Clients" where id='9c1eabe7-7a8f-4b0d-9d40-2e14166be55f';

select * from nsw_sso."InitialAccessTokens" as iat limit 10;

select * from access_tools.users where username ='6I7GFP';

INSERT INTO access_tools.users ("position",sik_number,id_number,address,phone_number,fax_number,postal_code,city,mobile_number,email,username,"password",full_name,id_organization,last_update_password,expired,block_date,id_block,employee_number,login_flag,id_user_parent,last_login,record_by,record_date,update_by,update_date,create_date,analyzing_point,office_code,point_flag,tracking_flag,admin_flag,verify_flag,"status",inactive,kd_ga,kd_detail_ga,islogin,kd_level_ga,photo_profile,uuid_user) VALUES
     ('Direktur',NULL,'7172062107830001',NULL,'6287654321888',NULL,NULL,NULL,'6281362778132','mail@mail.com','6I7GFP','d7de46519fd98c37e6244fbd7b8514d1','FIKRI SOLAHHUDDIN ZUBAIDI',406296,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'408727','2024-03-21 08:35:09.924','2024-03-21 08:25:44.660',NULL,NULL,NULL,NULL,true,true,NULL,false,NULL,NULL,false,NULL,NULL,'a3237bae-83b2-da1f-6a23-a6db6e5dbd15');


select from access_tools.users where username = '6I7GFP';

select * from access_tools.users where id_user='408729';

-- cheeck id_role berdasarkan username
select a.username,c.uuid_group from access_tools.users a
join access_tools.user_groups b on a.id_user = b.id_user
join access_tools.groups c on b.id_group = c.id_group
where a.username = 'test_NLE';

select * from access_tools.groups where id_group = 27582;
select * from access_tools.user_groups where id_user = 408728;

select * from nsw_sso."Clients" as c where id='9c1eabe7-7a8f-4b0d-9d40-2e14166be55f';

select * from nsw_sso."InitialAccessTokens" as iat limit 1;

select * from access_tools.organizations as o;

select * from nsw_sso."RegistrationAccessTokens" as rat where rat.data->>'clientId' = '9c1eabe7-7a8f-4b0d-9d40-2e14166be55f';

select id from nsw_sso."RegistrationAccessTokens" rat where rat."data" ->>'clientId' ='9c1eabe7-7a8f-4b0d-9d40-2e14166be55f';

select * from access_tools.user_registration where user_registration.id_registration ='501008F4E8DDA';

select * from access_tools.users where id_user='408727';

select * from access_tools.user_registration as ur where ur.id_user='408734';

select ur.payload ->>'nib' from access_tools.user_registration as ur where ur.payload ->> 'nib' in ('2411230081199', '2711230297509', '2711230256875', '2311230114158', '2411230087152', '2711230408174', '0712230236771', '2311230113225', '2411230021808', '2311230087026', '1312230272257', '2811230069272');

select * from referensi.tr_jenis_user_register as tjur;


select distinct payload::jsonb->>'jenis_platform' as jenis_platform from access_tools.user_registration as ur;

select * from access_tools.user_groups as ug where id_user = 408727;

select * from access_tools.user_groups as ug where id_user = 408727;

select * from access_tools.user_registration as ur 
where payload->>'tujuan_penggunaan' = 'B'
order by created_date desc limit 5;

select * from access_tools.td_acl as ta;

select uuid_generate_v4();

select * from access_tools.organizations where id_organization='406296';

select * from access_tools.user_registration as ur where id_registration in ('501008F4E8DD8','501008F4E8DDA','501008F4E8DDB');

select * from access_tools."groups" as g where g.id_organization ='406301';


-- simulate approval
-- set true
update access_tools.user_registration set 
is_approved = true, decided_by='SYSTEM', decided_date=now(), decided_msg='OK'
where id_registration='501008F4E8DD8' returning *;

-- insert group
insert into access_tools.groups (group_name, id_group_parent, create_date,id_organization,admin_flag, id_default_home,createby ,status, uuid_group )
values(
concat('Super Admin',(select x.payload->>'jenis_organisasi' from access_tools.user_registration x where x.id_registration = $1 )),
null,now(),(select x.id_organization from access_tools.user_registration x where x.id_registration = $1) , true, 'SB011','SYSTEM', true, (select uuid_generate_v4()))
returning id_group;

-- insert user_group
insert into access_tools.user_groups
(id_user,id_group,is_selected,create_date)
values ((select x.id_user from access_tools.user_registration x where x.id_registration = $1), 
(select x.id_group from access_tools.groups x where x.id_organization = (select z.id_organization from access_tools.user_registration z where z.id_registration = $1)),
true, 
now()
)
returning *;

--inject password
update access_tools.users set password=md5('password'),verify_flag = true
where id_user = (select x.id_user from access_tools.user_registration x where x.id_registration=$1)
returning username, "password";

-- update verify flag


-- end


select * from access_tools.users where id_user in 
(select x.id_user from access_tools.user_registration x where x.id_registration in ('501008F4E8DD8','501008F4E8DDA','501008F4E8DDB'))

select a.id_user,a.id_registration, b.username, b.password,b.full_name,b.verify_flag
from access_tools.user_registration a
join access_tools.users b on a.id_user = b.id_user
where a.id_registration in ('501008F4E8DD8','501008F4E8DDA','501008F4E8DDB');



with caunima as(select id,data->'request_uris' as uris from nsw_sso."Clients")
select * from caunima where uris::varchar like '%dev%'


select * from nsw_sso."Clients" where id in ('251fc327-fa4b-4ac2-8d9e-6a2c4ddbaa86','fd5759f7-5695-4c67-8d5a-ac320a5950dc');

select "data"->>'origin' from nsw_sso."ClientKeyStores" as cks;



select username from access_tools.users where uuid_user='8a88e9c3-b066-4b59-aac5-c8b8a8e33427';


select * from nsw_sso."Clients" as c where "data"::varchar like '%localhost%';

sele

select * from nsw_sso."Clients" where data::jsonb->>'client_name' ilike '%nle%';

select * from nsw_sso."ClientCredentials" as cc limit 10;

select * from access_tools.user_registration as ur where is_approved is false order by created_date desc;





