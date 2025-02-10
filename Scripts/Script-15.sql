create or replace view td_view_data_bhp_v2 as
select a.id_barang,
       a.uraian_barang,
       a.jumlah_barang,
       a.satuan_barang,
       e.nama_gudang                                                               as lokasi_penimbunan,
       b.kode_status,
       b.tanggal_status,
       c.nomor_register,
       c.tgl_register,
       a.qr_path,
       a.bkc_flag,
       c.kd_satker_input,
       a.kd_jenis_komoditi,
       (select x.ur_komoditi from tr_komoditi_pelanggaran x where a.kd_jenis_komoditi = x.id_komoditi) as ur_komoditi_pelanggaran,
       (select nama_satker b from tr_kpbc b where b.kd_satker = c.kd_satker_input) as nama_satker,
       (select x.ur_dokumen_asal_bhp from tr_dokumen_asal_bhp x where x.id_dokumen = c.dokumen_asal_bhp) as dokumen_asal_barang ,
       a.no_bhp,
       date(f.wk_rekam) as tgl_bhp,
         (select x.keterangan_status from tr_status_barang x where x.id_kode_status = b.kode_status) as keterangan_status
from td_barang a
         join td_view_status_barang b on
    a.id_barang = b.id_barang
         join td_hdr_register_v2 c on
    a.id_register = c.id
         join tr_gudang e on
    a.lokasi_penimbunan = e.kode_gudang
         join tr_status_barang d on 
    b.kode_status = d.id_kode_status
         join td_nomor_bhp f on
    a.id_barang = f.id_barang
order by a.id_barang ASC;

select * from td_view_data_bhp_v2;

select * from td_view_qr_data;

select a.id_barang,
       a.uraian_barang,
       a.jumlah_barang,
       a.satuan_barang,
       e.nama_gudang                                                               as lokasi_penimbunan,
       b.kode_status,
       b.tanggal_status,
       c.nomor_register,
       c.tgl_register,
       a.qr_path,
       a.bkc_flag,
       c.kd_satker_input,
       a.kd_jenis_komoditi,
       (select x.ur_komoditi from tr_komoditi_pelanggaran x where a.kd_jenis_komoditi = x.id_komoditi) as ur_komoditi_pelanggaran,
       (select nama_satker b from tr_kpbc b where b.kd_satker = c.kd_satker_input) as nama_satker,
       a.no_bhp,
       date(a.wk_rekam) as tgl_bhp,
       (select x.ur_dokumen_asal_bhp from tr_dokumen_asal_bhp as x where x.id_dokumen = c.dokumen_asal_bhp) as dokumen_asal_bhp,
       (select x.keterangan_status from tr_status_barang x where x.id_kode_status = b.kode_status) as keterangan_status
from td_barang a
         join td_view_status_barang b on
    a.id_barang = b.id_barang
         join td_hdr_register_v2 c on
    a.id_register = c.id
         join tr_gudang e on
    a.lokasi_penimbunan = e.kode_gudang
         join tr_status_barang d
              on
                  b.kode_status = d.id_kode_status
order by a.id_barang ASC;

select * from td_hdr_register_v2 as thrv;

create or replace view td_view_qr_data_v2 as
select a.id_barang,
       c.nomor_register,
       c.tgl_register,
       a.uraian_barang,
       a.jumlah_barang,
       a.satuan_barang,
       d.keterangan_status,
       (select x.ur_komoditi from tr_komoditi_pelanggaran x where a.kd_jenis_komoditi = x.id_komoditi) as ur_komoditi_pelanggaran,
       a.no_bhp,
       date(a.wk_rekam) as tgl_bhp
from td_barang a
         left join td_view_status_barang b on
    a.id_barang = b.id_barang
         left join td_hdr_register_v2 c on
    a.id_register = c.id
         left join td_detail_pencacahan e on
    c.id = e.id_register
         left join tr_dokumen_register f on
    c.jenis_dokumen_register = f.kode_dokumen
         left join tr_status_barang d
on b.kode_status = d.id_kode_status
order by a.id_barang ASC;
