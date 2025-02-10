select * from nsw_nle.td_platform tp;



select * from nsw_nle.tr_layanan tl ;


select * from nsw_nle.tr_proses_layanan tpl;

select * from nsw_nle.td_layananplatform tl ;

select tl.*,tp.nama as nama_platform,b.nama as nama_layanan from nsw_nle.td_layananplatform tl
left join nsw_nle.tr_layanan b on tl.id_layanan  = b.id_layanan
left join nsw_nle.td_platform tp on tl.platform_id = tp.platform_id ;

-- query get platform dan jenis layanan
select a.platform_id,b.kd_layanan,b.nama as nama_layanan,c.nama as nama_platform,
c.uri,c.redirect_uri
from nsw_nle.td_layananplatform a
left join nsw_nle.tr_layanan b on a.id_layanan  = b.id_layanan
left join nsw_nle.td_platform c on a.platform_id = c.platform_id where kd_layanan='4';


select * from nsw_nle.tr_proses_layanan where kd_layanan ='4' and kd_proses_layanan ='01';


select * from nle_dev.mst_platform mp;

-- truk fcb5d67f-a1bb-3466-ca6f-e9f23618ee2a

select * from nsw_nle.td_platform as tp;

select * from nsw_nle.td_platform_file as tpf;

select * from nle_dev.tt_users as tu;

select * from nle_dev.categories_platforms;




select * from nsw_nle.td_layananplatform as tl;

SELECT DISTINCT id_jenis_layanan ,jenis_layanan
FROM referensi.tr_jenis_layanan_nle 
JOIN LATERAL jsonb_array_elements_text(kd_kbli) AS elem(kd) ON elem.kd IN ('49431', '52108', '52109');

UPDATE referensi.tr_jenis_layanan_nle
SET kd_kbli = CASE
    WHEN jenis_layanan = 'Dukungan UMKM' THEN NULL::jsonb
    WHEN jenis_layanan = 'Delivery Online (DO)' THEN '["50131", "50132", "50133", "50134", "50135", "50141", "50142", "50143", "50221", "50222", "50223", "52291", "52292", "52293", "52294", "52295", "52297", "63111", "63112", "63121", "63122"]'::jsonb
    WHEN jenis_layanan = 'Surat Penyerahan Peti Kemas (SP2)' THEN '["52101", "52102", "52103", "52104", "52105", "52106", "52107", "52108", "52109", "52221", "52222", "52223", "52224", "52225", "52229", "52240", "52291", "52292", "52293", "52294", "52295", "52298", "52299", "63111", "63112", "63121", "63122"]'::jsonb
    WHEN jenis_layanan = 'Trucking' THEN '["49431", "49432", "49433", "52291", "52292", "52293", "52294", "52295", "63111", "63112", "63121", "63122"]'::jsonb
    WHEN jenis_layanan = 'Vessel Domestik' THEN '["50131", "50132", "50133", "50134", "50135", "50221", "50222", "50223", "50224", "50225", "50226", "50227", "50228", "50229", "52291", "52292", "52293", "52294", "52295", "52297", "63111", "63112", "63121", "63122"]'::jsonb
    WHEN jenis_layanan = 'Vessel International' THEN '["50141", "50142", "50143", "52291", "52292", "52293", "52294", "52295", "52297", "63111", "63112", "63121", "63122"]'::jsonb
    WHEN jenis_layanan = 'Depo' THEN '["52291", "52292", "52293", "52294", "52295", "63111", "63112", "63121", "63122"]'::jsonb
    WHEN jenis_layanan = 'Gatepass Ekspor' THEN '["52291", "52292", "52293", "52294", "52295", "52298", "52299", "63111", "63112", "63121", "63122"]'::jsonb
    WHEN jenis_layanan = 'Gudang' THEN '["52101", "52102", "52103", "52104", "52105", "52106", "52107", "52108", "52109", "52291", "52292", "52293", "52294", "52295", "63111", "63112", "63121", "63122"]'::jsonb
    WHEN jenis_layanan = 'Gatepass Curah' THEN '["52101", "52102", "52103", "52104", "52105", "52106", "52107", "52108", "52109", "52221", "52222", "52223", "52224", "52225", "52229", "52240", "52291", "52292", "52293", "52294", "52295", "52298", "52299", "63111", "63112", "63121", "63122"]'::jsonb
    WHEN jenis_layanan = 'Cargo Delivery Online' THEN '["52101", "52102", "52103", "52104", "52105", "52106", "52107", "52108", "52109", "52231", "52291", "52292", "52293", "52294", "52295", "52296", "63111", "63112", "63121", "63122"]'::jsonb
    WHEN jenis_layanan = 'Forwarder/PPJK' THEN '["49120", "52291", "52292", "52293", "52294", "52295", "63111", "63112", "63121", "63122"]'::jsonb
    WHEN jenis_layanan = 'Rail Flight Services / Jasa Kargo Kereta' THEN '["49120", "52291", "52292", "52293", "52294", "52295", "63111", "63112", "63121", "63122"]'::jsonb
    WHEN jenis_layanan = 'Penyelenggara Pos' THEN '["52291", "52292", "52293", "52294", "52295", "53100", "53201", "53202", "63111", "63112", "63121", "63122"]'::jsonb
    WHEN jenis_layanan = 'Airlines' THEN '["51201", "51202", "51203", "51204", "52291", "52292", "52293", "52294", "52295", "52296", "63111", "63112", "63121", "63122"]'::jsonb
    WHEN jenis_layanan = 'Konsolidator' THEN '["49120", "52101", "52102", "52103", "52104", "52105", "52106", "52107", "52108", "52109", "52291", "52292", "52293", "52294", "52295", "63111", "63112", "63121", "63122"]'::jsonb
    WHEN jenis_layanan = 'Payment Gateway' THEN '["64121", "64122", "64123", "64131", "64132", "64190", "66411"]'::jsonb
    WHEN jenis_layanan = 'Pembiayaan/Financing' THEN '["64121", "64122", "64123", "64131", "64132", "64911", "64912", "64913", "64941", "64942", "64943", "64991", "66411"]'::jsonb
    WHEN jenis_layanan = 'Bank Garansi' THEN '["64121", "64122", "64123", "64131", "64132"]'::jsonb
    WHEN jenis_layanan = 'Pengajuan L/C' THEN '["64121", "64122", "64123", "64131", "64132"]'::jsonb
    WHEN jenis_layanan = 'Asuransi' THEN '["65121", "65122", "65123"]'::jsonb
    WHEN jenis_layanan = 'Customs Bond' THEN '["65121", "65122", "65123"]'::jsonb
