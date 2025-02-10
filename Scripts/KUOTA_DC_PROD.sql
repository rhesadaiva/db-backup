select * from nsw_potong_kuota.td_komoditi order by id_header  desc
limit 10;


select * from nsw_potong_kuota.td_kendalikuota tk where flag_final = 'N';


select * from nsw_potong_kuota.td_realisasi;


select * from nsw_potong_kuota.td_header where no_perijinan ilike '%oss%';


select * from nsw_potong_kuota.tr_status_dokumen as tsd;


select * from nsw_potong_kuota.tr_jns_dokumen as tjd;

select * from nsw_potong_kuota.tr_jns_dokumen_final as tjdf;


select * from nsw_potong_kuota.tr_jns_kegiatan as tjk;

select * from nsw_potong_kuota.td_header where npwp ='84.236.609.8-607x000';

select * from nsw_potong_kuota.td_header where no_perijinan ilike '%kblbb%';
select * from nsw_potong_kuota.td_realisasi where kd_kppbc='020400' order by tgl_perijinan desc;

select * from nsw_potong_kuota.tr_proses_realisasi as tpr;


select * from nsw_potong_kuota.td_komoditi_spesifikasi_teknis as tkst;

select * from referensi.tr_jenis_perijinan as tjp where kd_jenis_perijinan ='0233912';

select * from referensi.tr_kppbc where uraian ilike '%batam';

select * from nsw_potong_kuota.td_realisasi where no_perijinan like '%KBLBB%'

select count(*),kd_hs,jml_satuan as total_realisasi from nsw_potong_kuota.td_realisasi where no_perijinan='1/KBLBB-CBU/1/OSS/PMDN/2024' group by kd_hs, kd_hs_pib,jml_satuan;

select * from nsw_potong_kuota.td_kendalikuota as tk;

select * from nsw_potong_kuota.td_referensi;


select * from nsw_potong_kuota.td_header where no_perijinan='52/PABEAN/OSS/PMDN/2024';

select * from nsw_potong_kuota.td_header order by id_header desc limit 1

select * from nsw_potong_kuota.td_realisasi where no_perijinan ilike '%kblbb%';

select * from nsw_potong_kuota.td_header where no_perijinan like 'TEST1%'