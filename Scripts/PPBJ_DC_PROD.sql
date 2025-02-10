select * from nsw_ppbj.td_kontrak 

select * from nsw_ppbj.td_kontrak th  where th.no_aju  = '3000089B01D8E-011';

select * from nsw_ppbj.td_header th where no_aju like '3000089C21E6F%';


select nomor_identitas_lawan_transaksi,length(nomor_identitas_lawan_transaksi)  from nsw_ppbj.td_header th where no_aju ='300008F1F67DD';



select no_aju,ur_barang,nilai_barang_valuta,nilai_barang_rupiah,nilai_dpp,nilai_ppn_terutang,nilai_ppn_fasilitas
from nsw_ppbj.td_rincian where no_aju ='3000089CF4119' group by 1,2,3,4,5,6,7;


select npwp_kpbpb,nm_perusahaan_kpbpb  from nsw_ppbj.td_header a where a.nm_perusahaan_kpbpb ilike '%badan%';

select a.npwp_kpbpb,a.no_aju,b.no_ppbj,b.tgl_ppbj,a.kd_status  from nsw_ppbj.td_header a 
join nsw_ppbj.td_kontrak b on a.no_aju =b.no_aju 
where a.npwp_kpbpb ='001337542225000' and b.no_ppbj not like '020%'
and a.kd_status::integer in (20,30,50) order by tgl_ppbj desc;


select b.npwp_kpbpb as npwp_ftz, b.nm_perusahaan_kpbpb  as nama_perusahaan_ftz,
a.no_aju,kd_jns_barang,hs_code,ur_barang_btki ,ur_barang,nilai_barang_valuta ,
kd_valuta_nilai ,nilai_dpp,nilai_barang_rupiah,nilai_ppn_terutang ,jenis_transaksi ,satuan_barang , b.npwp_kpbpb
from nsw_ppbj.td_rincian a
join nsw_ppbj.td_header b on a.no_aju  = b.no_aju 
join nsw_ppbj.td_kontrak c on b.no_aju  = c.no_aju 
where b.npwp_kpbpb = '001337542225000' and c.no_ppbj not like '020%'
and b.kd_status::integer in (20,30,50) order by tgl_ppbj desc;

select distinct on(a.npwp_kpbpb) npwp_kpbpb, a.nm_perusahaan_kpbpb,c.ur_lokasi_kawasan_bebas
from nsw_ppbj.td_header a
join nsw_ppbj.td_kontrak b on a.no_aju  = b.no_aju
left join referensi.tr_lokasi_kawasan_bebas c 
on a.lokasi_kpbpb::integer  = c.id_kawasan_bebas::integer
where b.tgl_ppbj::date between '01-01-2023' and '12-31-2023';


select * from referensi.tr_lokasi_kawasan_bebas tlkb;

select * from nsw_ppbj.td_log_integrasi_ppbj tlip where created_at::date between '2024-01-01' and '2024-01-22' order by created_at::date desc;


select * from nsw_ppbj.td_rincian where no_aju like '30000899281D1%'

select no_aju from nsw_ppbj.td_header where no_aju ='3000083416541';

select * from referensi.tr_kpp where nama_kantor_pajak ilike '%bun';


select * from nsw_ppbj.td_proses as tp;

select kd_kantor_pajak,nama_kantor_pajak,alamat_kantor_pajak  from referensi.tr_kpp;


select * from nsw_ppbj.td_header limit 1;


with master as (select a.no_aju, b.no_ppbj, b.tgl_ppbj, npwp_kpbpb as npwp_ftz , nm_perusahaan_kpbpb as nama_perusahaan_ftz,
(select tp.ur_proses from nsw_ppbj.tr_proses as tp where tp.kd_proses = a.kd_status) as uraian_status
from nsw_ppbj.td_header as a
join nsw_ppbj.td_kontrak b on
a.no_aju = b.no_aju
and a.kd_status::integer between 20 and 50
and show = 'true' and extract (year from b.tgl_ppbj)='2023'  )
select 
a.no_aju, a.npwp_ftz, a.nama_perusahaan_ftz, a.no_ppbj,a.tgl_ppbj,uraian_status,
sum(b.nilai_dpp) as total_dpp, sum(b.nilai_ppn_terutang) as total_ppn_terutang, count(b.no_aju) as total_barang
from master as a
join nsw_ppbj.td_rincian b on
a.no_aju = b.no_aju
group by a.no_aju, a.npwp_ftz, a.nama_perusahaan_ftz,a.no_ppbj,a.tgl_ppbj,uraian_status
order by tgl_ppbj asc;


