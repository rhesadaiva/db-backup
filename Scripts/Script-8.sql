select * from intip_bhp_kalbagsel.td_user;


select * from intip_bhp_kalbagsel.tr_menu;

select * from td_hdr_register_v2 as thrv;


select * from tr_dokumen_asal_bhp as tdab 


-- intip_bhp_kalbagsel.td_hdr_register definition


select * from td_hdr_register_v2 as thrv;


select ROW_NUMBER() OVER (ORDER BY id asc) AS "no",id,
concat(nomor_sbp,'|',tgl_sbp) as no_tanggal_sbp,
concat(nomor_register,'|',tgl_register) as no_tanggal_register,
(select 0) as jumlah_barang,
jenis_dokumen_register, dokumen_asal_bhp, 
(select tdr.jenis_dokumen from tr_dokumen_register as tdr where tdr.id_dokumen_register = thrv.jenis_dokumen_register) as jenis_dokumen_register,
(select tk.nama_satker from tr_kpbc as tk
where thrv.kd_satker_input = tk.kd_satker) as nama_satker
from td_hdr_register_v2 as thrv;

select * from td_hdr_register;

select * from tr_dokumen_register as tdr;

select * from td_barang as tb;

select * from tr_satuan as ts;

select * from tr_gudang as tg;

select * from tr_komoditi_pelanggaran as tkp;
select * from td_barang as tb;

select * from td_image_barang as tib;

select * from td_hdr_register_v2 as thrv;

select * from tr_dokumen_asal_bhp as tdab ;

delete from td_image_barang where id_barang in (select x.id_barang from td_barang x where x.id_register=1);

select * from td_view_data_bhp_v2;

select * from tr_dokumen_register;

select * FROM tr_status_barang as tsb;

select * from tr_komoditi_pelanggaran as tkp where ur_komoditi ='HANDPHONE, GADGET, PART & ACCESORIES';

select * from tr_kpbc as tk;

select * from td_penomoran_register;

select * from td_nomor_bhp as tnb;


select a.nomor_urut,b.kd_penomoran_register FROM tr_kpbc b 
LEFT JOIN td_penomoran a on a.kd_satker = b.kd_satker and a.tahun_penomoran = '2024'
where b.kd_satker = '180000'


select a.id,a.nomor_sbp,a.nomor_register,a.tgl_register,a.tgl_sbp,a.jenis_dokumen_register,c.nama_satker,b.jenis_dokumen,d.ur_dokumen_asal_bhp,
count(e.id_barang) as jumlah_barang
from td_hdr_register_v2 a 
join tr_dokumen_register b on a.jenis_dokumen_register = b.id_dokumen_register
join tr_kpbc c on a.kd_satker_input = c.kd_satker
join tr_dokumen_asal_bhp d on a.dokumen_asal_bhp = d.id_dokumen
left join td_barang e on a.id = e.id_register
group by a.id


select * from td_penomoran_register as tpr ;

select * from tr_dokumen_asal_bhp as tdab ;

select * from td_nomor_bhp as tnb;

select * from td_barang;

select id_komoditi as id, concat(id_komoditi,". j",ur_komoditi) as text from tr_komoditi_pelanggaran as tkp;

select a.kd_penomoran_bhp,
       (select b.nomor_bhp  from td_nomor_bhp b where a.kd_satker = b.kd_satker and b.tahun='2024' order by b.id_nomor_bhp desc limit 1) as nomor_bhp
       from tr_kpbc a where a.kd_satker ='180000';

   select * from td_hdr_register_v2 as thrv;
   
select * from td_view_data_bhp_v2 as tvdbv;

select * from td_nomor_bhp as tnb;

select * from tr_satuan as ts;

select * from td_nomor_bhp as tnb;

select * from tr_menu;


update tr_satuan set is_active = 0 
where uraian_satuan not in ('ampoule','bag','batang','box','bungkus','kaleng',
'drum','gram','carton','kilogram','lembar','liter','kiloliter','meter',
'metrik ton','package','piece','roll','set','unit','jerigen');
