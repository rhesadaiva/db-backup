-- reset pengiriman, delete log dan reset status
select * from nsw_ppbj.td_kontrak where no_ppbj like any(array[$1])

select no_aju from nsw_ppbj.td_kontrak where no_ppbj like'%25011748954'

select * from nsw_ppbj.td_log_integrasi_ppbj tlip where no_aju ='3000095143815'

select * from nsw_ppbj.td_log_integrasi_ppbj tlip where no_aju in ($1);
-- delete log
delete from nsw_ppbj.td_log_integrasi_ppbj where no_aju in ($1) returning *;

-- update status
update nsw_ppbj.td_header set kd_status ='10' where no_aju in ($1) returning *

select * from nsw_ppbj.td_kontrak where no_ppbj = '00025011752784'

select * from nsw_ppbj.td_log_integrasi_ppbj tlip where no_aju ='3000095145EFB-011';


select json_agg(json_build_object('no_aju',no_aju))
from nsw_ppbj.td_header where no_aju in ($1);

--test
with uruts as (
select
    *,
--    split_part(no_aju, '-', 1) as base_aju,
    row_number() over(partition by split_part(no_aju, '-', 1) order by pembetulan_ke desc) as urutnya
from
    nsw_ppbj.td_kontrak
where
    no_ppbj like any(array[$1]))
select
    no_aju,
    pembetulan_ke
from
    uruts
where
    urutnya = 1
    
    
select
	*
from
	nsw_ppbj.td_log_integrasi_ppbj tlip
where
	payload_send::varchar not like '%ppbj%'
	and created_at::date = '2025-01-15';
	

select * from nsw_ppbj.td_log_integrasi_ppbj tlip where created_at::date between '2025-01-01' and now()::date and djp_response::varchar ilike '%gagal%'



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
                                                      round(d.nilai_barang_rupiah,2) as "nilaiTransaksi",
                                                      d.jumlah_barang as "jmlBarang",