END
WHERE jenis_layanan IN (
    'Dukungan UMKM', 'Delivery Online (DO)', 'Surat Penyerahan Peti Kemas (SP2)', 'Trucking', 'Vessel Domestik', 'Vessel International', 'Depo', 'Gatepass Ekspor', 'Gudang', 'Gatepass Curah', 'Cargo Delivery Online', 'Forwarder/PPJK', 'Rail Flight Services / Jasa Kargo Kereta', 'Penyelenggara Pos', 'Airlines', 'Konsolidator', 'Payment Gateway', 'Pembiayaan/Financing', 'Bank Garansi', 'Pengajuan L/C', 'Asuransi', 'Customs Bond'
);


CREATE TABLE nsw_nle.td_penomoran_platform_nle (
    id_penomoran_nle uuid NOT NULL default uuid_generate_v4(),
    id_platform uuid NOT NULL,
    jenis_platform varchar(2) NOT NULL,
    tahun int NOT NULL,
    nomor_urut_platform int NOT NULL,
    nomor_urut_selanjutnya int NOT NULL,
    CONSTRAINT td_penomoran_platform_nle_pk PRIMARY KEY (id_penomoran_nle),
    CONSTRAINT td_penomoran_platform_nle_td_platform_fk FOREIGN KEY (id_platform) REFERENCES nsw_nle.td_platform(id_platform)
);

-- Column comments

