select * from access_tools.users a where a.username ='197511241995031001';

-- pass asli: 232b5c2029972a0f69a0385347b28275
-- pass ubah (P@ssw0rd): 161ebd7d45089b3446ee4e0d86dbcf92 

select a.id_user,tnp.* from access_tools.users a 
left join access_tools.td_notif_preferences tnp on a.id_user = tnp.id_user where a.username ='199506072015021003'
union all 
select a.id_user,tnp.* from access_tools.users a 
left join access_tools.td_notif_preferences tnp on a.id_user = tnp.id_user where a.username ='197511241995031001'
;

select * from access_tools.td_notif_preferences tnp where id_user ='662081';