--                                                      case when
--                                                      (d.nilai_barang_rupiah::numeric / d.jumlah_barang::numeric) <> floor((d.nilai_barang_rupiah::numeric / d.jumlah_barang::numeric))
--                                                      then trunc((d.nilai_barang_rupiah::numeric / d.jumlah_barang::numeric),2)::varchar
--                                                      else round((d.nilai_barang_rupiah::numeric / d.jumlah_barang::numeric),2)::varchar
                                                      round((d.nilai_barang_rupiah/d.jumlah_barang))::varchar as "hrgSatuan", 
                                                      split_part(d.satuan_barang, '-', 1)                                 as satuan
                                               from nsw_ppbj.td_rincian d
                                               where d.no_aju = a.no_aju
                                           ) rincian)                         as rincian,
                                     (select sum(x.nilai_barang_rupiah)
                                      from nsw_ppbj.td_rincian x
                                      where x.no_aju = a.no_aju)              as "ttlNilaiTransaksi",
                                      case 
                                      	when (select sum(x.nilai_dpp) from nsw_ppbj.td_rincian x
                                               where x.no_aju = a.no_aju) is null then '0'
                                      	else         (select case
                                                 when floor(sum(x.nilai_dpp)) <> ceiling(sum(x.nilai_dpp))
                                                     then (round(sum(x.nilai_dpp::numeric)))::varchar
                                                 else (round(sum(x.nilai_dpp::numeric)))::varchar end
                                      from nsw_ppbj.td_rincian x 	
                                      where x.no_aju = a.no_aju)             
                                      end  as "dasarPengenaanPajak",
                                     case
                                         when (select sum(x.uang_muka::numeric)
                                               from nsw_ppbj.td_rincian x
                                               where x.no_aju = a.no_aju) is null then '0'
                                         else (select case
                                                          when floor(sum(x.uang_muka)) <> ceiling(sum(x.uang_muka::numeric))
                                                              then (sum(x.uang_muka))::varchar
                                                          else (round(sum(x.uang_muka::numeric)))::varchar end
                                               from nsw_ppbj.td_rincian x
                                               where x.no_aju = a.no_aju) end as "uangMuka",
                                     (select round(sum(x.nilai_ppn_terutang))
                                      from nsw_ppbj.td_rincian x
                                      where x.no_aju = a.no_aju)              as "ppnTerhutang",
                                     (select case
                                                 when (sum(x.nilai_ppn_terutang)) = 0 then 0
                                                 else round(sum(x.nilai_ppn_fasilitas)) end
                                      from nsw_ppbj.td_rincian x
                                      where x.no_aju = a.no_aju)              as "ppnFasilitas",
                                     (select case
                                     	when (sum(x.nilai_ppnbm_terutang)) = 0 then 0
                                     	else round(sum(x.nilai_ppnbm_terutang))
                                     end
                                     from nsw_ppbj.td_rincian x
                                      where x.no_aju = a.no_aju)              as "ppnbmTerhutang",
                                     (select case
                                                 when (sum(x.nilai_ppnbm_fasilitas)) = null then null
                                                 else round(sum(x.nilai_ppnbm_terutang)) end
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
         

-- tes
select nilai_barang_rupiah,
jumlah_barang,(nilai_barang_rupiah/jumlah_barang) as harga_satuan,
((nilai_barang_rupiah/jumlah_barang) * jumlah_barang)  as nilai_barang_rupiah_baru
from nsw_ppbj.td_rincian where no_aju = $1;

64274240	3705	17347.973009446694	64274240.000000001270

select (3705 * 17347.973009446694)

-- query improvement
WITH 
rincian_agg AS (
    WITH calculated_values AS (
        SELECT 
            no_aju,
            (nilai_barang_rupiah/jumlah_barang) * jumlah_barang as nilai_transaksi_calc,
            kd_jns_barang,
            hs_code,
            ur_barang,
            jumlah_barang,
            nilai_barang_rupiah,
            satuan_barang,
            nilai_ppn_terutang,
            nilai_ppn_fasilitas,
            nilai_ppnbm_terutang,
            nilai_ppnbm_fasilitas,
            nilai_dpp,
            uang_muka
        FROM nsw_ppbj.td_rincian
    )
    SELECT 
        no_aju,
        json_agg(
            json_build_object(
                'jnsBarang', CASE 
                    WHEN kd_jns_barang = 'Bahan Baku' THEN '1'
                    WHEN kd_jns_barang = 'Barang Modal' THEN '2'
                    WHEN kd_jns_barang = 'Barang Konsumsi' THEN '3'
                END,
                'kdHS', hs_code,
                'urBarang', ur_barang,
                'jmlBarang', jumlah_barang,
                'hrgSatuan', (nilai_barang_rupiah/jumlah_barang)::varchar,
                'nilaiTransaksi', nilai_transaksi_calc::varchar,
                'satuan', split_part(satuan_barang, '-', 1)
            )
        ) AS rincian_json,
        sum(nilai_transaksi_calc) as total_nilai_transaksi,
        round(COALESCE(sum(nilai_dpp), 0))::varchar as dasar_pengenaan_pajak,
        round(COALESCE(sum(uang_muka::numeric), 0))::varchar as uang_muka,
        round(sum(nilai_ppn_terutang), 0) as ppn_terhutang,
        round(sum(nilai_ppn_fasilitas),0) as ppn_fasilitas,
        round(sum(nilai_ppnbm_terutang), 0) as ppnbm_terhutang,
        round(sum(nilai_ppnbm_fasilitas), 0) as ppnbm_fasilitas
    FROM calculated_values
    GROUP BY no_aju
),
info_terkait AS (
    SELECT 
        a.no_aju,
        json_agg(
            json_build_object(
                'noDokPabean', g.no_dokumen_pabean,
                'tglDokPabean', COALESCE(g.tgl_dokumen::varchar, ''),
                'ntpnPelunasan', json_build_object('no', null, 'tgl', null, 'nilai', null),
                'rencPenggunaanBarang', json_build_object(
                    'tglAwal', g.wk_mulai_rencana_jangka_waktu,
                    'tglAkhir', g.wk_selesai_rencana_jangka_waktu
                ),
                'tujPenggunaanBarang', g.tujuan_penggunaan_barang,
                'rincianBKP', (
                    SELECT json_agg(
                        json_build_object(
                            'jnsBarang', CASE 
                                WHEN h.kd_jenis_barang = 'Bahan Baku' THEN '1'
                                WHEN h.kd_jenis_barang = 'Barang Modal' THEN '2'
                                WHEN h.kd_jenis_barang = 'Barang Konsumsi' THEN '3'
                            END,
                            'kdHS', h.hs_code,
                            'urBarang', h.ur_barang,
                            'nilaiTransaksi', h.nilai_barang_rupiah
                        )
                    )
                    FROM nsw_ppbj.td_rincian_informasi_terkait h
                    WHERE h.no_aju = g.no_aju
                ),
                'ttlNilaiTransaksi', (
                    SELECT sum(h.nilai_barang_rupiah)
                    FROM nsw_ppbj.td_rincian_informasi_terkait h
                    WHERE h.no_aju = g.no_aju
                )
            )
        ) AS info_json
    FROM nsw_ppbj.td_header a
    JOIN nsw_ppbj.td_informasi_terkait g ON a.no_aju = g.no_aju
    GROUP BY a.no_aju
)
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
           NULLIF(right(b.kd_tujuan, 1), '-')                                               as "tujBarang",
           NULLIF(b.kd_bkpb_berwujud_tidak_ppn, '-')                                        as "bkpNonPPN",
           
           json_build_object(
               'nama', a.nm_perusahaan_kpbpb,
               'npwp', a.npwp_kpbpb,
               'alamat', a.alamat_perusahaan_kpbpb,
               'kppTerdaftar', left(a.kpp_perusahaan_kpbpb, 3)
           ) as "pengusahaKPBPB",
           
           json_build_object(
               'nama', a.nm_perusahaan_lawan_transaksi,
               'id', json_build_array(json_build_object(
                   'jnsID', CASE WHEN a.jns_identitas_lawan_transaksi = 'np' THEN '5' ELSE '3' END,
                   'no', a.nomor_identitas_lawan_transaksi::bigint
               )),
               'kppTerdaftar', left(a.kpp_lawan_transaksi, 3)
           ) as "lawanTransaksi",
           
           json_build_object(
               'noKontrak', b.no_kontrak,
               'tglKontrak', b.tgl_kontrak,
               'nilaiKontrak', b.nilai_kontrak,
               'valuta', upper(b.valuta_kontrak),
               'rincian', r.rincian_json,
               'ttlNilaiTransaksi', r.total_nilai_transaksi,
               'dasarPengenaanPajak', r.dasar_pengenaan_pajak,
               'uangMuka', r.uang_muka,
               'ppnTerhutang', round(r.ppn_terhutang),
               'ppnFasilitas', CASE WHEN r.ppn_terhutang = 0 THEN 0 ELSE round(r.ppn_fasilitas) END,
               'ppnbmTerhutang', CASE WHEN r.ppnbm_terhutang = 0 THEN 0 ELSE round(r.ppnbm_terhutang) END,
               'ppnbmFasilitas', COALESCE(round(r.ppnbm_fasilitas), 0)
           ) as "kontrakPenyerahan",
           
           CASE 
               WHEN EXISTS (SELECT 1 FROM nsw_ppbj.td_informasi_terkait WHERE no_aju = a.no_aju)
               THEN (SELECT info_json FROM info_terkait WHERE no_aju = a.no_aju)
           END as "infoBKP",
           
           (
               SELECT json_agg(json_build_object(
                   'noRek', nomor_rekening,
                   'nama', nama_pemilik_rekening,
                   'nmBank', kd_bank
               ))
               FROM nsw_ppbj.td_rekening f
               WHERE f.no_aju = a.no_aju
           ) as "rekPembayaran",
           
           json_build_object(
               'nama', a.nm_penandatangan,
               'jabatan', a.jabatan_penandatangan,
               'kota', left(a.kota_penandatangan, 3),
               'tgl', to_char(a.wk_rekam, 'yyyy-mm-dd')
           ) as "penandatangan"  
    from nsw_ppbj.td_header a
    left join nsw_ppbj.td_kontrak b on a.no_aju = b.no_aju
    left join rincian_agg r on a.no_aju = r.no_aju
    where a.no_aju = $1
) dataPPBJ;

select json_agg(
	json_build_object('no_aju',no_aju)
) from nsw_ppbj.td_header where kd_status in ('10','98')
and wk_rekam::date between '2025-01-01' and now()::date


select count(no_aju) from nsw_ppbj.td_header where kd_status in ('10','98')
and wk_rekam::date between '2025-01-01' and now()::date

select * from nsw_ppbj.td_kontrak where no_aju='30000951377B0'



select round(2391.6)
        