COMMENT ON COLUMN nsw_nle.td_penomoran_platform_nle.id_penomoran_nle IS 'Primary Key';
COMMENT ON COLUMN nsw_nle.td_penomoran_platform_nle.id_platform IS 'ID Platform dari td_platform';
COMMENT ON COLUMN nsw_nle.td_penomoran_platform_nle.jenis_platform IS 'Jenis Platform, D (Direktori), PL (Platform)';
COMMENT ON COLUMN nsw_nle.td_penomoran_platform_nle.tahun IS 'Tahun daftar platform';
COMMENT ON COLUMN nsw_nle.td_penomoran_platform_nle.nomor_urut_platform IS 'Nomor urut yang dipakai';
COMMENT ON COLUMN nsw_nle.td_penomoran_platform_nle.nomor_urut_selanjutnya IS 'Nomor urut selanjutnya (Nomor urut yang dipakai + 1)';

select * from nsw_nle.td_penomoran_platform_nle as tppn;

select * from nsw_nle.td_platform as tp;


select * from nle_dev.categories_platforms as cp;

{
  "surat_kuasa_requirement": "true",
  "tujuan_penggunaan": "B",
  "jenis_pengguna": "4",
  "jenis_layanan": "[3,6,1]",
  "dial_code": "62",
  "mobile_number": "6281362778132",
  "jenis_trader": "01",
  "jenis_usaha": "Logistik",
  "nama_organisasi": "TEST NLE 1",
  "jenis_npwp": "0",
  "npwp": "992133546043000",
  "jenis_nib": "00",
  "nib": "2811230069272",
  "alamat": "Jl Koja",
  "provinsi": "31",
  "kota_kabupaten": "3172",
  "kode_pos": "12345",
  "nama_lengkap": "AGUNG BUDI SETIAWAN",
  "jabatan": "DIREKTUR UTAMA",
  "jenis_no_identitas": "01",
  "no_identitas": "3172032607800009",
  "email": "rhesa.daiva@gmail.com",
  "no_telp_genggam": "81362778132",
  "surat_kuasa": "http://localhost:3000/assets/upload/surat_kuasa/90a82e49-4d48-40ef-a861-6cc9dccc6a68/1711092135807_surat_kuasa.pdf",
  "disclaimer": "true",
  "nama_platform": "TEST PLATFORM NLE",
  "url_platform": "nle.insw.go.id",
  "login_type": "1",
  "logo_platform": "http://localhost:3000/assets/upload/logo_platform/981672d7-ae67-44a0-8367-f421226cf365/1711092135809_logo_platform.jpeg"
}

select * from nsw_nle.td_layananplatform as tl;

select * from nsw_nle.td_platform where id_user='a3237bae-83b2-da1f-6a23-a6db6e5dbd15';

select * from nsw_nle.td_platform_approval as tpa where id_platform = '2564f4aa-8a7d-0a83-5a24-e2b46d229b6c'

select * from nsw_nle.tr_kategori_berita as tkb;

select * from nsw_nle.td_layananplatform as tl;

select * from nsw_nle.td_berita as tb;


select * from referensi.tr_jenis_layanan_nle as tjln;

select * from referensi.tr_kbli;

SELECT DISTINCT id_jenis_layanan ,jenis_layanan,b.uraian as uraian_kbli
FROM referensi.tr_jenis_layanan_nle
JOIN LATERAL jsonb_array_elements_text(kd_kbli) AS elem(kd) ON elem.kd IN ('49120','52291')
JOIN
    referensi.tr_kbli b ON b.kd_kbli = elem.kd::varchar;


-- get layanan dan uraian kbli berdasarkan jenis layanan
SELECT
    a.jenis_layanan,
    b.uraian
FROM
    referensi.tr_jenis_layanan_nle a 
CROSS JOIN LATERAL jsonb_array_elements_text(a.kd_kbli) AS kbli
JOIN
    referensi.tr_kbli b ON b.kd_kbli = kbli::varchar
where a.id_jenis_layanan = 18;

