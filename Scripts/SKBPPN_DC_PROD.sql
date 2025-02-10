select *
from nsw_skbppn.td_skb_header
where no_aju like '%TEST%';


select row_to_json(skbppn) as getSKBPPN
from (select a.no_aju,
             to_char(wk_rekam, 'YYYY-MM-DD" "HH24:MI:SS')                as tgl_aju,
             a.kd_jns_permohonan,
             a.kd_jns_pengajuan,
             a.kd_jns_pemohon,
             a.no_kep_bkpm,
             a.tgl_kep_bkpm,
             (select h.tgl_akhir_berlaku
              from nsw_bkpm.td_bkpm_hdr h
              where h.no_kep = a.no_kep_bkpm)                            as tgl_akhir_kep_bkpm,
             a.no_kep_skbppn,
             a.tgl_kep_skbppn,
             (select tgl_akhir_skbppn
              from nsw_skbppn.td_skb_keputusan
              where td_skb_keputusan.no_aju = a.no_aju)                  as tgl_akhir_kep_skbppn,
             a.pmh_npwp_perusahaan,
             a.pmh_nip,
             a.pmh_nm_perusahaan,
             a.pmh_kd_badan_usaha,
             a.pmh_status_penanaman_modal,
             a.pmh_kd_negara,
             a.pmh_kd_provinsi,
             a.pmh_kd_kab_kota,
             a.pmh_alamat_perusahaan,
             a.pmh_rt,
             a.pmh_rw,
             a.pmh_kelurahan_desa,
             a.pmh_kecamatan,
             a.pmh_kode_pos,
             a.pmh_no_telepon,
             a.pmh_no_faximile,
             a.pmh_email,
             a.pkp_npwp_perusahaan,
             a.pkp_nm_perusahaan,
             a.pkp_kd_badan_usaha,
             a.pkp_status_penanaman_modal,
             a.pkp_kd_negara,
             a.pkp_kd_provinsi,
             a.pkp_kd_kab_kota,
             a.pkp_alamat_perusahaan,
             a.pkp_rt,
             a.pkp_rw,
             a.pkp_kelurahan_desa,
             a.pkp_kecamatan,
             a.pkp_kode_pos,
             a.pkp_no_telepon,
             a.pkp_no_faximile,
             a.pkp_email,
             a.pmh_pic_nama                                              as pj_nama,
             a.pmh_pic_email                                             as pj_email,
             a.pmh_pic_telepon                                           as pj_no_telepon,
             a.pmh_kd_provinsi                                           as pj_kd_provinsi,
             a.pmh_kd_kab_kota                                           as pj_kd_kab_kota,
             a.pmh_alamat_perusahaan                                     as pj_alamat,
             a.pmh_rt                                                    as pj_rt,
             a.pmh_rw                                                    as pj_rw,
             a.pmh_kelurahan_desa                                        as pj_kelurahan_desa,
             a.pmh_kecamatan                                             as pj_kecamatan,
             a.pmh_kode_pos                                              as pj_kode_pos,
             a.lok_kd_provinsi,
             a.lok_kd_kab_kota,
             a.lok_alamat,
             a.lok_rt,
             a.lok_rw,
             a.lok_kelurahan_desa,
             a.lok_kecamatan,
             a.lok_kode_pos,
             a.tahun_takwim_mohon,
             a.fl_pkp_listrik,
             a.epc_no_kontrak                                            as no_kontrak_epc,
             a.epc_tgl_kontrak                                           as tgl_kontrak_epc,
             a.total_harga                                               as "harga_total",
             a.total_ppn                                                 as "nilai_PPN",
             a.seri_perubahan,
             (select json_agg(getepc)
              from (select b.epc_npwp_perusahaan,
                           b.epc_nm_perusahaan,
                           b.epc_kd_badan_usaha,
                           b.epc_status_penanaman_modal,
                           b.epc_kd_negara,
                           b.epc_kd_provinsi,
                           b.epc_kd_kab_kota,
                           b.epc_alamat_perusahaan,
                           b.epc_rt,
                           b.epc_rw,
                           b.epc_kelurahan_desa,
                           b.epc_kecamatan,
                           b.epc_kode_pos,
                           b.epc_no_telepon,
                           b.epc_no_faximile,
                           b.epc_email,
                           b.epc_no_kontrak  as no_kontrak_epc,
                           b.epc_tgl_kontrak as tgl_kontrak_epc
                    from nsw_skbppn.td_skb_epc b
                    where a.id_skb_header = b.id_skb_header) getepc)     as epc,
             (select json_agg(getdokumen)
              from (select c.kd_jenis_dokumen,
                           c.no_dokumen,
                           c.url_dokumen as url_dokumen,
                           c.tgl_dokumen
                    from nsw_skbppn.td_skb_dokumen c
                    where a.id_skb_header = c.id_skb_header) getdokumen) as dokumen,
             (select json_agg(detailnya)
              from (select d.no_item,
                           d.jenis_barang,
                           d.spesifikasi,
                           d.jml_satuan,
                           d.kd_satuan,
                           d.kd_kondisi,
                           d.harga_satuan,
                           d.nilai_rupiah                                             as harga_total,
                           d.nilai_ppn,
                           d.hs_code,
                           d.fl_berlaku,
                           d.jml_satuan_terpakai,
                           d.jml_satuan_sisa,
                           d.no_surat,
                           d.npwp_pkp_penyerahan,
                           d.nama_pkp_penyerahan,
                           d.fl_epc,
                           d.epc_npwp,
                           d.kd_jenis_pemasukan,
                           (select json_agg(subnya)
                            from (select e.no_sub_item,
                                         e.hs_code,
                                         e.jenis_barang,
                                         e.jml_satuan,
                                         e.kd_satuan,
                                         e.harga_satuan
                                  from nsw_skbppn.td_skb_barang_detail e
                                  where d.id_skb_barang = e.id_skb_barang) subnya)    as sub,
                           (select json_agg(negaranya)
                            from (select f.kd_negara
                                  from nsw_skbppn.td_skb_barang_negara f
                                  where d.id_skb_barang = f.id_skb_barang) negaranya) as negara,
                           (select json_agg(pelnya)
                            from (select g.kd_pelabuhan
                                  from nsw_skbppn.td_skb_barang_pelabuhan g
                                  where d.id_skb_barang = g.id_skb_barang) pelnya)    as pelabuhan
                    from nsw_skbppn.td_skb_barang d
                    where a.id_skb_header = d.id_skb_header) detailnya)  as barang
      from nsw_skbppn.td_skb_header a
      where a.no_aju = $1
        and extract(year from a.wk_rekam) = '2023'
--       where (a.flag_kirim_djp is null or a.flag_kirim_djp = 'N')
--         and (a.pmh_npwp_perusahaan <> '030251821643000' and a.pmh_npwp_perusahaan <> '030251797643000')
--         and seri_perubahan = 0
--         and a.kd_proses = '10'

--             order by id_skb_header desc
--
     ) skbppn;

select *
from nsw_bkpm.td_bkpm_hdr
where no_kep = '135/PABEAN/OSS/PMA/2024';

select *
from nsw_skbppn.tr_proses;

update nsw_skbppn.td_skb_header
set no_kep_bkpm='TEST-1234/PABEAN/PMDN/2021',
    tgl_kep_bkpm='2021-01-14'
where no_aju like '3020089XTEST%'
returning no_aju,no_kep_bkpm,tgl_kep_bkpm;

select *
from nsw_skbppn.td_skb_header
where no_aju like '3020089XTEST%';

update nsw_skbppn.td_skb_dokumen
set url_dokumen='https://pii.or.id/uploads/dummies.pdf',
    tgl_dokumen='2022-01-01'
where id_skb_header in (10731,
                        10732,
                        10733,
                        10734,
                        10735
    )
returning id_skb_header,url_dokumen,no_dokumen,tgl_dokumen;

select *
from nsw_skbppn.td_skb_header
where no_kep_bkpm like '%TEST%';

-- 2021-01-14
-- TEST-1234/PABEAN/PMDN/2021

select *
from nsw_skbppn.f_data_jasper_skbppn('d340ab3c-5623-4a14-80ed-ac46599a1ee0');