select * from nsw_ppbj.td_header where no_aju ='300008F1F1DCF'

select * from nsw_ppbj.td_header where no_aju like '30000835E8818%';




select a.no_aju, sum(b.nilai_dpp) as nilai_dpp, sum(b.nilai_ppn_terutang) as ppn_terutang,(select x.payload_send->'kontrakPenyerahan'->>'dpp'
from nsw_ppbj.td_log_integrasi_ppbj x
where x.no_aju = '300008926C7CE') as dpp_log,
(select x.payload_send->'kontrakPenyerahan'->>'ppnTerhutang'
from nsw_ppbj.td_log_integrasi_ppbj x
where x.no_aju = '300008926C7CE') as ppn_terutang_log
from nsw_ppbj.td_header as a
join nsw_ppbj.td_rincian b on
a.no_aju = b.no_aju
where a.no_aju = '300008926C7CE'
group by a.no_aju


select( select x.ur_lokasi_kawasan_bebas
from referensi.tr_lokasi_kawasan_bebas x
where x.id_kawasan_bebas = a.lokasi_kpbpb::integer), sum(a.lokasi_kpbpb::integer)
from nsw_ppbj.td_header a
join nsw_ppbj.td_kontrak b on
a.no_aju = b.no_aju
where b.tgl_ppbj::date between '2024-01-01' and '2024-02-28'
and a.show = 'true'
and a.kd_status::integer between 20 and 50
group by a.lokasi_kpbpb


select a.no_aju, c.show,c.kd_status, sum(a.nilai_barang_rupiah) as nilai_transaksi, sum(a.nilai_dpp) as total_dpp,
floor (sum(a.nilai_barang_rupiah)) as nilai_transaksi_floored,
floor(sum(a.nilai_dpp)) as nilai_dpp_floored,
(select x.ur_lokasi_kawasan_bebas
from referensi.tr_lokasi_kawasan_bebas x
where x.id_kawasan_bebas = c.lokasi_kpbpb::integer) as ur_lokasi_kpbpb
from nsw_ppbj.td_rincian a
join nsw_ppbj.td_kontrak b on
a.no_aju = b.no_aju
join nsw_ppbj.td_header c on
a.no_aju = c.no_aju
join nsw_ppbj.td_kontrak d on a.no_aju = c.no_aju
where b.tgl_ppbj::date between '2023-01-01' and '2023-12-31'
and c."show" = 'true'
and c.kd_status::integer between 20 and 50
and c.npwp_kpbpb <> '027681030529000'
group by ur_lokasi_kpbpb,a.no_aju,c.show,c.kd_status 



select a.no_aju,b.tgl_ppbj,a.kd_status
from nsw_ppbj.td_header a
join nsw_ppbj.td_kontrak b on a.no_aju = b.no_aju
where a.no_aju like '%020' and extract(year from b.tgl_ppbj) = '2024';



select * from nsw_ppbj.td_header where nm_perusahaan_kpbpb ilike '%dasindo';

select * from nsw_ppbj.td_log_integrasi_ppbj as tlip where no_aju ='3000083BC3713';

select * from nsw_ppbj.td_log_integrasi_ppbj as tlip where djp_response::text ilike '%reset%';


select a.no_aju,show,kd_status from nsw_ppbj.td_header a where no_aju  like '300008F2C880E%';


select npwp_kpbpb,nm_perusahaan_kpbpb, no_aju, kd_status from nsw_ppbj.td_header where kd_status = '90';


select * from nsw_ppbj.td_kontrak where no_ppbj  = '00023081393136';

select * from nsw_ppbj.td_log_integrasi_ppbj as tlip where no_aju ='300008F2C8B11';

select * from nsw_ppbj.td_faktur where no_aju='300008F2C60AE';

select * from nsw_ppbj.td_detail_faktur as tdf where tdf.id_faktur ='400339'

select no_aju, kd_status from nsw_ppbj.td_header where no_aju ='300008F2CAF6F';

 select a.no_aju,b.no_ppbj,b.tgl_ppbj,a.kd_status
    from nsw_ppbj.td_header a 
    join nsw_ppbj.td_kontrak b
    on a.no_aju = b.no_aju 
    and a.no_aju = '300008F2C89A8';