-- get all platform 
 SELECT
    (SELECT COUNT(id_platform) FROM nsw_nle.td_platform AS tdp) AS total,
    c."data" as sso_link,
    tp.id_platform as id_platform,
    tp.npwp as npwp,
    tp.nib as nib,
    tp.icon as icon,
    tp.uri as uri,
    tp.client_id as client_id,
    tp.nama as name,
    tp.email as email,
    tp.phone_number as phone_number,
    (select concat(x.jenis_platform, x.tahun::varchar, x.nomor_urut_platform_format) from nsw_nle.td_penomoran_platform_nle x where x.id_platform = tp.id_platform) as platform_id,
    tp.id_platform_parent as id_platform_parent,
    tp.wk_rekam as wk_rekam,
    tp.wk_simpan as wk_simpan,
    (
    SELECT
        json_build_object(
        'id', u.id_user,
        'nama', u.full_name,
        'email', u.email ,
        'mobile_number', u.mobile_number ,
        'identity_number', u.id_number
        )
    AS user
    ),
    (
    SELECT
        json_build_object(
        'nib', o.organization_number ,
        'npwp', o.npwp_number ,
        'nama', o.organization_name  ,
        'alamat', o.organization_address
        )
    AS organization
    ),
    (
    SELECT
        json_build_object(
        'redirect_uris', tp.redirect_uri
        )
    AS client
    ),
    (SELECT
        json_agg(
            json_build_object(
                'id_layanan', tl.id_layanan,
                'nama_layanan', tl.nama
            )
        )
    FROM nsw_nle.td_layananplatform AS tlp
    join nsw_nle.tr_layanan AS tl
    on tl.kd_layanan::integer = tlp.id_layanan
    where tlp.id_platform = tp.id_platform
    ) AS kategori_layanan
    FROM nsw_nle.td_platform AS tp
    LEFT JOIN access_tools.users AS u
    ON tp.id_user = u.uuid_user 
    LEFT JOIN access_tools.organizations AS o
    ON tp.id_organization = o.uuid_organization
    LEFT JOIN nsw_sso."Clients" AS c
    ON c.id = tp.client_id
where tp.id_platform = '92efb716-b84e-4394-b629-a571ca8a4f34';

select * from nsw_nle.td_layananplatform tl 
where tl.id_platform = 'b5867a96-3679-484d-9048-22681e536cc2';

select distinct tl.id_layanan,trl.nama 
from nsw_nle.td_layananplatform as tl
join nsw_nle.tr_layanan trl on tl.id_layanan = trl.kd_layanan::integer;

select tl.id_platform from nsw_nle.td_layananplatform as tl
join nsw_nle.td_platform b on tl.id_platform = b.id_platform


select * from nsw_nle.td_platform order by wk_rekam desc;

select * from nsw_nle.td_layananplatform as tl;

select * from nsw_nle.td_penomoran_platform_nle as tppn where id_platform ='a487bc5e-3daf-41be-b676-4cf03a140dfd';
select a.* 
from nsw_nle.td_platform a 
left join nsw_nle.td_layananplatform b
on a.id_platform = b.id_platform 
where 
a.id_platform ='18a23334-97c0-4f18-b60e-6a7819f70cf5';

select * from nsw_nle.td_berita limit 10;

select * from nsw_nle.td_platform where nib='2411230021808';


select * from nsw_nle.td_penomoran_platform_nle as tppn where id_platform = (select x.id_platform from nsw_nle.td_platform x where nib='2411230021808' );

-- clean table platform
delete from nsw_nle.td_platform_approval;
delete from nsw_nle.td_penomoran_platform_nle;
delete from nsw_nle.td_platform;

-- reset user test
delete from nsw_nle.td_platform_approval where id_platform = (select x.id_platform from nsw_nle.td_platform x where nib='2411230021808' ) returning *;
delete from nsw_nle.td_penomoran_platform_nle where id_platform = (select x.id_platform from nsw_nle.td_platform x where nib='2411230021808' ) returning *;
delete from nsw_nle.td_platform where nib='2411230021808' returning *;


SELECT 
  json_agg(jsonb_build_object('id_layanan', tjln.id_jenis_layanan, 'nama_jenis_layanan', tjln.jenis_layanan, 'kbli_layanan', tjln.kd_kbli)) AS layanan_platform,
  tp.* 
FROM 
  nsw_nle.td_platform tp 
LEFT JOIN 
  nsw_nle.td_layananplatform tl ON tp.id_platform = tl.id_platform
LEFT JOIN 
  referensi.tr_jenis_layanan_nle tjln ON tl.id_layanan = tjln.id_jenis_layanan 
WHERE 
  tp.id_platform = '14fbf744-8d97-4a89-8e2d-0816b4fb7ad1'