-- Jasper Cetakan barang
with masterPelabuhan as (with distinctPelabuhan as (select distinct d.kd_pelabuhan
                                                    from nsw_skbppn.td_skb_barang_pelabuhan d
                                                    where d.id_skb_barang in (select e.id_skb_barang
                                                                              from nsw_skbppn.td_skb_barang e
                                                                              where e.id_skb_header =
                                                                                    (select f.id_skb_header
                                                                                     from nsw_skbppn.td_skb_header f
                                                                                     where f.id_skb_jasper = $1)))
                         select string_agg(aa.kd_pelabuhan, ',') as agg_kd_pelabuhan,
                                string_agg(ab.ur_pelabuhan, ',') as agg_pelabuhan,
                                string_agg(ac.uraian, ',')       as agg_kppbc
                         from distinctPelabuhan aa
                                  join referensi.tr_pelabuhan ab on aa.kd_pelabuhan = ab.kd_pelabuhan
                                  join referensi.tr_kppbc ac on ab.kd_kantor = ac.kd_kppbc)
select a.id_skb_header::int,
       a.pmh_nm_perusahaan,
       a.pmh_npwp_perusahaan,
       b.kd_valuta,
       a.seri_perubahan,
       c.tgl_kep_skbppn,
       c.tgl_akhir_skbppn,
       a.pmh_alamat_perusahaan || ', ' ||
       (select concat_ws(', ',
                         (select ur_lokasi
                          from nsw_skbppn.tr_lokasi x
                          where x.kd_lokasi = a.pmh_kecamatan),
                         (select ur_lokasi
                          from nsw_skbppn.tr_lokasi x
                          where x.kd_lokasi = a.pmh_kd_kab_kota),
                         (select ur_lokasi
                          from nsw_skbppn.tr_lokasi x
                          where x.kd_lokasi = a.pmh_kd_provinsi))
        from nsw_skbppn.td_skb_header b
        where b.id_skb_header = a.id_skb_header)          as alamat,
       a.lok_alamat || ', ' ||
       (select concat_ws(', ',
                         (select ur_lokasi
                          from nsw_skbppn.tr_lokasi x
                          where x.kd_lokasi = a.lok_kecamatan),
                         (select ur_lokasi
                          from nsw_skbppn.tr_lokasi x
                          where x.kd_lokasi = a.lok_kd_kab_kota),
                         (select ur_lokasi
                          from nsw_skbppn.tr_lokasi x
                          where x.kd_lokasi = a.lok_kd_provinsi))
        from nsw_skbppn.td_skb_header b
        where b.id_skb_header = a.id_skb_header)          as alamat_proyek,
       a.epc_no_kontrak,
       c.no_kep_skbppn,
       c.no_rkip,
       c.tgl_kep_skbppn,
       (select x.tgl_akhir_skbppn
        from nsw_skbppn.td_skb_keputusan x
        where x.no_kep_skbppn = a.no_kep_skbppn)          as tgl_akhir_skb_a2,
       c.tgl_rkip,
       a.tahun_takwim_mohon                                  tahun_takwim,
       b.id_skb_barang,
       (b.no_item)::int,
       b.hs_code,
       b.kd_kondisi,
       b.jenis_barang,
       b.spesifikasi,
       b.jml_satuan,
       b.kd_satuan,
       b.harga_satuan,
       trim(REPLACE(
               REPLACE(REPLACE(to_char(b.harga_total, '999,999,999,999,999.99'), ',', '|'), '.', ','),
               '|',
               '.'))                                      as harga_total,
       trim(REPLACE(
               REPLACE(REPLACE(to_char(b.nilai_ppn, '999,999,999,999,999.99'), ',', '|'), '.', ','),
               '|',
               '.'))                                      as nilai_ppn,
       (select string_agg(ur_negara, ', ')
        FROM nsw_skbppn.td_skb_barang_negara tsbn
                 JOIN referensi.tr_negara tn on tsbn.kd_negara = tn.kd_negara
        where tsbn.id_skb_barang = b.id_skb_barang)       as negara,
       (SELECT string_agg(ur_satuan, ',') as kd
        FROM nsw_skbppn.td_skb_barang tb
                 JOIN referensi.tr_satuan ts on tb.kd_satuan = ts.kd_satuan
        WHERE tb.id_skb_barang = b.id_skb_barang)         as satuan,
       (select x.agg_kd_pelabuhan from masterPelabuhan x) as agg_kd_pelabuhan,
       (select x.agg_pelabuhan from masterPelabuhan x)    as agg_pelabuhan,
       (select x.agg_kppbc from masterPelabuhan x)        as agg_kppbc
from nsw_skbppn.td_skb_header a
         left join nsw_skbppn.td_skb_keputusan c
                   on a.no_aju = c.no_aju and a.seri_perubahan = c.seri_perubahan
         inner join nsw_skbppn.td_skb_barang b on a.id_skb_header = b.id_skb_header
where a.id_skb_jasper = $1
  and c.no_rkip not like '1'
order by (b.no_item)::int;


select *
from nsw_skbppn.td_log_keputusan_djp
where no_aju = '3020089753585';

select *
from nsw_skbppn.td_skb_keputusan
order by id_keputusan desc;

select *
from nsw_skbppn.td_skb_keputusan
where no_aju = '3020089B17B32';

select *
from nsw_skbppn.td_log_scheduler_djp
order by id_log desc
limit 5000;


with master as (select *, row_number() over (partition by no_aju order by id_log desc) as urut
                from nsw_skbppn.td_log_scheduler_djp
                where no_aju = '3020089B069C8'
                order by id_log desc)
delete
from nsw_skbppn.td_log_scheduler_djp
where id_log in (select x.id_log from master x where x.urut > 1)
returning id_log;


select *
from nsw_skbppn.td_skb_barang
where id_skb_header = '10101';

select distinct a.kd_pelabuhan, b.ur_pelabuhan, c.uraian
from nsw_skbppn.td_skb_barang_pelabuhan a
         join referensi.tr_pelabuhan b on a.kd_pelabuhan = b.kd_pelabuhan
         left join referensi.tr_kppbc c on b.kd_kantor = c.kd_kppbc
where a.id_skb_barang in (select x.id_skb_barang from nsw_skbppn.td_skb_barang x where x.id_skb_header = 10101)

select a.id_skb_header, a.no_aju, a.no_kep_bkpm, b.no_dokumen
from nsw_skbppn.td_skb_header a
         join nsw_skbppn.td_skb_dokumen b on a.id_skb_header = b.id_skb_header
where no_aju = '3020089A0B256';

select *
from nsw_skbppn.td_skb_header
where id_skb_header = 10676;

select no_aju, kd_proses, flag_kirim_djp
from nsw_skbppn.td_skb_header
where no_aju = '3020089A0B256';

select *
from nsw_skbppn.td_log_scheduler_djp
where no_aju = '302008995199D';


select *
from nsw_bkpm.td_bkpm_dokumen
where id_hdr = (select x.id_hdr from nsw_bkpm.td_bkpm_hdr x where x.no_kep = '96/PABEAN/OSS/PMDN/2023');


select *
from nsw_skbppn.f_data_jasper_skbppn('e65be1c3-c5ed-45e7-928d-ae041f105268');


select *
from nsw_skbppn.td_skb_header
where id_skb_jasper = 'e65be1c3-c5ed-45e7-928d-ae041f105268';


select *
from nsw_skbppn.td_skb_keputusan
where no_kep_skbppn = 'KET-SKB-00009/WPJ.30/KP.0106/2022';

select *
from nsw_skbppn.td_skb_barang
where id_skb_header =
      (select x.id_skb_header from nsw_skbppn.td_skb_header x where x.no_aju = '30200837FF0C1' and seri_perubahan = 0);

select *
from nsw_skbppn.td_skb_barang_detail
where id_skb_barang = 32039;