select count(*) as total_duplikat
    from nsw_ppbj.td_log_integrasi_ppbj as tlip
    where no_aju = '300008F2CAF6F'
    and (djp_response::text ilike '%duplikat%' or djp_response::text ilike '%sukses%')


--with master as ( )
----update nsw_ppbj.td_header set kd_status = '20' where no_aju in (select x.no_aju from master x) returning no_aju,kd_status;
--select * from master;

select a.no_aju,a.kd_status from nsw_ppbj.td_header a
join nsw_ppbj.td_kontrak b on a.no_aju  = b.no_aju
where a.kd_status::integer = 10
and b.tgl_ppbj = '2024-02-06'


select a.no_aju,a.tgl_ppbj,b.no_faktur,b.tanggal_faktur from nsw_ppbj.td_kontrak a
join nsw_ppbj.td_faktur b on a.no_aju = b.no_aju
join nsw_ppbj.td_header c on a.no_aju = c.no_aju 
where c.kd_status = '20'

select a.no_aju,a.no_ppbj,a.tgl_ppbj from nsw_ppbj.td_kontrak a 
join nsw_ppbj.td_header b on a.no_aju = b.no_aju
where b.kd_status  = '10' and a.no_ppbj <> ''
and b.npwp_kpbpb <> '027681030529000'
and a.tgl_ppbj::date = '2024-02-06';

with master as (select a.no_aju,a.no_ppbj,a.tgl_ppbj from nsw_ppbj.td_kontrak a 
join nsw_ppbj.td_header b on a.no_aju = b.no_aju
where b.kd_status  = '10' and a.no_ppbj <> ''
and b.npwp_kpbpb <> '027681030529000'
and a.tgl_ppbj::date = '2024-02-07')
update nsw_ppbj.td_header set kd_status = '20' where no_aju in (select x.no_aju from master x) returning no_aju,kd_status; 


update nsw_ppbj.td_header set kd_status  = '10' where no_aju='300008F2C880E' returning no_aju,kd_status;

select a.no_ppbj, b.npwp_kpbpb, b.nm_perusahaan_lawan_transaksi,b.nomor_identitas_lawan_transaksi,length(b.nomor_identitas_lawan_transaksi) as length 
from nsw_ppbj.td_kontrak a
join nsw_ppbj.td_header as b on a.no_aju = b.no_aju
where a.no_ppbj  in ('00024021521852', '00024021521887', '00024021521887', '00024021521852');

SELECT * FROM nsw_ppbj.td_log_integrasi_ppbj as tlip where no_aju ='300008929876F';

select no_aju from nsw_ppbj.td_kontrak where no_ppbj= '00023011269804';

select * from nsw_ppbj.td_rincian where no_aju ='3000083404FCC';

select a.no_aju,b.no_faktur,b.tanggal_faktur,c.kd_status, b.payload_faktur
from nsw_ppbj.td_kontrak a
left join nsw_ppbj.td_faktur b on a.no_aju = b.no_aju
join nsw_ppbj.td_header c on a.no_aju = c.no_aju
where a.no_ppbj = '00023081393136';

select * from nsw_ppbj.td_header where no_aju ='3000089B01D8E-011'

