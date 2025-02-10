SELECT
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
	x.no_aju AS "billing",
	n.path_file
FROM
	nsw_ppbj.td_header n
LEFT JOIN nsw_ppbj.td_kontrak td ON
	td.no_aju = n.no_aju
LEFT JOIN nsw_ppbj.tr_proses tp ON
	tp.kd_proses = n.kd_status
FULL JOIN nsw_ppbj.td_bpn_aju x ON
	x.no_aju = n.no_aju
WHERE
	n.show = 'true'
and
n.npwp_kpbpb ='027681030529000'
ORDER BY
	n.id_header ASC
--          offset $1
LIMIT $2


select count(no_aju) as total
from
(select a.no_aju, b.no_kontrak from nsw_ppbj.td_header a 
 left join nsw_ppbj.td_kontrak b on a.no_aju = b.no_aju
 where a.npwp_kpbpb = '027681030529000') master;


select  nm_perusahaan_kpbpb  from nsw_ppbj.td_header where no_aju ='3000089A4AD99';


select * from nsw_ppbj.td_header as th where no_aju ='3000089C32FBB';


select * from nsw_ppbj.td_log_integrasi_ppbj as tlip where no_aju='3000089C32FBB';

select distinct on (npwp_kpbpb) npwp_kpbpb, no_aju,nm_perusahaan_kpbpb, id_header from nsw_ppbj.td_header order by npwp_kpbpb desc limit 10;

select * from nsw_ppbj.td_header as th where no_aju ='300008F211840';


select no_aju,kd_status from nsw_ppbj.td_header where no_aju ='3000083BA644F'

select a.no_aju,b.no_ppbj,b.tgl_ppbj,a.kd_status
    from nsw_ppbj.td_header a 
    join nsw_ppbj.td_kontrak b on a.no_aju = b.no_aju 
    join nsw_ppbj.td_log_integrasi_ppbj c on a.no_aju = c.no_aju
    where a.no_aju='3000083BA644F' and a.kd_status::integer = 10
    and c.djp_response::text ilike '%duplikat%';


with master as ( select a.no_aju,a.kd_status,b.tgl_ppbj from nsw_ppbj.td_header a
join nsw_ppbj.td_kontrak b on a.no_aju  = b.no_aju
join nsw_ppbj.td_log_integrasi_ppbj as tlip on a.no_aju = tlip.no_aju 
where a.kd_status::integer < 20
and tlip.djp_response::text ilike '%duplikat%' order by b.tgl_ppbj desc)
select * from master;

update nsw_ppbj.td_header set kd_status='60' where no_aju ='3000089A4AD99' returning no_aju,kd_status;

select * from nsw_ppbj.td_log_integrasi_ppbj as tlip where no_aju ='3000083BA644F';

select * from nsw_ppbj.td_kontrak where no_aju='3000083BA644F';

-- reset aju
update nsw_ppbj.td_kontrak set no_ppbj = null, tgl_ppbj = null 
where no_aju='3000083BA644F' returning no_aju,tgl_ppbj,no_ppbj

update nsw_ppbj.td_header set kd_status='10'
where no_aju='3000083BA644F' returning no_aju,kd_status;


select a.no_aju,b.no_ppbj,b.tgl_ppbj,a.kd_status
    from nsw_ppbj.td_header a 
    join nsw_ppbj.td_kontrak b on a.no_aju = b.no_aju 
    join nsw_ppbj.td_log_integrasi_ppbj c on a.no_aju = c.no_aju
    where a.no_aju='3000083BA644F'  and a.kd_status <> '00' and a.kd_status::integer = 10
    and c.djp_response::text ilike '%duplikat%';


select count(*) as total_duplikat
    from nsw_ppbj.td_log_integrasi_ppbj as tlip
    where no_aju = '3000083BA644F'
    and djp_response::text ilike '%duplikat%';

select * from nsw_ppbj.td_header where no_aju ='300008F3B7DBD';

select * from nsw_ppbj.tr_proses as tp;


select * from nsw_ppbj.td_header where no_aju='300008F59B2E1';


-- TEST GET DATA CTAS
select row_to_json(dataPPBJ) as ppbj
    from (
             select left(b.no_ppbj, 3)                                                               as kode,
                    a.no_aju                                                                         as "noAju",
                    b.pembetulan_ke                                                                  as "noSeri",
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
                                                   a.nomor_identitas_lawan_transaksi                                      as no
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
                                                      d.nilai_barang_rupiah                                               as "nilaiTransaksi",
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
                                                     then floor(sum(x.nilai_dpp::numeric))
                                                 else floor(sum(x.nilai_dpp::numeric)) end
                                      from nsw_ppbj.td_rincian x
                                      where x.no_aju = a.no_aju)              as "dpp",
                                     case
                                         when (select sum(x.uang_muka::numeric)
                                               from nsw_ppbj.td_rincian x
                                               where x.no_aju = a.no_aju) is null then 0
                                         else (select case
                                                          when floor(sum(x.uang_muka)) <> ceiling(sum(x.uang_muka::numeric))
                                                              then sum(x.uang_muka)
                                                          else floor(sum(x.uang_muka::numeric)) end
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
             where a.no_aju = '300008F1F1DCFnpwp1615'
         ) dataPPBJ;




select * from nsw_ppbj.td_bpn_aju tba