GROUP BY 
  tp.id_platform;
  
  select * from nsw_nle.td_platform where nib='2411230021808';

  
  select * from nsw_nle.td_layananplatform;

  select * from referensi.tr_jenis_layanan_nle as tjln;
  
select a.id_platform, a.jenis_layanan, a.nama,
json_agg(json_build_object('id_layanan', b.id_jenis_layanan::varchar, 'nama_jenis_layanan', b.jenis_layanan)) as layanan_platform, 
concat(c.jenis_platform, c.tahun::varchar, c.nomor_urut_platform_format) as credentials_id
from nsw_nle.td_platform a
join nsw_nle.td_penomoran_platform_nle as c
  on
a.id_platform = c.id_platform
join referensi.tr_jenis_layanan_nle b
  on
b.id_jenis_layanan::varchar = any(a.jenis_layanan)
where a.id_platform = '14fbf744-8d97-4a89-8e2d-0816b4fb7ad1'
group by a.id_platform, c.jenis_platform, c.tahun, c.nomor_urut_platform_format;

select * from nsw_nle.td_berita as tb;

select a.id_platform, b.jenis_platform, count(b.jenis_platform)
from nsw_nle.td_platform a
join nsw_nle.td_penomoran_platform_nle b
on a.id_platform = b.id_platform
group by 1,2


select * from nsw_nle.td_penomoran_platform_nle as tppn where tppn.id_platform = '1ac4c96c-03a4-4183-8f6b-799e6d3f7fdc';

delete from nsw_nle.td_penomoran_platform_nle where id_platform  = '4ea266e4-4b6b-4535-abb4-e6af1f4ceee5'
 and nomor_urut_platform > 51;
 
SELECT
    (SELECT COUNT(id_platform) FROM nsw_nle.td_platform AS tdp WHERE tdp.nama ILIKE :search) AS total,
    (select concat(tppn.jenis_platform, tppn.nomor_urut_platform_format) from nsw_nle.td_penomoran_platform_nle tppn where tppn.id_platform = tp.id_platform) as nomor_identitas_platform,
    tp.alamat_badan_usaha as alamat, 
    tp.fax_badan_usaha as fax,
    c."data" as sso_link,
    tp.id_platform as id_platform,
    tp.npwp as npwp,
    tp.nib as nib,
    tp.icon as icon,
    tp.uri as uri,
    tp.client_id as client_id,
    tp.nama as name,
    tp.email as email,
    tp.phone_number as phone_number,
    tp.platform_id as platform_id,
    tp.id_platform_parent as id_platform_parent,
    tp.wk_rekam as wk_rekam,
    tp.wk_simpan as wk_simpan,
    tp.jenis_layanan,
    (
    SELECT
        json_build_object(
        'id', u.id_user,
        'nama', u.full_name,
        'email', u.email ,
        'mobile_number', u.mobile_number ,
        'identity_number', u.id_number
        )
    AS user
    ),
    (
    SELECT
        json_build_object(
        'nib', o.organization_number ,
        'npwp', o.npwp_number ,
        'nama', o.organization_name  ,
        'alamat', o.organization_address
        )
    AS organization
    ),
    (
    SELECT
        json_build_object(
        'redirect_uris', tp.redirect_uri
        )
    AS client
    ),
    (SELECT
        json_agg(
            json_build_object(
                'id_layanan', tl.id_layanan,
                'nama_layanan', tl.nama
            )
        )
    FROM nsw_nle.td_layananplatform AS tlp
    join nsw_nle.tr_layanan AS tl
    on tl.kd_layanan::integer = tlp.id_layanan
    where tlp.id_platform = tp.id_platform
    ) AS kategori_layanan
    FROM nsw_nle.td_platform AS tp
    LEFT JOIN access_tools.users AS u
    ON tp.id_user = u.uuid_user
    LEFT JOIN access_tools.organizations AS o
    ON tp.id_organization = o.uuid_organization
    LEFT JOIN nsw_sso."Clients" AS c
    ON c.id = tp.client_id