select a.no_aju,a.no_ppbj,a.tgl_ppbj,c.wk_proses,count(c.kd_proses) as jumlah,c.kd_proses
from nsw_ppbj.td_kontrak a
join nsw_ppbj.td_header b on a.no_aju = b.no_aju
join nsw_ppbj.td_proses c on a.no_aju = c.no_aju 
where a.no_ppbj in ('00023011269804', '00023011262546', '00023061353593', '00023031315283', '00023111457463', '00023021293111', '00023021283726', '00023011260909', '00023061354850', '00023031312444', '00023011259283', '00023093001791', '00023091430789', '00023051342127', '00023051340208', '00023101448938', '00023091419847', '00023101441958', '00023031304028', '00023031299570', '00023021285622', '00023031306059', '00023101444293', '00022121258141', '00023021290635', '00023021278137', '00022121254593', '00023021285357', '00023101436834', '00023071375275', '00023071373495', '00023051335558', '00023021289651', '00023022002346', '00022121243485', '00023021291667', '00022121253136', '00023121482762', '00023111468426', '00023031302968', '00023071371655', '00023051329865', '00023111468840', '00023091433223', '00023101450938', '00023061352356', '00023041320885', '00023091430359', '00023071383500', '00023101451014', '00023071370943', '00023031304958', '00023081394176', '00023071368651', '00023033001133', '00023051329170', '00023051334771', '00023011265877', '00023021284221', '00023091419844', '00022121246563', '00023051331263', '00023111459894', '00023091433080', '00023041322088', '00023021290630', '00023093001806', '00023051329581', '01123071370941', '00023061358810', '00023061355650', '00023081389991', '00022111232580', '00022121241436', '00023101449427', '00023031303369', '00023091424168', '00023061356398', '00023041327239', '00023101438120', '00023061363353', '01122111240223', '00023101443931', '00023071383000', '00023041326655', '00022121242720', '00023031304793', '01123091427673', '00022121244591', '00023091431462', '00023041319631', '00023012002147', '00023061353456', '01122101213159', '00023021288768', '00023051332783', '01123011272372', '00022091189701', '00022112001768', '00023062003045', '00023031300599', '00023021290559', '00022081179421', '00023011260065', '00023011262638', '00022101222504', '01122121256099', '00022081173190', '00023031305097', '00023072003200', '00023011271924', '00023021287888', '00022071162838', '01122111237657', '00022061118635', '01323033001148', '00022052000460', '00022061121264', '01122061131741', '00023011262991', '00022111225706', '00022021008488')
and c.kd_proses = '20'
group by 1,2,3,4,6


select * from nsw_ppbj.td_log_integrasi_ppbj where no_aju='3000089B01D8E-011';


select * from nsw_ppbj.td_endorsement order by created_at desc limit 1;

select a.no_aju,b.tgl_ppbj,
npwp_kpbpb,nm_perusahaan_kpbpb from nsw_ppbj.td_header a 
join nsw_ppbj.td_kontrak b on a.no_aju  = b.no_aju 
where a.nm_perusahaan_kpbpb = 'TOYOTA-ASTRA MOTOR';

select no_aju,kd_status,show
from nsw_ppbj.td_header as th 
where no_aju like '3000089D2990D%';


with master as (SELECT a.no_aju,a.no_ppbj,b.kd_status,a.kd_objek_transaksi, a.kd_jns_transaksi,
a.tgl_ppbj,b.npwp_kpbpb as npwp_ftz,b.nomor_identitas_lawan_transaksi,
b.nm_perusahaan_kpbpb as nm_ftz,b.nm_perusahaan_lawan_transaksi,
sum(c.nilai_dpp) as  total_dpp, sum(c.nilai_ppn_terutang) as total_ppn_terutang,
sum(c.nilai_ppnbm_terutang) as total_ppnbm_terutang
FROM nsw_ppbj.td_kontrak a 
join nsw_ppbj.td_header b on a.no_aju = b.no_aju
left join nsw_ppbj.td_rincian c on a.no_aju = c.no_aju
left join nsw_ppbj.td_informasi_terkait d on a.no_aju = d.no_aju
WHERE extract(YEAR FROM a.tgl_ppbj) = '2023'
and b.kd_status <> '00'
and b.kd_status in ('20','30','50','90')
and b."show" = 'true'
group by 1,2,3,4,5,6,7,8,9,10
order by tgl_ppbj asc)
select * from master where no_aju='3000089D2C15C';


SELECT EXTRACT(MONTH FROM TIMESTAMP '2016-01-31 13:30:15') m;

rollback;

select * from nsw_ppbj.td_log_integrasi_ppbj as tlip where no_aju ='300008340779F';

select *
    from nsw_ppbj.td_log_integrasi_ppbj
    where no_aju = 
    and (djp_response -> 'data' ->> 'kode' = 'A01'
    or djp_response ->'data' ->> 'kode' = 'A02') limit 1;

select * from nsw_ppbj.tr_proses;

select no_aju , kd_status from nsw_ppbj.td_header where no_aju ='300008340779F';

select * from nsw_ppbj.td_


select * from nsw_ppbj.tr_objek_transaksi as tot;