-- Get Data Kuota
select row_to_json(skbppn) as skbppn
from (select a.id_skb_header,
             a.kd_jns_permohonan                                         as jns_pengajuan,
             a.no_aju                                                    as no_pengajuan,
             (select h.no_kep_skbppn
              from nsw_skbppn.td_skb_keputusan h
              where h.no_aju = a.no_aju
                and h.seri_perubahan = a.seri_perubahan)                 as no_perijinan,
             (select h.tgl_kep_skbppn
              from nsw_skbppn.td_skb_keputusan h
              where h.no_aju = a.no_aju
                and h.seri_perubahan = a.seri_perubahan)                 as tgl_perijinan,
             (select h.tgl_kep_skbppn
              from nsw_skbppn.td_skb_keputusan h
              where h.no_aju = a.no_aju
                and h.seri_perubahan = a.seri_perubahan)                 as tgl_awal_perijinan,
             (select h.tgl_akhir_skbppn
              from nsw_skbppn.td_skb_keputusan h
              where h.no_aju = a.no_aju
                and h.seri_perubahan = a.seri_perubahan)                 as tgl_akhir_perijinan,
             a.wk_kirim                                                  as wk_pengiriman,
             a.pmh_npwp_perusahaan                                       as npwp,
             a.pmh_nm_perusahaan                                         as nama,
             a.pmh_alamat_perusahaan                                     as alamat,
             a.pmh_kode_pos                                              as kd_pos,
             a.pmh_kd_kab_kota                                           as kd_kota,
             a.pmh_kd_provinsi                                           as kd_provinsi,
             a.pmh_kd_negara                                             as kd_negara,
             a.pmh_no_telepon                                            as telp,
             a.pmh_no_faximile                                           as fax,
             a.pmh_email                                                 as email,
             (select url_kep_skbppn
              from nsw_skbppn.td_skb_keputusan h
              where h.no_aju = a.no_aju
                and h.seri_perubahan = a.seri_perubahan)                 as url_doc,
             (a.kd_jns_pengajuan || a.kd_jns_permohonan)                 as jns_skbppn,
             (select json_agg(getdokumen)
              from (select c.kd_jenis_dokumen,
                           c.no_dokumen,
                           c.tgl_dokumen,
                           c.url_dokumen as url_dokumen
                    from nsw_skbppn.td_skb_dokumen c
                    where a.id_skb_header = c.id_skb_header) getdokumen) as referensi,
             (select json_agg(detailnya)
              from (select d.no_item                                                  as seri,
                           d.hs_code                                                  as kd_hs,
                           d.kd_satuan                                                as kd_jns_satuan,
                           d.nilai_ppn                                                as ppn,
                           d.jenis_barang                                             as uraian,
                           d.harga_total                                              as nilai_total_barang,
                           d.harga_satuan,
                           d.jml_satuan                                               as jml_kuota,
                           d.jml_satuan_terpakai                                      as jml_terpakai,
                           d.jml_satuan_sisa                                          as jml_sisa,
                           d.kd_jenis_pemasukan,
                           d.nama_penjual,
                           d.npwp_penjual,
                           (select json_agg(subnya)
                            from (select e.no_sub_item         as serial,
                                         e.hs_code             as kd_hs,
                                         e.jenis_barang        as uraian,
                                         e.kd_satuan           as kd_jns_satuan,
                                         e.jml_satuan          as jml_kuota,
                                         e.jml_satuan_terpakai as jml_terpakai,
                                         e.jml_satuan_sisa     as jml_sisa
                                  from nsw_skbppn.td_skb_barang_detail e
                                  where d.id_skb_barang = e.id_skb_barang) subnya)    as sub,
                           (select json_agg(negaranya)
                            from (select f.kd_negara
                                  from nsw_skbppn.td_skb_barang_negara f
                                  where d.id_skb_barang = f.id_skb_barang) negaranya) as negara,
                           (select json_agg(pelnya)
                            from (select g.kd_pelabuhan
                                  from nsw_skbppn.td_skb_barang_pelabuhan g
                                  where d.id_skb_barang = g.id_skb_barang) pelnya)    as pelabuhan
                    from nsw_skbppn.td_skb_barang d
                    where a.id_skb_header = d.id_skb_header) detailnya)  as komoditi
      from nsw_skbppn.td_skb_header a
      where a.seri_perubahan = 0
        and a.kd_proses = '50'
      order by random()
      limit 1) skbppn;


select *
from nsw_skbppn.td_skb_keputusan
where no_aju = '302008991E54B';

select *
from nsw_skbppn.td_skb_barang
where id_skb_header = 9884;

select *
from nsw_skbppn.td_skb_barang_detail
where id_skb_barang = 65653;


select *
from nsw_skbppn.td_skb_keputusan
where url_kep_skbppn =
      'https://api.insw.go.id/api/report/preview/skbppn?type=A1&id=3a1e427f-9711-4e52-b5bc-f5fd07bc9aa9';


select no_aju,
       seri_perubahan,
       concat(kd_jns_pengajuan, kd_jns_pemohon) as jenis_skbppn,
       pmh_npwp_perusahaan,
       pmh_nm_perusahaan,
       (select x.ur_proses from nsw_skbppn.tr_proses x where a.kd_proses = x.kd_proses)
from nsw_skbppn.td_skb_header a
where no_aju = '3020089A34A6C';

select distinct a.no_aju, b.kd_kondisi, c.no_kep_skbppn
from nsw_skbppn.td_skb_header a
         join nsw_skbppn.td_skb_barang b on a.id_skb_header = b.id_skb_header
         join nsw_skbppn.td_skb_keputusan c on a.no_aju = c.no_aju
where kd_kondisi = 'Terurai';



select *
from nsw_skbppn.td_log_scheduler_djp
where no_aju = '3020089A3BF91';


select *
from nsw_skbppn.f_data_jasper_skbppn('77946262-2406-423e-8549-1698191dc096');

select a.id_skb_header, no_aju, b.*

from nsw_skbppn.td_skb_header a
         join nsw_skbppn.td_skb_barang b on a.id_skb_header = b.id_skb_header
where id_skb_jasper = '77946262-2406-423e-8549-1698191dc096';

select *
from nsw_skbppn.td_skb_keputusan
where no_aju = '3020089A482E5'
order by id_keputusan desc;

select pmh_npwp_perusahaan
from nsw_skbppn.td_skb_header
where no_aju = '3020089XTEST5'



SELECT a.no_aju, a.seri_perubahan, url_kep_skbppn
FROM nsw_skbppn.td_skb_keputusan a
         join nsw_skbppn.td_skb_header b on a.no_aju = b.no_aju and a.seri_perubahan = b.seri_perubahan
WHERE a.no_aju = $1
  and a.seri_perubahan = $2
  and kd_keputusan = $3
  and b.pmh_npwp_perusahaan <> '024804635651000'
  and b.pmh_npwp_perusahaan <> '030251797643000';


select jenis_barang, no_item, spesifikasi, nilai_ppn, nilai_rupiah, (nilai_rupiah + nilai_ppn) as tot
from nsw_skbppn.td_skb_barang
where id_skb_header = (select x.id_skb_header from nsw_skbppn.td_skb_header x where x.no_aju = '302008974C051');


select *
from nsw_skbppn.td_skb_epc
where id_skb_header = '9392';


select *
from nsw_skbppn.td_skb_barang
where jenis_barang = 'ORE CONCENTRATION SYSTEM EQUIPMENT';


select *
from nsw_skbppn.td_skb_barang
where id_skb_header in (select x.id_skb_header
                        from nsw_skbppn.td_skb_header x
                        where x.no_aju in ('3020089B0DEF3', '3020089B0B7EE', '3020089B0B7E9', '3020089B0B7EA'));


select *
from nsw_skbppn.td_skb_header
where kd_proses = '50'
order by id_skb_header desc;

-- cek skb belum ada keputusan
with master as (select no_aju,
                       kd_proses,
                       concat(kd_jns_pengajuan, kd_jns_pemohon) as jenis_pengajuan,
                       wk_rekam,
                       wk_kirim
                from nsw_skbppn.td_skb_header a
                where a.pmh_npwp_perusahaan <> '024804635651000'
                  and a.pmh_npwp_perusahaan <> '030251797643000'
                order by id_skb_header desc)
-- select * from master where jenis_pengajuan='A1' or jenis_pengajuan = 'A2' and (kd_proses = '10' or kd_proses ='20');
--  select * from master;
select a.no_aju,
       a.jenis_pengajuan,
       wk_kirim::date,
       (select x.ur_proses from nsw_skbppn.tr_proses x where a.kd_proses = x.kd_proses),
       b.no_kep_skbppn,
       b.tgl_kep_skbppn,
       (now()::date - wk_kirim::date) as selisih_hari