--   WHERE tp.nama ILIKE :search
--      ORDER BY
--      CASE WHEN :sortBy::varchar = 'nama' THEN tp.nama::varchar
--      WHEN :sortBy::varchar = 'id_platform' THEN tp.id_platform::varchar
--      WHEN :sortBy::varchar = 'platform_id' THEN tp.platform_id::varchar END
--      DESC
      -- LIMIT :limit
      -- OFFSET :offset

    
    select distinct jenis_platform from nsw_nle.td_platform;


-- query sertifikat
select nama, nib, a.jenis_platform as jenis_akses, alamat_badan_usaha, jenis_layanan,
concat(b.jenis_platform,cast(b.tahun as varchar),b.nomor_urut_platform_format) as id_kredensial
from nsw_nle.td_platform a 
join nsw_nle.td_penomoran_platform_nle b on a.id_platform = b.id_platform
where a.id_platform = '92efb716-b84e-4394-b629-a571ca8a4f34';


select a.id_platform,a.email,b.jenis_layanan as uraian_jenis_layanan
from nsw_nle.td_platform a
join referensi.tr_jenis_layanan_nle as b
on b.id_jenis_layanan::varchar = any(a.jenis_layanan);

-- jenis layanan untuk di cetakan
select 
row_number() over() as no_layanan,
b.jenis_layanan as uraian_jenis_layanan
from nsw_nle.td_platform a
join referensi.tr_jenis_layanan_nle as b
on cast(b.id_jenis_layanan as varchar) = any(a.jenis_layanan)
where a.id_platform = 'afc41d41-74a6-453e-9fcb-eb8c35e78a58'

select * from nsw_nle.td_penomoran_platform_nle as tppn;

select * from nsw_nle.td_platform;

select * from referensi.tr_jenis_layanan_nle where id_jenis_layanan in (6,10);

select * from nsw_nle.td_open_bidding;

-- payload email terfix
select 
to_char(a.created_at, 'DD FMMonth YYYY HH24:MI:SS') as order_date,
p2.email as dest_email, p2.nama_badan_usaha as dest_name,
(   select concat(x.jenis_platform,x.tahun::varchar,x.nomor_urut_platform_format)
    from nsw_nle.td_penomoran_platform_nle x
    where x.id_platform = p2.id_platform
) as dest_nle_id,
(
    select string_agg(r.jenis_layanan, ', ') from
    nsw_nle.td_platform x,
    unnest(x.jenis_layanan::int[]) AS jl
    join referensi.tr_jenis_layanan_nle r on jl::int = r.id_jenis_layanan
    where x.id_platform = p2.id_platform
) as dest_jenis_layanan,
concat('OB',to_char(a.created_at::date, 'DDMMYYY' ), b.penomoran_sekarang,'-',jlob.ob_service_code) as email_order_number,
p1.nama as requester_name,
(   select concat(x.jenis_platform,x.tahun::varchar,x.nomor_urut_platform_format)
    from nsw_nle.td_penomoran_platform_nle x
    where x.id_platform = p1.id_platform
) as requester_nle_id,
(select count (x.id_platform) from nsw_nle.td_open_bidding x where x.id_open_bidding = a.id_open_bidding) as order_history,
(
    select string_agg(r.jenis_layanan, ', ') from
    nsw_nle.td_order_number_open_bidding o,
    jsonb_array_elements_text(o.jenis_layanan::jsonb) AS jl
    join referensi.tr_jenis_layanan_nle r on jl::int = r.id_jenis_layanan
    where o.id_open_bidding = '07a14978-7e11-4062-b822-97d48af62a40'
) as open_bidding_order_layanan,
a.uraian_pemesanan_open_bidding as order_notes
from nsw_nle.td_open_bidding a
join nsw_nle.td_order_number_open_bidding b on a.id_open_bidding = b.id_open_bidding
join lateral (select jsonb_array_elements_text(a.jenis_layanan_open_bidding::jsonb )as ob_service_code) as jlob on true
join nsw_nle.td_platform p1 on a.id_platform = p1.id_platform 
join nsw_nle.td_platform p2 on p2.id_platform <> p1.id_platform 
and p2.jenis_layanan::int[] @> ARRAY[jlob.ob_service_code::int]
where a.id_open_bidding = '07a14978-7e11-4062-b822-97d48af62a40'
order  by dest_name