with master as (SELECT a.no_aju,a.no_ppbj,b.kd_status,a.kd_objek_transaksi, a.kd_jns_transaksi,
a.tgl_ppbj,b.npwp_kpbpb as npwp_ftz,b.nomor_identitas_lawan_transaksi,
b.nm_perusahaan_kpbpb as nm_ftz,b.nm_perusahaan_lawan_transaksi,
sum(c.nilai_dpp) as  total_dpp, sum(c.nilai_ppn_terutang) as total_ppn_terutang,
sum(c.nilai_ppnbm_terutang) as total_ppnbm_terutang
FROM nsw_ppbj.td_kontrak a
join nsw_ppbj.td_header b on a.no_aju = b.no_aju
left join nsw_ppbj.td_rincian c on a.no_aju = c.no_aju
left join nsw_ppbj.td_informasi_terkait d on a.no_aju = d.no_aju
WHERE extract(YEAR FROM a.tgl_ppbj) = '2022'
and b.kd_status <> '00'
and b.kd_status in ('20','30','50','90')
and b."show" = 'true'
and b.npwp_kpbpb <> '027681030529000'
group by 1,2,3,4,5,6,7,8,9,10
order by tgl_ppbj asc)
select no_aju,no_ppbj::text,kd_status,tgl_ppbj,npwp_ftz,nomor_identitas_lawan_transaksi,nm_ftz,nm_perusahaan_lawan_transaksi,
total_dpp, total_ppn_terutang, total_ppnbm_terutang,kd_objek_transaksi,kd_jns_transaksi,
(select x.payload_send from nsw_ppbj.td_log_integrasi_ppbj as x where x.no_aju = a.no_aju limit 1
) as payload_send
from master a;

with master as (SELECT a.no_aju,a.no_ppbj,b.kd_status,a.kd_objek_transaksi, a.kd_jns_transaksi,
a.tgl_ppbj,b.npwp_kpbpb as npwp_ftz,b.nomor_identitas_lawan_transaksi,
b.nm_perusahaan_kpbpb as nm_ftz,b.nm_perusahaan_lawan_transaksi,
sum(c.nilai_dpp) as  total_dpp, sum(c.nilai_ppn_terutang) as total_ppn_terutang,
sum(c.nilai_ppnbm_terutang) as total_ppnbm_terutang,
(select x.payload_send from nsw_ppbj.td_log_integrasi_ppbj as x where x.no_aju = a.no_aju limit 1
) as payload_send
FROM nsw_ppbj.td_kontrak a
join nsw_ppbj.td_header b on a.no_aju = b.no_aju
left join nsw_ppbj.td_rincian c on a.no_aju = c.no_aju
left join nsw_ppbj.td_informasi_terkait d on a.no_aju = d.no_aju
WHERE extract(YEAR FROM a.tgl_ppbj) = '2022'
and extract(month FROM a.tgl_ppbj) = '6'
and b.kd_status <> '00'
and b.kd_status in ('20','30','50','90')
and b."show" = 'true'
and b.npwp_kpbpb <> '027681030529000'
group by 1,2,3,4,5,6,7,8,9,10
order by tgl_ppbj asc)
select * from master;

with master as (SELECT a.no_aju,a.no_ppbj,b.kd_status,a.kd_objek_transaksi, a.kd_jns_transaksi,
a.tgl_ppbj,b.npwp_kpbpb as npwp_ftz,b.nomor_identitas_lawan_transaksi,
b.nm_perusahaan_kpbpb as nm_ftz,b.nm_perusahaan_lawan_transaksi,
sum(c.nilai_dpp) as  total_dpp, sum(c.nilai_ppn_terutang) as total_ppn_terutang,
sum(c.nilai_ppnbm_terutang) as total_ppnbm_terutang
FROM nsw_ppbj.td_kontrak a
join nsw_ppbj.td_header b on a.no_aju = b.no_aju
left join nsw_ppbj.td_rincian c on a.no_aju = c.no_aju
left join nsw_ppbj.td_informasi_terkait d on a.no_aju = d.no_aju
WHERE extract(YEAR FROM a.tgl_ppbj) = '2022'
and extract(MONTH FROM a.tgl_ppbj) = '6'
and b.kd_status <> '00'
and b.kd_status in ('20','30','50','90')
and b."show" = 'true'
and b.npwp_kpbpb <> '027681030529000'
group by 1,2,3,4,5,6,7,8,9,10
order by tgl_ppbj asc)
select no_aju,no_ppbj::text,kd_status,tgl_ppbj,npwp_ftz,nomor_identitas_lawan_transaksi,nm_ftz,nm_perusahaan_lawan_transaksi,
total_dpp, total_ppn_terutang, total_ppnbm_terutang,kd_objek_transaksi,kd_jns_transaksi
from master a;