from master a
         left join nsw_skbppn.td_skb_keputusan b on a.no_aju = b.no_aju
-- where (a.wk_kirim::date between '2023-10-01' and '2023-10-11')
where now()::date - wk_kirim::date between 0 and 21
  and (jenis_pengajuan = 'A1' or jenis_pengajuan = 'A2')
and kd_proses='20';

-- query cek log keputusan
select * from nsw_skbppn.td_log_keputusan_djp where no_aju='3020089B12D14';

select *
from nsw_skbppn.tr_proses;


SELECT CAST($1 AS date) - CAST($2 AS date) as DateDifference;
;

select no_aju, kd_proses, wk_rekam, wk_kirim
from nsw_skbppn.td_skb_header
where no_aju = '3020089B090D5';

select no_aju, kd_proses, concat(kd_jns_pengajuan, kd_jns_pemohon) as jenis_pengajuan
from nsw_skbppn.td_skb_header
where kd_jns_pengajuan = 'A'
  and wk_kirim::date = '2023-10-09';

select *
from nsw_skbppn.td_skb_keputusan
where no_aju = '3020089B1C95E'
-- where no_kep_skbppn = 'KET-00023/PPN/KPP.0702/2023'
order by id_keputusan desc;


select *
from nsw_skbppn.td_log_keputusan_djp
where no_aju = '3020089A482E8';

select no_aju, concat(kd_jns_pengajuan, kd_jns_pemohon) as jenis_pengajuan
from nsw_skbppn.td_skb_header
where no_aju = '3020089A482E8';

-- query cek data yang belum terkirim
select a.no_aju,
       a.seri_perubahan,
       a.wk_rekam,
       wk_kirim::date                           as tgl_aju,
       concat(kd_jns_pengajuan, kd_jns_pemohon) as jenis_pengajuan,
       kd_proses,
       flag_kirim_djp
from nsw_skbppn.td_skb_header a
where pmh_npwp_perusahaan <> '024804635651000'
    and (kd_proses = '10' or kd_proses = '99')
    and extract(month from wk_rekam) = '10'
    and extract(year from wk_rekam) = '2023'
    and seri_perubahan = '0'
   or null
order by id_skb_header desc;

-- query update flag
update nsw_skbppn.td_skb_header
set flag_kirim_djp='N'
where no_aju = $1
  and kd_proses = '10'
returning no_aju,kd_proses,flag_kirim_djp;

-- query set draft
update nsw_skbppn.td_skb_header
set kd_proses='00'
where no_aju in ('3020089B0DEF2', '3020089B12D1F')
returning no_aju,kd_proses;

-- query cek id_jasper
select a.no_aju, id_skb_jasper, b.no_kep_skbppn
from nsw_skbppn.td_skb_header a
         left join nsw_skbppn.td_skb_keputusan b
                   on a.no_aju = b.no_aju
where id_skb_jasper = $1;

-- query cek log skb
select a.no_aju,
       concat(kd_jns_pengajuan, kd_jns_pemohon) as jenis_pengajuan,
       payload_kirim,
       payload_response,
       b.wk_kirim::date
from nsw_skbppn.td_skb_header a
         join nsw_skbppn.td_log_scheduler_djp b on a.no_aju = b.no_aju
where a.no_aju = '3020089B1A248';

-- query cek status skb
select a.no_aju, a.wk_kirim::date as tgl_aju, b.ur_proses as status
from nsw_skbppn.td_skb_header a
         join nsw_skbppn.tr_proses b on a.kd_proses = b.kd_proses
where a.no_aju = $1;

-- update status skb
update nsw_skbppn.td_skb_header
set kd_proses='20',
    flag_kirim_djp='Y'
where no_aju = $1
returning no_aju, kd_proses;


-- delete keputusan dobel
with cek as (select a.id_keputusan,
                    a.no_aju,
                    row_number() over (partition by a.no_aju order by a.id_keputusan desc) as urut,
                    a.tgl_kep_skbppn
             from nsw_skbppn.td_skb_keputusan a
                      join nsw_skbppn.td_skb_header b on a.no_aju = b.no_aju
             where pmh_npwp_perusahaan <> '024804635651000')
select distinct no_aju, tgl_kep_skbppn
from cek
where urut > 1;
-- delete from nsw_skbppn.td_skb_keputusan where id_keputusan in (
--     select x.id_keputu   san from cek x
--                           where x.no_aju ='3020089A482E5' and x.urut > 1
--     ) returning id_keputusan;

select no_aju, kd_proses
from nsw_skbppn.td_skb_header
where no_aju = $1;


select *
from nsw_skbppn.td_skb_header
where no_aju = '3020089B17B46';


select *
from nsw_skbppn.td_skb_keputusan
-- where no_kep_skbppn = 'KET-00024/PPN/KPP.2106/2023';
where no_aju='3020089B1C95E';