select id_jenis_layanan,jenis_layanan from referensi.tr_jenis_layanan_nle where id_jenis_layanan in (9,11,12,13,15)

select * from nsw_nle.td_order_number_open_bidding;

select * from nsw_nle.td_history_open_bidding as thob;

select * from nsw_nle.td_open_bidding as tob;


with data_email as (
    select 
    a.id_open_bidding,
    to_char(a.created_at, 'DD FMMonth YYYY HH24:MI:SS') as order_date,
    dest.email as dest_email,dest.nama_badan_usaha as dest_name,
    (
        select concat(tppn.jenis_platform,tppn.tahun::varchar,tppn.nomor_urut_platform_format) from nsw_nle.td_penomoran_platform_nle as tppn
        where tppn.id_platform = dest.id_platform
    ) as dest_nle_id,
    string_agg(distinct dest.jenis_layanan,', ' ) as dest_jenis_layanan,
    p1.email as requester_email, p1.nama_badan_usaha as requester_name,
    (
        select concat(tppn.jenis_platform,tppn.tahun::varchar,tppn.nomor_urut_platform_format) from nsw_nle.td_penomoran_platform_nle as tppn
        where tppn.id_platform = p1.id_platform
    ) as requester_nle_id,
    count(a.id_platform) as history_order,
    string_agg(distinct lp1.jenis_layanan,', ') as order_jenis_layanan,
    a.uraian_pemesanan_open_bidding as notes_order
    from nsw_nle.td_open_bidding a
    join nsw_nle.td_platform p1
    on a.id_platform = p1.id_platform
--    cross join lateral json_array_elements_text(a.jenis_layanan_open_bidding) as ob(id_jenis_layanan)
    join referensi.tr_jenis_layanan_nle lp1 
    on lp1.id_jenis_layanan = any(select json_array_elements_text(a.jenis_layanan_open_bidding)::int)
--    on lp1.id_jenis_layanan = ob.id_jenis_layanan::int
    join lateral 
    (
        select p2.email,p2.nama_badan_usaha, p2.id_platform,
        lp2.jenis_layanan,lp2.id_jenis_layanan
        from nsw_nle.td_platform as p2
        join unnest(p2.jenis_layanan::int[]) as dest_jenis_layanan(id) on true
        join referensi.tr_jenis_layanan_nle lp2
        on lp2.id_jenis_layanan = dest_jenis_layanan.id::int
        where lp2.id_jenis_layanan = dest_jenis_layanan.id::int
        and p1.id_platform <> p2.id_platform
    ) as dest on true
    where a.id_open_bidding = '07a14978-7e11-4062-b822-97d48af62a40'
    group by a.id_open_bidding,p1.email,p1.nama_badan_usaha,
    dest.email,dest.nama_badan_usaha,dest.id_platform,
    p1.id_platform
),
email_order_number_cte as (
    select a.id_open_bidding,concat('OB',to_char(a.created_at::date, 'DDMMYYYY'),a.penomoran_sekarang,'-') as email_number,
    a.jenis_layanan
    from nsw_nle.td_order_number_open_bidding a
    where a.id_open_bidding = '07a14978-7e11-4062-b822-97d48af62a40'
)
select a.* from data_email a
join email_order_number_cte b on a.id_open_bidding = b.id_open_bidding; 


SELECT 
    STRING_AGG(r.jenis_layanan, ', ') AS ur_jenis_layanan_agg
FROM 
    nsw_nle.td_order_number_open_bidding o,
    jsonb_array_elements_text(o.jenis_layanan::jsonb) AS jl
JOIN 
    referensi.tr_jenis_layanan_nle r ON jl::int = r.id_jenis_layanan
where o.id_open_bidding = '07a14978-7e11-4062-b822-97d48af62a40';
--    o.jenis_layanan;

SELECT 
    p.id_platform,
    p.jenis_layanan,
    p.email,
    STRING_AGG(r.jenis_layanan, ', ') AS ur_jenis_layanan_agg
FROM 
    nsw_nle.td_platform p,
    unnest(p.jenis_layanan::int[]) AS jl
JOIN 
    referensi.tr_jenis_layanan_nle r ON jl = r.id_jenis_layanan
