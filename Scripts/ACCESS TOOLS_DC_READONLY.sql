select * from pabean.td_header th;

select * from access_tools.users limit 100;

select length ('3578151904730003');


with master as (
SELECT DISTINCT a.nib,
    a.nipu,
    a.nama_perseroan,
    replace(replace(replace(replace(a.geo_loc::text, '{"center":['::text, ''::text), '],"zoom":'::text, ''::text), '"'::text, ''::text), '}'::text, ''::text) AS koordinat_lok,
        CASE
            WHEN a.kd_kegiatan_usaha::text = '1'::text THEN 'Manufaktur'::text
            WHEN a.kd_kegiatan_usaha::text = '2'::text THEN 'Jasa'::text
            WHEN a.kd_kegiatan_usaha::text = '3'::text THEN 'Logistik'::text
            ELSE NULL::text
        END AS kegiatan_utama,
    d.uraian_usaha,
    a.kbli,
    a.tgl_pengajuan_nib,
    a.jenis_kegiatan,
    b.ur_kek,
    b.kd_kek,
    b.kd_pos_kek
   FROM pu.tr_pu_header a
     JOIN referensi.tr_kek b ON a.kd_kek = b.kd_kek AND (a.kd_kek <> ALL (ARRAY[100, 166]))
     JOIN pu.tr_log_pu c ON a.id_pu_header = c.id_pu_header
     JOIN pu.tr_nib_detail_proyek d ON d.id_pu_header = a.id_pu_header
  WHERE a.nama_perseroan::text <> 'PU Argo'::text
  GROUP BY a.nib, a.npwp_perseroan, a.nipu, a.nama_perseroan, a.geo_loc, a.kordinat, a.kd_kegiatan_usaha, d.uraian_usaha, a.kbli, a.jenis_kegiatan, a.tgl_pengajuan_nib, b.ur_kek, b.kd_kek, b.kd_pos_kek)
  select distinct a.nama_perseroan,b.organization_number as nib,c.id_number as npwp
  from master a
  left join access_tools.organizations b
  on a.nib = b.organization_number
  join access_tools.users c 
  on b.id_organization = c.id_organization
  where nipu is not null and kd_kek <> 100 and length(c.id_number) > 9;
  
 
select * from access_tools.users where id_user=81
 
select id_group from access_tools."groups" g where g.group_name ilike '%admin ppbj%';
select * from access_tools.user_groups ug  where id_user ='81';

select id_group,group_name  from access_tools."groups" g where g.group_name ilike '%layer%';



select ug.id_user,u.* from access_tools.user_groups ug 
join access_tools.users u on ug.id_user  = u.id_user
where id_group ='26382';

select id_user,decided_date,decided_by,decided_msg,id_user,payload from access_tools.user_registration as ur where is_approved is false;

select * from access_tools.users x where x.username ='SLBYJL';


select a.* ,c.organization_number as nib,c.organization_name, b.payload from access_tools.users a 
join access_tools.user_registration as b
join access_tools.organizations as c on b.id_organization = c.id_organization 
on a.id_user = b.id_user
where a.username = 'SLBYJL'


select a.uuid_user as id_user,b.uuid_organization as id_organization,
b.organization_number as nib,b.npwp_number as npwp,
b.organization_name  as nama, a.email, a.phone_number,
b.organization_name as nama_badan_usaha,
b.npwp_number as npwp_badan_usaha, 
b.organization_address as alamat_badan_usaha,
a.full_name as nama_penanggung_jawab,
a."position" as posisi_penanggung_jawab
from access_tools.users a
join access_tools.organizations b
on a.id_organization = b.id_organization 
where a.uuid_user ='9aeb1c6e-0f21-eefa-d5ac-d7fbd00c1bd9';


select uuid_user,id_user_parent,b.payload as data_registrasi from access_tools.users a 
left join access_tools.user_registration b
on a.id_user = b.id_user
where uuid_user ='9aeb1c6e-0f21-eefa-d5ac-d7fbd00c1bd9'

select * from access_tools.user_registration as ur
where ur.id_registration ='501008F3E3A43';


select * from access_tools.users as u;

select * from nsw_sso."Clients" as c;


select * from access_tools."groups" as g where group_name ilike 'Admin NLE%';

select * from access_tools.users where username ='199506072015021003';

select * from access_tools.user_groups as ug where id_user='398809';

-- 27517

select * from access_tools.groups;

select * from access_tools.td_menu as tm where ext_url like '%kuota%';





 