-- get data skbppn
select row_to_json(skbppn) as getSKBPPN
from (select a.no_aju,
             to_char(wk_rekam, 'YYYY-MM-DD" "HH24:MI:SS')                as tgl_aju,
             a.kd_jns_permohonan,
             a.kd_jns_pengajuan,
             a.kd_jns_pemohon,
             a.no_kep_bkpm,
             a.tgl_kep_bkpm,
             (select h.tgl_akhir_berlaku
              from nsw_bkpm.td_bkpm_hdr h
              where h.no_kep = a.no_kep_bkpm)                            as tgl_akhir_kep_bkpm,
             a.no_kep_skbppn,
             a.tgl_kep_skbppn,
             (select tgl_akhir_skbppn
              from nsw_skbppn.td_skb_keputusan
              where td_skb_keputusan.no_aju = a.no_aju)                  as tgl_akhir_kep_skbppn,
             a.pmh_npwp_perusahaan,
             a.pmh_nip,
             a.pmh_nm_perusahaan,
             a.pmh_kd_badan_usaha,
             a.pmh_status_penanaman_modal,
             a.pmh_kd_negara,
             a.pmh_kd_provinsi,
             a.pmh_kd_kab_kota,
             a.pmh_alamat_perusahaan,
             a.pmh_rt,
             a.pmh_rw,
             a.pmh_kelurahan_desa,
             a.pmh_kecamatan,
             a.pmh_kode_pos,
             a.pmh_no_telepon,
             a.pmh_no_faximile,
             a.pmh_email,
             a.pkp_npwp_perusahaan,
             a.pkp_nm_perusahaan,
             a.pkp_kd_badan_usaha,
             a.pkp_status_penanaman_modal,
             a.pkp_kd_negara,
             a.pkp_kd_provinsi,
             a.pkp_kd_kab_kota,
             a.pkp_alamat_perusahaan,
             a.pkp_rt,
             a.pkp_rw,
             a.pkp_kelurahan_desa,
             a.pkp_kecamatan,
             a.pkp_kode_pos,
             a.pkp_no_telepon,
             a.pkp_no_faximile,
             a.pkp_email,
             a.pmh_pic_nama                                              as pj_nama,
             a.pmh_pic_email                                             as pj_email,
             a.pmh_pic_telepon                                           as pj_no_telepon,
             a.pmh_kd_provinsi                                           as pj_kd_provinsi,
             a.pmh_kd_kab_kota                                           as pj_kd_kab_kota,
             a.pmh_alamat_perusahaan                                     as pj_alamat,
             a.pmh_rt                                                    as pj_rt,
             a.pmh_rw                                                    as pj_rw,
             a.pmh_kelurahan_desa                                        as pj_kelurahan_desa,
             a.pmh_kecamatan                                             as pj_kecamatan,
             a.pmh_kode_pos                                              as pj_kode_pos,
             a.lok_kd_provinsi,
             a.lok_kd_kab_kota,
             a.lok_alamat,
             a.lok_rt,
             a.lok_rw,
             a.lok_kelurahan_desa,
             a.lok_kecamatan,
             a.lok_kode_pos,
             a.tahun_takwim_mohon,
             a.fl_pkp_listrik,
             a.epc_no_kontrak                                            as no_kontrak_epc,
             a.epc_tgl_kontrak                                           as tgl_kontrak_epc,
             a.total_harga                                               as "harga_total",
             a.total_ppn                                                 as "nilai_PPN",
             a.seri_perubahan,
             (select json_agg(getepc)
              from (select b.epc_npwp_perusahaan,
                           b.epc_nm_perusahaan,
                           b.epc_kd_badan_usaha,
                           b.epc_status_penanaman_modal,
                           b.epc_kd_negara,
                           b.epc_kd_provinsi,
                           b.epc_kd_kab_kota,
                           b.epc_alamat_perusahaan,
                           b.epc_rt,
                           b.epc_rw,
                           b.epc_kelurahan_desa,
                           b.epc_kecamatan,
                           b.epc_kode_pos,
                           b.epc_no_telepon,
                           b.epc_no_faximile,
                           b.epc_email,
                           b.epc_no_kontrak  as no_kontrak_epc,
                           b.epc_tgl_kontrak as tgl_kontrak_epc
                    from nsw_skbppn.td_skb_epc b
                    where a.id_skb_header = b.id_skb_header) getepc)     as epc,
             (select json_agg(getdokumen)
              from (select c.kd_jenis_dokumen,
                           c.no_dokumen,
                           c.url_dokumen as url_dokumen,
                           c.tgl_dokumen
                    from nsw_skbppn.td_skb_dokumen c
                    where a.id_skb_header = c.id_skb_header) getdokumen) as dokumen,
             (select json_agg(detailnya)
              from (select d.no_item,
                           d.jenis_barang,
                           d.spesifikasi,
                           d.jml_satuan,
                           d.kd_satuan,
                           d.kd_kondisi,
                           d.harga_satuan,
                           d.nilai_rupiah                                             as harga_total,
                           d.nilai_ppn,
                           d.hs_code,
                           d.fl_berlaku,
                           d.jml_satuan_terpakai,
                           d.jml_satuan_sisa,
                           d.no_surat,
                           d.npwp_pkp_penyerahan,
                           d.nama_pkp_penyerahan,
                           d.fl_epc,
                           d.epc_npwp,
                           d.kd_jenis_pemasukan,
                           (select json_agg(subnya)
                            from (select e.no_sub_item,
                                         e.hs_code,
                                         e.jenis_barang,
                                         e.jml_satuan,
                                         e.kd_satuan,
                                         e.harga_satuan
                                  from nsw_skbppn.td_skb_barang_detail e
                                  where d.id_skb_barang = e.id_skb_barang) subnya)    as sub,
                           (select json_agg(negaranya)
                            from (select f.kd_negara
                                  from nsw_skbppn.td_skb_barang_negara f
                                  where d.id_skb_barang = f.id_skb_barang) negaranya) as negara,
                           (select json_agg(pelnya)
                            from (select g.kd_pelabuhan
                                  from nsw_skbppn.td_skb_barang_pelabuhan g
                                  where d.id_skb_barang = g.id_skb_barang) pelnya)    as pelabuhan
                    from nsw_skbppn.td_skb_barang d
                    where a.id_skb_header = d.id_skb_header) detailnya)  as barang
      from nsw_skbppn.td_skb_header a
      where (a.flag_kirim_djp is null or a.flag_kirim_djp = 'N')
        and (a.pmh_npwp_perusahaan <> '030251821643000'
          and a.pmh_npwp_perusahaan <> '030251797643000')
        and a.kd_proses = '10'
        and seri_perubahan = 0
        and extract(year from a.wk_rekam) = $1
        and extract(month from a.wk_rekam) = $2
      order by random()
--             limit 1
     ) skbppn;


select no_aju,wk_kirim,kd_proses,pmh_npwp_perusahaan
from nsw_skbppn.td_skb_header
where no_aju='3020089B46164';

select no_aju ,seri_perubahan , (select x.ur_proses from nsw_skbppn.tr_proses x where x.kd_proses = a.kd_proses  )  from nsw_skbppn.td_skb_header a where no_aju='3020089A19CB3' and seri_perubahan=1;

select * from nsw_skbppn.td_skb_barang where id_skb_header='11450';

select *
from nsw_skbppn.tr_proses;

-- update status skbppn
update nsw_skbppn.td_skb_header 
set kd_proses='00' 
where no_aju='3020089641E81' and seri_perubahan=1 
returning no_aju,seri_perubahan, kd_proses;



select no_aju,wk_kirim,payload_kirim,payload_response  from nsw_skbppn.td_log_scheduler_djp where no_aju='3020089A19CB3';


select * from nsw_skbppn.td_log_scheduler_djp tlsd where no_aju = $1;


select * from nsw_skbppn.td_log_scheduler_djp tlkd where no_aju ='3020089D1865A';


select distinct no_kep_skbppn from nsw_skbppn.td_skb_keputusan where kd_keputusan='50';


select * from nsw_skbppn.td_skb_keputusan where no_kep_skbppn  like '%WPJ.07/KP.0403/2021%'


select no_kep_skbppn,  
case when no_kep_skbppn like '%KET-SKB%' then split_part(no_kep_skbppn,'KET-SKB-',2)
else split_part(no_kep_skbppn,'KET-',2)
end 
as format_pib from nsw_skbppn.td_skb_keputusan tsk  where kd_keputusan='50';

with swahili as (select no_kep_skbppn,  
case when no_kep_skbppn like '%KET-SKB%' then split_part(no_kep_skbppn,'KET-SKB-',2)
else split_part(no_kep_skbppn,'KET-',2)
end
as format_pib from nsw_skbppn.td_skb_keputusan tsk  where kd_keputusan='50' and not no_kep_skbppn like '%TEST%' )
select * from swahili where format_pib is not null;

select no_aju,seri_perubahan,kd_proses,(select x.ur_proses from nsw_skbppn.tr_proses x where x.kd_proses = td_skb_header.kd_proses) as ur_proses
from nsw_skbppn.td_skb_header where no_aju ='3020089BF36DB';


select no_aju,no_rkip,seri_perubahan from nsw_skbppn.td_skb_keputusan where no_aju ='3020089C32E75';


select no_aju,no_kep_skbppn,tgl_kep_skbppn,wk_rekam from nsw_skbppn.td_skb_keputusan tsk where no_aju ='302008F1EF257';


delete from nsw_skbppn.td_log_keputusan_djp where id_log='1038140';

select * from nsw_skbppn.td_log_scheduler_djp where no_aju='302008F1FB5A3';



select no_kep_bkpm from nsw_skbppn.td_skb_header where no_kep_bkpm is not null;



update nsw_skbppn.td_skb_header set kd_proses ='10' where no_aju ='3020089D1865A';