GROUP BY 
    p.id_platform, 
    p.jenis_layanan;


select tp.id_platform, tp.is_approved 
from nsw_nle.td_platform tp;


select * from nsw_nle.td_dokumen_platform as tdp;  

select id_user from nsw_nle.td_platform;


select
      to_char(a.created_at, 'DD FMMonth YYYY HH24:MI:SS') as order_date,
      p2.email as dest_email, p2.nama_badan_usaha as dest_name,
      ( select concat(x.jenis_platform,x.tahun::varchar,x.nomor_urut_platform_format)
      from nsw_nle.td_penomoran_platform_nle x
      where x.id_platform = p2.id_platform
      ) as dest_nle_id,
      (
      select string_agg(r.jenis_layanan, ', ') from
      nsw_nle.td_platform x,
      unnest(x.jenis_layanan::int[]) AS jl
      join referensi.tr_jenis_layanan_nle r on jl::int = r.id_jenis_layanan
      where x.id_platform = p2.id_platform
      ) as dest_jenis_layanan,
      CONCAT('OB', 
              TO_CHAR(a.created_at::date, 'DDMMYYY'), 
              TRIM(b.penomoran_sekarang),
              '-', 
              jlob.ob_service_code) AS email_order_number,
      p1.nama as requester_name,
      ( select concat(x.jenis_platform,x.tahun::varchar,x.nomor_urut_platform_format)
      from nsw_nle.td_penomoran_platform_nle x
      where x.id_platform = p1.id_platform
      ) as requester_nle_id,
      p1.id_platform as requester_id_platform,
      (select count (x.id_platform) from nsw_nle.td_open_bidding x where x.id_platform = 
        (
            select y.id_platform from nsw_nle.td_open_bidding y where y.id_open_bidding=
            :id_open_bidding
        )
      ) as order_history,
      (
      select string_agg(r.jenis_layanan, ', ') from
      nsw_nle.td_order_number_open_bidding o,
      jsonb_array_elements_text(o.jenis_layanan::jsonb) AS jl
      join referensi.tr_jenis_layanan_nle r on jl::int = r.id_jenis_layanan
      where o.id_open_bidding = a.id_open_bidding
      ) as open_bidding_order_layanan,
      a.uraian_pemesanan_open_bidding as order_notes
      from nsw_nle.td_open_bidding a
      join nsw_nle.td_order_number_open_bidding b on a.id_open_bidding = b.id_open_bidding
      join lateral (select jsonb_array_elements_text(a.jenis_layanan_open_bidding::jsonb )as
      ob_service_code) as jlob on true
      join nsw_nle.td_platform p1 on a.id_platform = p1.id_platform
      join nsw_nle.td_platform p2 on p2.id_platform <> p1.id_platform
      and p2.jenis_layanan::int[] @> ARRAY[jlob.ob_service_code::int]
      where a.id_open_bidding = 'ec4c0217-c4f3-459d-871b-4c4d253b9701'
      order by dest_name;


  
  select * from nsw_nle.td_penomoran_platform_nle as tppn;
  
  select * from access_tools.users where username='K1E5GC'
  
  select * from nsw_nle.td_platform where id_user='a3237bae-83b2-da1f-6a23-a6db6e5dbd15' and id_platform <> '8a88e9c3-b066-4b59-aac5-c8b8a8e33427'
  
  
  select a.id_platform ,a.id_user as id_user_platform,b.username,c.id_approval_platform,c.user_approval  from nsw_nle.td_platform a 
  left join access_tools.users b on a.id_user = b.uuid_user
  left join nsw_nle.td_platform_approval c on a.id_platform = c.id_platform
  
  select a.id_platform,b.id_approval_platform  from nsw_nle.td_platform a 
  join nsw_nle.td_platform_approval b on a.id_platform = b.id_platform
  join access_tools.users c on a.id_user = c.uuid_user 
  where c.username='6I7GFP';
  
  select * from nsw_nle.td_platform_approval where id_platform ='617ef465-c3c5-462c-8e82-eb785782fbc9';
  
  select * from nsw_nle.td_open_bidding as tob order by created_at desc;
  
  
  select * from referensi.tr_jenis_layanan_nle;