select * from nsw_ppbj.td_log_integrasi_ppbj as tlip  where no_aju='300008F2F97F5';

select * from nsw_ppbj.td_informasi_terkait as trit where no_aju='300008F2F97F5';


select * from nsw_ppbj.td_endorsement order by created_at desc limit 10;


select * from nsw_ppbj.td_penomoran_v2 limit 10;

select * from nsw_ppbj.td_kontrak as tk where no_aju='300008F4E1CC7';

select * from nsw_ppbj.td_header where no_aju = 'bu'


-- cek aju belum terkirim
select json_agg(json_build_object('no_aju',no_aju))  from nsw_ppbj.td_header where "show" = 'true'
-- bukan npwp dummy test
and npwp_kpbpb <> '027681030529000'
-- status proses pengiriman
and kd_status::integer = 10
-- wk rekam datanya <= 30 hari
and abs(extract(day from now()::timestamp - wk_rekam::timestamp)) <= 1;

with master_toyota as (select a.no_aju,b.no_ppbj,b.tgl_ppbj,a.wk_rekam, npwp_kpbpb,nm_perusahaan_lawan_transaksi,kd_status 
from nsw_ppbj.td_header a
join nsw_ppbj.td_kontrak b
on a.no_aju = b.no_aju
where nm_perusahaan_lawan_transaksi like 'TOYOTA%' and kd_status = '10'
and tgl_ppbj::varchar like '2024%')
select json_agg(json_build_object('no_aju',no_aju))  from master_toyota ;

select abs(extract(day from now()::timestamp - '2024-04-01'::timestamp));

select * from 


update nsw_ppbj.td_header set kd_status = '00' where no_aju='300008F4E66FE' returning no_aju, kd_status;


select * from nsw_ppbj.td_header where no_aju like '300008F3C1914%';

select * from nsw_ppbj.td_header where no_aju='300008F59B31E';


select
          ROW_NUMBER () OVER (order by n.id_header desc)::integer as no_urut,
          n.id_header,
          n.no_aju, 
          td.no_ppbj,
          td.tgl_ppbj,
          td.no_kontrak,
          td.tgl_kontrak,
          n.jns_identitas_lawan_transaksi,
          n.nomor_identitas_lawan_transaksi,
          n.referensi_ppbj,
          n.nm_perusahaan_lawan_transaksi,
          td.kd_objek_transaksi,
          td.jenis_pajak,
          n.kd_status,
          n.show,
          tp.kd_proses,
          tp.ur_proses,
          n.turunan_dari,
          td.pembetulan_ke,
          x.no_aju as "billing",
          n.path_file
          from nsw_ppbj.td_header n LEFT JOIN nsw_ppbj.td_kontrak td on td.no_aju = n.no_aju 
          LEFT JOIN nsw_ppbj.tr_proses tp on tp.kd_proses = n.kd_status
          FULL JOIN nsw_ppbj.td_bpn_aju x on x.no_aju = n.no_aju
          where npwp_kpbpb ='015397102215001';
      
      
select * from nsw_ppbj.td_kontrak where no_aju='300008F6A2C5D';


select payload_send::jsonb->'ppbj'->>'noPPBJ' from nsw_ppbj.td_log_integrasi_ppbj as tlip limit 10; 

select * from nsw_ppbj.td_log_integrasi_ppbj where payload_send::jsonb->'ppbj'->>'noPPBJ' like '%24051589802';


select * from nsw_ppbj.td_log_integrasi_ppbj tlip order by id_log desc limit 1

select * from nsw_ppbj.td_header order by wk_rekam desc limit 10;