with getLastData as (select a.id_skb_header,a.pmh_nm_perusahaan,a.no_aju, 
      a.wk_rekam,a.seri_perubahan,a.kd_jns_permohonan,e.ur_jenis_permohonan,
      a.kd_jns_pemohon, d.ur_jenis_pemohon, a.kd_jns_pengajuan, a.id_skb_jasper as id_cetakan,
      concat(a.kd_jns_pengajuan,a.kd_jns_pemohon) as kd_pengajuan,b.url_kep_skbppn, 
      b.no_kep_skbppn, b.tgl_kep_skbppn,b.keterangan_kep_skbppn,a.kd_proses,
      case
        when a.kd_jns_pengajuan = 'A' then concat('Dengan Masterlist - ',concat(a.kd_jns_pengajuan,a.kd_jns_pemohon))
        else concat('Tanpa Masterlist - ',concat(a.kd_jns_pengajuan,a.kd_jns_pemohon))
      end as jns_pengajuan,
      (select c.ur_proses from nsw_skbppn.tr_proses c where c.kd_proses=a.kd_proses ),
      ROW_NUMBER() OVER (PARTITION BY a.no_aju order by a.seri_perubahan desc) as urut
      from nsw_skbppn.td_skb_header a 
      left join nsw_skbppn.td_skb_keputusan b on a.no_aju = b.no_aju and a.seri_perubahan = b.seri_perubahan
      left join nsw_skbppn.tr_jenis_pengajuan c ON a.kd_jns_pengajuan = c.kd_jenis_pengajuan
      left join nsw_skbppn.tr_jenis_pemohon d ON a.kd_jns_pemohon = d.kd_jenis_pemohon
      left join nsw_skbppn.tr_jenis_permohonan e ON a.kd_jns_permohonan = e.kd_jenis_permohonan 
      WHERE a.pmh_npwp_perusahaan='011466315054000'
      )
      select * from getLastData where urut = 1 order by wk_rekam desc;
  
  
  
  select * from nsw_skbppn.td_skb_header where no_aju='302008F2078F1';
  
  select * from nsw_skbppn.td_log_scheduler_djp where no_aju='302008F2078F1';
  
  
  select * from nsw_skbppn.td_realisasi where id_skb_header = (select x.id_skb_header from nsw_skbppn.td_skb_header x where x.no_aju='3020089B3C534');
  
  
   with getLastData as (select a.id_skb_header,a.pmh_nm_perusahaan,a.no_aju, 
      a.wk_rekam,a.seri_perubahan,a.kd_jns_permohonan,e.ur_jenis_permohonan,
      a.kd_jns_pemohon, d.ur_jenis_pemohon, a.kd_jns_pengajuan, a.id_skb_jasper as id_cetakan,
      concat(a.kd_jns_pengajuan,a.kd_jns_pemohon) as kd_pengajuan,b.url_kep_skbppn, 
      b.no_kep_skbppn, b.tgl_kep_skbppn,b.keterangan_kep_skbppn,a.kd_proses,
      case
        when a.kd_jns_pengajuan = 'A' then concat('Dengan Masterlist - ',concat(a.kd_jns_pengajuan,a.kd_jns_pemohon))
        else concat('Tanpa Masterlist - ',concat(a.kd_jns_pengajuan,a.kd_jns_pemohon))
      end as jns_pengajuan,
      (select c.ur_proses from nsw_skbppn.tr_proses c where c.kd_proses=a.kd_proses ),
      ROW_NUMBER() OVER (PARTITION BY a.no_aju order by a.seri_perubahan desc) as urut
      from nsw_skbppn.td_skb_header a 
      left join nsw_skbppn.td_skb_keputusan b on a.no_aju = b.no_aju and a.seri_perubahan = b.seri_perubahan
      left join nsw_skbppn.tr_jenis_pengajuan c ON a.kd_jns_pengajuan = c.kd_jenis_pengajuan
      left join nsw_skbppn.tr_jenis_pemohon d ON a.kd_jns_pemohon = d.kd_jenis_pemohon
      left join nsw_skbppn.tr_jenis_permohonan e ON a.kd_jns_permohonan = e.kd_jenis_permohonan 
      WHERE a.user_id=$1
      )
      select * from getLastData where urut = 1 order by wk_rekam desc;
  
  select wk_rekam::date as tanggal_aju, wk_kirim:: date as waktu_submit from nsw_skbppn.td_skb_header tsh where no_aju ='3020089B3C534';
  
  select a.id_skb_header, a.id_skb_jasper as id_cetakan , a.no_aju, a.seri_perubahan, a.kd_jns_pengajuan, a.kd_jns_permohonan,(select x.ur_jenis_permohonan
from nsw_skbppn.tr_jenis_permohonan x
where a.kd_jns_permohonan = x.kd_jenis_permohonan) , b.no_kep_skbppn, b.tgl_kep_skbppn, b.url_kep_skbppn, b.keterangan_kep_skbppn, a.kd_proses,(select c.ur_proses
from nsw_skbppn.tr_proses c
where c.kd_proses = a.kd_proses )
from nsw_skbppn.td_skb_header a
left join nsw_skbppn.td_skb_keputusan b on
a.no_aju = b.no_aju
and a.seri_perubahan = b.seri_perubahan
where a.no_aju = '3020089B3C534'
order by seri_perubahan asc;

select * from nsw_skbppn.td_skb_barang as tr where id_skb_header=11541;

-- 2023-10-26 -> 15772
-- 2023-11-03 -> 
select * from referensi.tr_kurs as tk limit 1;


SELECT 
  tsb.id_skb_header, 
  tsb.id_skb_barang, 
  tsb.no_item, 
  tsb.jenis_barang, 
  tsb.hs_code, 
  tsb.spesifikasi, 
  tsb.nilai_ppn, 
  tsb.nilai_valuta, 
  tsb.kd_valuta, 
  tsb.epc_npwp, 
  tsb.fl_mesin_utama, 
  tsb.kd_jenis_pemasukan, 
  tsb.no_item_masterlist, 
  (
    SELECT 
      string_agg(ur_negara, ', ') 
    FROM 
      nsw_skbppn.td_skb_barang_negara tsbn 
      JOIN referensi.tr_negara tn on tsbn.kd_negara = tn.kd_negara 
    where 
      id_skb_barang = b.id_skb_barang
  ) as negara, 
  (
    SELECT 
      string_agg(ur_pelabuhan, ', ') as kd 
    FROM 
      nsw_skbppn.td_skb_barang_pelabuhan tsbp 
      JOIN referensi.tr_pelabuhan tp on tsbp.kd_pelabuhan = tp.kd_pelabuhan 
    WHERE 
      id_skb_barang = b.id_skb_barang
  ) as pelabuhan, 
  (
    SELECT 
      string_agg(ur_satuan, ',') as kd 
    FROM 
      nsw_skbppn.td_skb_barang tb 
      JOIN referensi.tr_satuan ts on tb.kd_satuan = ts.kd_satuan 
    WHERE 
      id_skb_barang = b.id_skb_barang
  ) as satuan, 
  tsb.jml_satuan, 
  tsb.harga_satuan, 
  tsb.kd_satuan, 
  tsb.harga_total, 
  tsb.nilai_rupiah, 
  npwp_pkp_penyerahan, 
  nama_pkp_penyerahan, 
  fl_epc, 
  tsb.fl_btki 
FROM 
  nsw_skbppn.td_skb_barang tsb 
  left join nsw_skbppn.td_skb_barang_pelabuhan b on tsb.id_skb_barang = b.id_skb_barang 
where 
  tsb.id_skb_header = 11541
group by 
  b.id_skb_barang, 
  tsb.id_skb_barang
  
  
  select * from nsw_skbppn.td_realisasi limit 1;
  
  
  with master as (
  select *, row_number() over (partition by jenis_barang order by id_skb_barang_detail ) as urut from nsw_skbppn.td_skb_barang_detail where id_skb_barang=85026)
--  delete from nsw_skbppn.td_skb_barang_detail where id_skb_barang_detail in (select x.id_skb_barang_detail from master)
  select * from master where urut >3
--  select * from master where jenis_barang='PIPE CLAMP W/BOLT & NUT; STEEL 22mm';
  
  select * from nsw_skbppn.td_skb_barang_detail where id_skb_barang=85025;

  select * from nsw_skbppn.td_log_scheduler_djp as tlsd where no_aju='302008F2F9429';

select id_skb_header,no_aju,kd_proses from nsw_skbppn.td_skb_header where no_aju='3020089B3C534'


select * from nsw_skbppn.td_skb_keputusan where no_kep_skbppn='KET-00013/PPN/KPP.0914/2023';


select * from nsw_skbppn.td_skb_keputusan where no_kep_skbppn='KET-00005/PPN/KPP.3010/2024';

select nilai_satuan,nilai_total,nilai_ppn,seri_bc from nsw_skbppn.td_realisasi where id_skb_header = '11541';

select no_kep_bkpm from nsw_skbppn.td_skb_header where no_aju='302008F3BC933'



select id_keputusan, a.no_aju, a.no_kep_skbppn, a.tgl_kep_skbppn, tgl_akhir_skbppn,concat(b.kd_jns_pengajuan,b.kd_jns_permohonan) jenis_skbppn, 
b.no_kep_bkpm
from nsw_skbppn.td_skb_keputusan a
join nsw_skbppn.td_skb_header b on a.no_aju = b.no_aju
where extract(year from tgl_akhir_skbppn)::integer < 
extract(year from a.tgl_kep_skbppn)::integer
order by tgl_kep_skbppn desc;


select seri from nsw_skbppn.td_skb_keputusan where no_aju='302008F3D28B5';


