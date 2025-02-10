select * from nsw_bkpm.td_log_send_bkpm as tlsb order by id_log desc limit 1;

select distinct kd_jns_permohonan from nsw_bkpm.td_bkpm_hdr limit 10;


select * from nsw_bkpm.td_bkpm_hdr  as tlsb where no_kep ='15/PABEAN-PB/OSS/PMDN/2024';


select * from nsw_potong_kuota.twhere no_perijinan ='12/PABEAN/OSS/PMA/2024'

select id_permohonan,no_kep,tgl_kep,tgl_akhir_berlaku,
(extract(year from tgl_kep )::integer - extract(year from tgl_akhir_berlaku)::integer) selisih_tahun
from nsw_bkpm.td_bkpm_hdr where extract(year from tgl_akhir_berlaku )::integer < extract(year from tgl_kep)::integer
order by tgl_kep desc;


SELECT no_kep,tgl_kep
from nsw_bkpm.td_bkpm_hdr
where id_permohonan in ('B3-202306231332418598710','M2-202212020738133652652','B2-202207211014249019950');


select * from nsw_bkpm.td_bkpm_hdr
where no_kep='6/PABEAN-PB/OSS/PMA/2023';

select * from nsw_bkpm.td_bkpm_hdr
where no_kep='30/PABEAN/OSS/PMDN/2024';

--51/PABEAN/OSS/PMA/2022 2022-jjjjj06-15

call nsw_bkpm.p_delete_masterlist_id(19414); 




select distinct status_penanaman_modal from nsw_bkpm.td_bkpm_hdr;

select distinct status_penanaman_modal from nsw_bkpm.td_bkpm_hdr where no_kep like '%2024';

select id_hdr,no_kep,tgl_kep,payload from nsw_bkpm.td_bkpm_hdr where no_kep='19/PABEAN-PB/OSS/PMDN/2024';

select row_to_json(headernya) as pib
  from (
           SELECT a.id_permohonan,
                  a.id_permohonan_parent,
                  a.no_kep_parent,
                  a.kd_jns_permohonan,
                  a.no_kep,
                  a.tgl_kep,
                  a.tgl_akhir_berlaku,
                  a.npwp_perusahaan,
                  a.nm_perusahaan,
                  a.kd_badan_usaha,
                  a.status_penanaman_modal,
                  a.kd_negara,
                  a.kd_provinsi,
                  a.kd_kab_kota,
                  a.alamat_perusahaan,
                  a.rt,
                  a.rw,
                  a.kelurahan_desa,
                  a.kecamatan,
                  a.kd_pos,
                  a.no_telepon,
                  a.no_faximile,
                  a.email,
                  a.pj_nama,
                  a.pj_no_telepon,
                  a.pj_email,
                  a.investasi_alamat,
                  a.investasi_rt,
                  a.investasi_rw,
                  a.investasi_kode_pos,
                  a.investasi_provinsi,
                  a.investasi_kota,
                  a.investasi_kelurahan,
                  a.investasi_kecamatan,
                  a.url_kep_masterlist,
                  (select array_agg(dokumennya) as dokumen
                   from (select g.kd_dokumen, g.no_dokumen,g.tgl_dokumen,url_dokumen
                         from nsw_bkpm.td_bkpm_dokumen g
                         where g.id_hdr = a.id_hdr) dokumennya),
                  (
                       select array_agg(detailnya) as detail
           from (
                    SELECT b.id_permohonan,
                           b.id_dtl,
                           b.id_permohonan_parent,
                           b.id_masterlist,
                           b.id_masterlist_parent,
                           b.kd_kategori,
                           b.deskripsi_kategori,
                           b.no_item as no_item_masterlist,
                           b.jenis_barang,
                           b.spesifikasi,
                           b.port_of_loading,
                           b.port_of_discharge,
                           b.jml_satuan,
                           b.kd_sat,
                           b.harga as harga_satuan,
                           b.kd_bm,
                           b.kd_ppn,
                           b.hs_code,
                           b.fl_berlaku,
                           b.fl_mesin_utama as fl_mesin_utama,
                           (
                               select array_agg(sub_detil) as sub
                               from (
                                        select c.no_sub_item,
                                               c.jml_sat,
                                               c.uraian,
                                               c.kd_satuan,
                                               c.hs_code,
                                               c.harga
                                        from nsw_bkpm.td_bkpm_sub c
                                        where c.id_dtl = b.id_dtl
                                    ) sub_detil
                           ),
                           (
                               select array_agg(negaranya) as negara
                               from (
                                        SELECT e.kd_negara
                                        FROM nsw_bkpm.td_bkpm_negara e
                                        WHERE e.id_dtl = b.id_dtl
                                    ) negaranya
                           ),
                           (
                               select array_agg(pelnya) as pelabuhan
                               from (
                                        SELECT f.kd_pelabuhan
                                        FROM nsw_bkpm.td_bkpm_pelabuhan f
                                        WHERE f.id_dtl = b.id_dtl
                                    ) pelnya
                           )
                    from nsw_bkpm.td_bkpm_dtl b
                    where b.id_hdr = a.id_hdr
                    and b.fl_status_item <> 'K'
                    order by b.no_item asc
                ) detailnya
                  ) as detail
           from nsw_bkpm.td_bkpm_hdr a
           where no_kep = $1
       ) headernya
   
   
   select * from nsw_bkpm.td_bkpm_dtl where id_hdr = (select x.id_hdr from nsw_bkpm.td_bkpm_hdr x where x.no_kep='10/PABEAN-PB/OSS/PMA/2024');
   
   
   
    SELECT b.id_permohonan, *
--                           b.id_dtl,
--                           b.id_permohonan_parent,
--                           b.id_masterlist,
--                           b.id_masterlist_parent,
--                           b.kd_kategori,
--                           b.deskripsi_kategori,
--                           b.jenis_barang,
--                           b.spesifikasi,
--                           b.port_of_loading,
--                           b.port_of_discharge,
--                           b.jml_satuan,
--                           b.kd_sat,
--                           b.harga as harga_satuan,
--                           b.kd_bm,
--                           b.kd_ppn,
--                           b.hs_code,
--                           b.fl_berlaku,
--                           b.fl_mesin_utama as fl_mesin_utama,
--    b.jenis_barang, b.spesifikasi,
--                           b.no_item as no_item_masterlist,
--                           b.no_item
from nsw_bkpm.td_bkpm_dtl b where b.fl_status_item <> 'K' and b.id_hdr = (select x.id_hdr from nsw_bkpm.td_bkpm_hdr x where x.no_kep='135/PABEAN/OSS/PMA/2024')
order by no_item; 


select * from nsw_bkpm.td_bkpm_hdr where no_kep ilike '%kblbb%';

select * from nsw_pot.td_realisasi where no_kep ilike '%kblbb%';
   
select * from nsw_bkpm.td_bkpm_dtl where id_hdr=19477;


select b.no_item::int,a.no_sub_item::int,a.uraian,a.jml_sat  from nsw_bkpm.td_bkpm_sub as a
join nsw_bkpm.td_bkpm_dtl as b on a.id_dtl = b.id_dtl
join nsw_bkpm.td_bkpm_hdr as tbh on b.id_hdr = tbh.id_hdr
where tbh.no_kep='10/PABEAN-PB/OSS/PMA/2024' and b.no_item = '52' order by no_sub_item;