-- Data coretax
select row_to_json(dataPPBJ) as ppbj
    from (
             select (left(b.no_ppbj, 3))::integer                                                          as "kode",
                    a.no_aju                                                                         as "noAju",
                    b.pembetulan_ke::varchar                                                         as "noSeri",
                    right(b.no_ppbj, 11)                                                             as "noPPBJ",
                    b.tgl_ppbj                                                                       as "tglPPBJ",
                    (select json_agg(refPPBJ)
                     from (select right(a.referensi_ppbj, 10) as no, b.tgl_ppbj as tgl) refPPBJ)     as "refPPBJ",
                    right(b.kd_objek_transaksi, 1)                                                   as "objekTransaksi",
                    right(b.kd_jns_transaksi, 1)                                                     as "jnsTransaksi",
                    right(b.kd_asal, 1)                                                              as "asalBarang",
                    case when (right(b.kd_tujuan, 1)) = '-' then '' else right(b.kd_tujuan, 1) end   as "tujBarang",
                    case
                        when b.kd_bkpb_berwujud_tidak_ppn = '-' then ''
                        else b.kd_bkpb_berwujud_tidak_ppn end                                        as "bkpNonPPN",
                    (select row_to_json(pengusahaKPBPB)
                     from (select a.nm_perusahaan_kpbpb           as nama,
                                  a.npwp_kpbpb                    as npwp,
                                  a.alamat_perusahaan_kpbpb       as alamat,
                                  left(a.kpp_perusahaan_kpbpb, 3) as "kppTerdaftar") pengusahaKPBPB) as "pengusahaKPBPB",
                    (select row_to_json(lawanTransaksi)
                     from (select a.nm_perusahaan_lawan_transaksi as nama,
                                  (select json_agg(id)
                                   from (
                                            select case when a.jns_identitas_lawan_transaksi = 'np' then '5' else '3' end as "jnsID",
                                                   a.nomor_identitas_lawan_transaksi                                     as no
                                        ) id)                     as id,
                                  left(a.kpp_lawan_transaksi, 3)  as "kppTerdaftar") lawanTransaksi) as "lawanTransaksi",
                    (select row_to_json(kontrakPenyerahan)
                     from (
                              select b.no_kontrak                             as "noKontrak",
                                     b.tgl_kontrak                            as "tglKontrak",
                                     b.nilai_kontrak                          as "nilaiKontrak",
                                     upper(b.valuta_kontrak)                  as valuta,
                                     (select json_agg(rincian)
                                      from (
                                               select case
                                                          when d.kd_jns_barang = 'Bahan Baku' then '1'
                                                          when d.kd_jns_barang = 'Barang Modal' then '2'
                                                          when d.kd_jns_barang = 'Barang Konsumsi' then '3'
                                                          end                                                             as "jnsBarang",
                                                      d.hs_code                                                           as "kdHS",
                                                      d.ur_barang                                                         as "urBarang",
                                                      d.nilai_barang_rupiah::varchar                                              as "nilaiTransaksi",
                                                      round(d.jumlah_barang::numeric, 2)                                  as "jmlBarang",
                                                      round(d.nilai_barang_rupiah::numeric / d.jumlah_barang::numeric, 2) as "hrgSatuan",
                                                      split_part(d.satuan_barang, '-', 1)                                 as satuan
                                               from nsw_ppbj.td_rincian d
                                               where d.no_aju = a.no_aju
                                           ) rincian)                         as rincian,
                                     (select sum(x.nilai_barang_rupiah)
                                      from nsw_ppbj.td_rincian x
                                      where x.no_aju = a.no_aju)              as "ttlNilaiTransaksi",
                                     (select case
                                                 when floor(sum(x.nilai_dpp)) <> ceiling(sum(x.nilai_dpp))
                                                     then (floor(sum(x.nilai_dpp::numeric)))::varchar
                                                 else (floor(sum(x.nilai_dpp::numeric)))::varchar end
                                      from nsw_ppbj.td_rincian x
                                      where x.no_aju = a.no_aju)              as "dasarPengenaanPajak",
                                     case
                                         when (select sum(x.uang_muka::numeric)
                                               from nsw_ppbj.td_rincian x
                                               where x.no_aju = a.no_aju) is null then '0'
                                         else (select case
                                                          when floor(sum(x.uang_muka)) <> ceiling(sum(x.uang_muka::numeric))
                                                              then (sum(x.uang_muka))::varchar
                                                          else (floor(sum(x.uang_muka::numeric)))::varchar end
                                               from nsw_ppbj.td_rincian x
                                               where x.no_aju = a.no_aju) end as "uangMuka",
                                     (select floor(sum(x.nilai_ppn_terutang))
                                      from nsw_ppbj.td_rincian x
                                      where x.no_aju = a.no_aju)              as "ppnTerhutang",
                                     (select case
                                                 when (sum(x.nilai_ppn_terutang)) = 0 then null
                                                 else floor(sum(x.nilai_ppn_fasilitas)) end
                                      from nsw_ppbj.td_rincian x
                                      where x.no_aju = a.no_aju)              as "ppnFasilitas",
                                     (select floor(sum(x.nilai_ppnbm_terutang))
                                      from nsw_ppbj.td_rincian x
                                      where x.no_aju = a.no_aju)              as "ppnbmTerhutang",
                                     (select case
                                                 when (sum(x.nilai_ppnbm_fasilitas)) = null then null
                                                 else floor(sum(x.nilai_ppnbm_terutang)) end
                                      from nsw_ppbj.td_rincian x
                                      where x.no_aju = a.no_aju)              as "ppnbmFasilitas"
                          ) kontrakPenyerahan)                                                       as "kontrakPenyerahan",
                    case
                        when (select count(z.id_informasi)
                              from nsw_ppbj.td_informasi_terkait z
                              where z.no_aju = a.no_aju) > 0 then (
                            select json_agg(infoterkait)
                            from (
                                     select g.no_dokumen_pabean                                                     as "noDokPabean",
                                            case when g.tgl_dokumen::varchar is null then '' else g.tgl_dokumen::varchar  end                                                      as "tglDokPabean",
                                            (select row_to_json(ntpn)
                                             from (
                                                      select concat('', null) as no,
                                                             concat('', null) as tgl,
                                                             concat('', null) as nilai
                                                  ) ntpn)                                                           as "ntpnPelunasan",
                                            (select row_to_json(rencana)
                                             from (select g.wk_mulai_rencana_jangka_waktu   as "tglAwal",
                                                          g.wk_selesai_rencana_jangka_waktu as "tglAkhir") rencana) as "rencPenggunaanBarang",
                                            g.tujuan_penggunaan_barang                                              as "tujPenggunaanBarang",
                                            (select json_agg(rincianbkp)
                                             from (
                                                      select case when h.kd_jenis_barang = 'Bahan Baku' then '1'
                                                      when h.kd_jenis_barang = 'Barang Modal' then '2'
                                                      when h.kd_jenis_barang = 'Barang Konsumsi' then '3' end     as "jnsBarang",
                                                             h.hs_code             as "kdHS",
                                                             h.ur_barang           as "urBarang",
                                                             h.nilai_barang_rupiah as "nilaiTransaksi"
                                                      from nsw_ppbj.td_rincian_informasi_terkait h
                                                      where a.no_aju = h.no_aju
                                                  ) rincianbkp)                                                     as "rincianBKP",
                                            (select sum(h.nilai_barang_rupiah)
                                             from nsw_ppbj.td_rincian_informasi_terkait h
                                             where a.no_aju = h.no_aju)                                             as "ttlNilaiTransaksi"
                                     from nsw_ppbj.td_informasi_terkait g
                                     where a.no_aju = g.no_aju
                                 ) infoterkait
                        )
                        end                                                                          as "infoBKP",
                    (select json_agg(rekening)
                     from (
                              select f.nomor_rekening                                                          as "noRek",
                                     f.nama_pemilik_rekening                                                   as nama,
                                    f.kd_bank as "nmBank"
                              from nsw_ppbj.td_rekening f
                              where f.no_aju = a.no_aju
                          ) rekening)                                                                as "rekPembayaran",
                    (select row_to_json(ttd)
                     from (
                              select a.nm_penandatangan            as nama,
                                     a.jabatan_penandatangan       as jabatan,
                                     left(a.kota_penandatangan, 3) as kota,
                                     to_char(a.wk_rekam,'yyyy-mm-dd')                 as tgl
                          ) ttd)                                                                     as "penandatangan"
             from nsw_ppbj.td_header a
                    left  join nsw_ppbj.td_kontrak b on a.no_aju = b.no_aju
             where a.no_aju = $1
         ) dataPPBJ;     

        
        select * from nsw_ppbj.td_header where no_aju=$1;
       
       
select * from nsw_ppbj.td_log_integrasi_ppbj 
--where no_aju is null 
--and created_at::date between '2025-01-01' and now()::date
order by id_log desc;



select (9709651.5223 * 494.683)


update nsw_ppbj.td_header set kd_status='20' where no_aju='3000095139AF8'

select * from nsw_ppbj.td_proses where no_aju='3000095139AF8'