select distinct seri_perubahan from nsw_skbppn.td_skb_header;

select a.no_aju,a.seri_perubahan from nsw_skbppn.td_skb_keputusan a
join nsw_skbppn.td_skb_header b
on a.no_aju = b.no_aju
and a.seri_perubahan = b.seri_perubahan


select * from nsw_skbppn.td_skb_header where no_kep_bkpm='39/PABEAN-PB/OSS/PMA/2023';

select * from nsw_skbppn.td_log_scheduler_djp as tlsd where normalized _aju='302008F3B7B09';


select no_aju, no_kep_bkpm from nsw_skbppn.td_skb_header where no_kep_bkpm ='19/PABEAN-PB/OSS/PMDN/2024';

select no_aju, pmh_status_penanaman_modal from nsw_skbppn.td_skb_header order by wk_kirim desc limit 10;

with getLastData as (select a.id_skb_header,a.pmh_nm_perusahaan,a.no_aju, 
      a.wk_rekam,a.seri_perubahan,a.kd_jns_permohonan,e.ur_jenis_permohonan,
      a.kd_jns_pemohon, d.ur_jenis_pemohon, a.kd_jns_pengajuan, a.id_skb_jasper as id_cetakan,
      concat(a.kd_jns_pengajuan,a.kd_jns_pemohon) as kd_pengajuan,b.url_kep_skbppn, 
      b.no_kep_skbppn, b.tgl_kep_skbppn,b.keterangan_kep_skbppn,a.kd_proses,
      case
        when a.kd_jns_pengajuan = 'A' then concat('Dengan Masterlist - ',concat(a.kd_jns_pengajuan,a.kd_jns_pemohon))
        else concat('Tanpa Masterlist - ',concat(a.kd_jns_pengajuan,a.kd_jns_pemohon))
      end as jns_pengajuan,
      (select c.ur_proses from nsw_skbppn.tr_proses c where c.kd_proses=a.kd_proses ),
      ROW_NUMBER() OVER (PARTITION BY a.no_aju order by a.seri_perubahan desc) as urut
      from nsw_skbppn.td_skb_header a 
      left join nsw_skbppn.td_skb_keputusan b on a.no_aju = b.no_aju and a.seri_perubahan = b.seri_perubahan
      left join nsw_skbppn.tr_jenis_pengajuan c ON a.kd_jns_pengajuan = c.kd_jenis_pengajuan
      left join nsw_skbppn.tr_jenis_pemohon d ON a.kd_jns_pemohon = d.kd_jenis_pemohon
      left join nsw_skbppn.tr_jenis_permohonan e ON a.kd_jns_permohonan = e.kd_jenis_permohonan 
      WHERE a.user_id='967452384067000' limit 20 offset 
      )
      select * from getLastData where urut = 1 order by wk_rekam desc;
  
  
  
  
  select user_id from nsw_skbppn.td_skb_header;
  
  select * from nsw_skbppn.td_skb_barang where id_skb_header = (select x.id_skb_header from nsw_skbppn.td_skb_header x where x.no_aju='302008F3ED669') order by no_item_masterlist::int;
  
  
  select a.id_skb_header,a.id_skb_jasper as id_cetakan ,a.no_aju,a.seri_perubahan,a.kd_jns_pengajuan,a.kd_jns_permohonan,(select x.ur_jenis_permohonan
      from nsw_skbppn.tr_jenis_permohonan x where a.kd_jns_permohonan = x.kd_jenis_permohonan) ,b.no_kep_skbppn, b.tgl_kep_skbppn,b.url_kep_skbppn,b.keterangan_kep_skbppn,a.kd_proses,
    (select c.ur_proses from nsw_skbppn.tr_proses c where c.kd_proses=a.kd_proses )
    from nsw_skbppn.td_skb_header a
    left join nsw_skbppn.td_skb_keputusan b on a.no_aju = b.no_aju 
    and a.seri_perubahan = b.seri_perubahan 
    where a.no_aju ='302008F3ED669' order by seri_perubahan asc;


SELECT
                            tsb.id_skb_header, tsb.id_skb_barang, tsb.no_item, tsb.jenis_barang, tsb.hs_code, tsb.spesifikasi,tsb.nilai_ppn,
                            tsb.nilai_valuta,tsb.kd_valuta,tsb.epc_npwp, tsb.fl_mesin_utama, tsb.kd_jenis_pemasukan, tsb.no_item_masterlist,
                            (
                                SELECT
                                    string_agg(ur_negara , ', ')
                                FROM nsw_skbppn.td_skb_barang_negara tsbn
                                JOIN referensi.tr_negara tn on tsbn.kd_negara = tn.kd_negara
                                where tsbn.id_skb_barang = tsb.id_skb_barang
                            ) as negara,
                            (
                                SELECT string_agg(ur_pelabuhan , ', ') as kd
                                FROM nsw_skbppn.td_skb_barang_pelabuhan tsbp
                                JOIN referensi.tr_pelabuhan tp on tsbp.kd_pelabuhan = tp.kd_pelabuhan
                                where tsbp.id_skb_barang = tsb.id_skb_barang
                            ) as pelabuhan,
                            (
                                SELECT string_agg(ur_satuan , ',') as kd
                                FROM nsw_skbppn.td_skb_barang tb
                                JOIN referensi.tr_satuan ts on tb.kd_satuan = ts.kd_satuan
                                WHERE tb.id_skb_barang = tsb.id_skb_barang
                            ) as satuan, tsb.jml_satuan, tsb.harga_satuan,
                            tsb.kd_satuan, tsb.harga_total, tsb.nilai_rupiah,
                            npwp_pkp_penyerahan, nama_pkp_penyerahan, fl_epc, tsb.fl_btki
                        FROM
                            nsw_skbppn.td_skb_barang tsb
                        where
                            tsb.id_skb_header = 13340 order by  CASE 
                            WHEN tsb.no_item ~ '^[0-9]+$' THEN tsb.no_item::int 
                                ELSE NULL 
                            END ASC NULLS LAST,
                            tsb.no_item ASC;

                        
select * from nsw_skbppnn.td_skb_keputusan limit 10;


select * from nsw_skbppn.td_skb_keputusan where no_aju = 'c';

select * from nsw_skbppn.td_skb_keputusan where no_kep_skbppn='KET-00039/PPN/KPP.2408/2024';

select * from nsw_skbppn.td_skb_keputusan where no_kep_skbppn='KET-00013/PPN/KPP.0411/2024'

select * from nsw_skbppn.td_skb_barang where id_skb_header='11819';


select * from nsw_skbppn.td_realisasi where id_skb_header = (select x.id_skb_header from nsw_skbppn.td_skb_header x where x.no_aju='3020089C180C4');

select * from nsw_skbppn.td_skb_barang where id_skb_header = 11819

                        SELECT
                            tsb.id_skb_header, tsb.id_skb_barang, tsb.no_item, tsb.jenis_barang, tsb.hs_code, tsb.spesifikasi,tsb.nilai_ppn,
                            tsb.nilai_valuta,tsb.kd_valuta,tsb.epc_npwp, tsb.fl_mesin_utama, tsb.kd_jenis_pemasukan, tsb.no_item_masterlist,
                            (
                                SELECT
                                    string_agg(ur_negara , ', ')
                                FROM nsw_skbppn.td_skb_barang_negara tsbn
                                JOIN referensi.tr_negara tn on tsbn.kd_negara = tn.kd_negara
                                where id_skb_barang = tsb.id_skb_barang
                            ) as negara,
                            (
                                SELECT string_agg(ur_pelabuhan , ', ') as kd
                                FROM nsw_skbppn.td_skb_barang_pelabuhan tsbp
                                JOIN referensi.tr_pelabuhan tp on tsbp.kd_pelabuhan = tp.kd_pelabuhan
                                WHERE id_skb_barang = tsb.id_skb_barang
                            ) as pelabuhan,
                            (
                                SELECT string_agg(ur_satuan , ',') as kd
                                FROM nsw_skbppn.td_skb_barang tb
                                JOIN referensi.tr_satuan ts on tb.kd_satuan = ts.kd_satuan
                                WHERE id_skb_barang = tsb.id_skb_barang
                            ) as satuan, tsb.jml_satuan, tsb.harga_satuan,
                            tsb.kd_satuan, tsb.harga_total, tsb.nilai_rupiah,
                            npwp_pkp_penyerahan, nama_pkp_penyerahan, fl_epc, tsb.fl_btki
                        FROM
                            nsw_skbppn.td_skb_barang tsb
                        where
                            tsb.id_skb_header = '11819'
                        order by CASE 
                            WHEN tsb.no_item ~ '^[0-9]+$' THEN tsb.no_item::int 
                                ELSE NULL 
                            END ASC NULLS LAST,
                            tsb.no_item ASC;
         
select * from nsw_skbppn.f_data_jasper_skbppn('9f57fe81-f8e2-4e2f-8c3e-4871ec2e0ae6');


with masterPelabuhan as (with distinctPelabuhan as (select distinct d.kd_pelabuhan
                                                                      from nsw_skbppn.td_skb_barang_pelabuhan d
                                                                      where d.id_skb_barang in (select e.id_skb_barang
                                                                                                from nsw_skbppn.td_skb_barang e
                                                                                                where e.id_skb_header =
                                                                                                      (select f.id_skb_header
                                                                                                       from nsw_skbppn.td_skb_header f
                                                                                                       where f.id_skb_jasper = $1)))
                                           select string_agg(aa.kd_pelabuhan, ', ') as agg_kd_pelabuhan,
                                                  string_agg(ab.ur_pelabuhan, ', ') as agg_pelabuhan,
                                                  string_agg(ac.uraian, ', ')       as agg_kppbc
                                           from distinctPelabuhan aa
                                                    join referensi.tr_pelabuhan ab on aa.kd_pelabuhan = ab.kd_pelabuhan
                                                    left join referensi.tr_kppbc ac on ab.kd_kantor = ac.kd_kppbc)
                  select a.id_skb_header::int,
                         a.pmh_nm_perusahaan,
                         a.pmh_npwp_perusahaan,
                         b.kd_valuta,
                         a.seri_perubahan,
                         c.tgl_akhir_skbppn,
                         c.tgl_kep_skbppn,
--                          c.tgl_akhir_skbppn,
                         a.pmh_alamat_perusahaan || ', ' ||
                         (select concat_ws(', ',
                                           (select ur_lokasi
                                            from nsw_skbppn.tr_lokasi x
                                            where x.kd_lokasi = a.pmh_kecamatan),
                                           (select ur_lokasi
                                            from nsw_skbppn.tr_lokasi x
                                            where x.kd_lokasi = a.pmh_kd_kab_kota),
                                           (select ur_lokasi
                                            from nsw_skbppn.tr_lokasi x
                                            where x.kd_lokasi = a.pmh_kd_provinsi))
                          from nsw_skbppn.td_skb_header b
                          where b.id_skb_header = a.id_skb_header)          as alamat,
                         a.lok_alamat || ', ' ||
                         (select concat_ws(', ',
                                           (select ur_lokasi
                                            from nsw_skbppn.tr_lokasi x
                                            where x.kd_lokasi = a.lok_kecamatan),
                                           (select ur_lokasi
                                            from nsw_skbppn.tr_lokasi x
                                            where x.kd_lokasi = a.lok_kd_kab_kota),
                                           (select ur_lokasi
                                            from nsw_skbppn.tr_lokasi x
                                            where x.kd_lokasi = a.lok_kd_provinsi))
                          from nsw_skbppn.td_skb_header b
                          where b.id_skb_header = a.id_skb_header)          as alamat_proyek,
                         a.epc_no_kontrak,
                         c.no_kep_skbppn,
                         c.no_rkip,
                         c.tgl_kep_skbppn,
                         (select x.tgl_akhir_skbppn
                          from nsw_skbppn.td_skb_keputusan x
                          where x.no_kep_skbppn = a.no_kep_skbppn)        as tgl_akhir_skb_a2,
                         c.tgl_rkip,
                         a.tahun_takwim_mohon                                  tahun_takwim,
                         b.id_skb_barang,
                         (b.no_item)::int,
                         b.hs_code,
                         b.kd_kondisi,
                         b.jenis_barang,
                         b.spesifikasi,
                         b.jml_satuan,
                         b.kd_satuan,
                         b.harga_satuan,
                         trim(REPLACE(
                                 REPLACE(REPLACE(to_char(b.harga_total, '999,999,999,999,999.99'), ',', '|'), '.', ','),
                                 '|',
                                 '.'))                                      as harga_total,
                         trim(REPLACE(
                                 REPLACE(REPLACE(to_char(b.nilai_ppn, '999,999,999,999,999.99'), ',', '|'), '.', ','),
                                 '|',
                                 '.'))                                      as nilai_ppn,
                         (select string_agg(ur_negara, ', ')
                          FROM nsw_skbppn.td_skb_barang_negara tsbn
                                   JOIN referensi.tr_negara tn on tsbn.kd_negara = tn.kd_negara
                          where tsbn.id_skb_barang = b.id_skb_barang)       as negara,
                         (SELECT string_agg(ur_satuan, ',') as kd
                          FROM nsw_skbppn.td_skb_barang tb
                                   JOIN referensi.tr_satuan ts on tb.kd_satuan = ts.kd_satuan
                          WHERE tb.id_skb_barang = b.id_skb_barang)         as satuan,
                         (select x.agg_kd_pelabuhan from masterPelabuhan x) as agg_kd_pelabuhan,
                         (select x.agg_pelabuhan from masterPelabuhan x)    as agg_pelabuhan,
                         (select x.agg_kppbc from masterPelabuhan x)        as agg_kppbc
                  from nsw_skbppn.td_skb_header a
                           left join nsw_skbppn.td_skb_keputusan c
                                     on a.no_aju = c.no_aju and a.seri_perubahan = c.seri_perubahan
                           inner join nsw_skbppn.td_skb_barang b on a.id_skb_header = b.id_skb_header
                  where a.id_skb_jasper = $1
                    and c.no_rkip not like '1'
                  order by (b.no_item)::int;
                  
select * from nsw_skbppn.td_skb_header where id_skb_jasper='9f57fe81-f8e2-4e2f-8c3e-4871ec2e0ae6' and kd_proses = '60';

select uuid_generate_v4();


select count(*),kd_keputusan,from nsw_skbppn.td_skb_keputusan where tgl_kep_skbppn::date between '01-01-2023' and '12-31-2023'::date group by kd_keputusan;



select b.id_skb_barang,b.no_item::int, tsbd.no_sub_item::int,tsbd.jenis_barang from nsw_skbppn.td_skb_barang_detail as tsbd 
join nsw_skbppn.td_skb_barang b on tsbd.id_skb_barang = b.id_skb_barang
join nsw_skbppn.td_skb_header c on b.id_skb_header = c.id_skb_header
where c.no_aju='302008F3ED669' and b.no_item='22'

1. no_aju
2. tgl_aju
3. pmh_npwp_perusahaan
4. pmh_nm_perusahaan
5. kd_jns_permohonan
6. kd_jns_pengajuan
7. kd_jns_pemohon
8. tahun_takwim_mohon
9. no_kep_skbppn
10. tgl_kep_skbppn

select no_aju,wk_kirim::date as tgl_aju,pmh_npwp_perusahaan,
pmh_nm_perusahaan ,kd_jns_pengajuan,kd_jns_pemohon,kd_jns_permohonan,
(select x.ur_proses from nsw_skbppn.tr_proses x where x.kd_proses = a.kd_proses) as ur_proses,
tahun_takwim_mohon
from  nsw_skbppn.td_skb_header a
where wk_kirim::date = '2024-12-19'
and a.kd_proses::integer between 10 and 20


select * from nsw_skbppn.td_skb_epc tse;


select * from nsw_skbppn.tr_jenis_pemohon tjp 


select * from nsw_skbppn.td_skb_barang tsb where id_skb_header='17218'

select * from nsw_skbppn.td_skb_header where no_kep_bkpm ='135/PABEAN/OSS/PMA/2024'

select * from nsw_skbppn.td_realisasi 
where id_skb_header = (select x.id_skb_header from nsw_skbppn.td_skb_header x where x.no_aju='302008FA909E7')





