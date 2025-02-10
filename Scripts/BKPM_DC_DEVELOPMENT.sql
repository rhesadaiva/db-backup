select * from nsw_bkpm.td_bkpm_dtl limit 1;


select * from nsw_bkpm.td_bkpm_negara as tbn;

select * from nsw_bkpm.td_bkpm_hdr where id_permohonan ='KBLBB-2024020714563639387';

select * from nsw_bkpm.td_bkpm_hdr where no_kep like '%TEST%';


select * from nsw_bkpm.td_bkpm_dtl as tbd  where id_hdr='18943';


SELECT * FROM nsw_bkpm.td_log_send_bkpm where id_masterlist ='18952'

select * from nsw_bkpm.td_bkpm_hdr where id_permohonan = 'PA53210'

select id_permohonan,nilai_ppnbm,nilai_bm from nsw_bkpm.td_bkpm_dtl where id_hdr ='18951';

select * from nsw_bkpm.td_log_send_bkpm as tlsb where no_kep_masterlist is not null order by id_log desc;

select a.id_hdr,a.no_kep,b.* from nsw_bkpm.td_bkpm_hdr a
join nsw_bkpm.td_bkpm_dtl b on a.id_hdr = b.id_hdr 
where a.no_kep ='25/KBLBB-CBU/1/OSS/PMDN/2024';

select * from nsw_bkpm.td_bkpm_dtl

select * from nsw_bkpm.td_log_send_bkpm order by id_log desc limit 1 ;

call nsw_bkpm.p_delete_masterlist_id(18974) 


select * from nsw_nle.td_penomoran_open_bidding as tpob;


-- get summary no perizinan
select no_kep as nomor_keputusan,
no_kep_parent as nomor_keputusan_parent,
'0' as seri_perubahan,
tgl_kep as tanggal_keputusan,
npwp_perusahaan,
nib_perusahaan
from nsw_bkpm.td_bkpm_hdr
where no_kep ilike '%kblbb%'
and npwp_perusahaan ='012337556641000'
and nib_perusahaan ='8120310100981'


select * from nsw_bkpm.td_bkpm_hdr where npwp_perusahaan = '012337556641000';

update nsw_bkpm.td_bkpm_hdr set npwp_perusahaan = '012337556641000', nib_perusahaan ='8120310100981' where npwp_perusahaan ='012082988631000' and no_kep ilike '%kblbb%'
returning no_kep, npwp_perusahaan , nib_perusahaan;

select * from nsw_bkpm.td_bkpm_dtl where id_hdr = (select x.id_hdr
from nsw_bkpm.td_bkpm_hdr x where x.no_kep='28/KBLBB-CBU/1/OSS/PMDN/2024')

select no_kep as nomor_keputusan,tgl_kep as tanggal_keputusan,'0' as seri_perubahan,
nib_perusahaan as nib, npwp_perusahaan as npwp,
nm_perusahaan as nama_perusahaan,
tgl_kep as tanggal_awal,
tgl_akhir_berlaku as tanggal_akhir,url_kep_masterlist as cetakan
from nsw_bkpm.td_bkpm_hdr
where no_kep='28/KBLBB-CBU/1/OSS/PMDN/2024';

select row_to_json(t) kblbb
from (
select no_kep as nomor_keputusan,tgl_kep as tanggal_keputusan,'0' as seri_perubahan,
nib_perusahaan as nib, npwp_perusahaan as npwp,
nm_perusahaan as nama_perusahaan,
tgl_kep as tanggal_awal,
tgl_akhir_berlaku as tanggal_akhir,url_kep_masterlist as cetakan,
(select json_agg(x) detail from (
select b.hs_code,b.no_item as seri,
concat(b.jenis_barang,';Merk: ', b.merk, ';Tipe: ',b.tipe,';Model: ',b.model,';Daya Listrik: ',b.daya_listrik,';Kapasitas Baterai: ',b.kapasitas_baterai)
as uraian,'-' as keterangan,b.jml_satuan as jumlah, b.kd_sat as satuan
from nsw_bkpm.td_bkpm_dtl b where b.id_hdr = a.id_hdr
) x )as detail
from nsw_bkpm.td_bkpm_hdr a
where no_kep='28/KBLBB-CBU/1/OSS/PMDN/2024'
)
t;

select * from nsw_bkpm.td_bkpm_negara limit 10;

SELECT id_permohonan,id_permohonan_parent,kd_dokumen,no_dokumen,tgl_dokumen, concat('https://api.insw.go.id/api/report/preview/masterlist-bkpm?p=',(split_part(url_dokumen,'/',8))) as url_dokumen
  FROM nsw_bkpm.td_bkpm_dokumen WHERE id_permohonan=(SELECT id_permohonan FROM nsw_bkpm.td_bkpm_hdr WHERE no_kep=$1 AND tgl_kep=$2)

select 
  row_to_json(t) kblbb 
from 
  (
    select 
      no_kep as nomor_keputusan, 
      tgl_kep as tanggal_keputusan, 
      '0' as seri_perubahan, 
      nib_perusahaan as nib, 
      npwp_perusahaan as npwp, 
      nm_perusahaan as nama_perusahaan, 
      tgl_kep as tanggal_awal, 
      tgl_akhir_berlaku as tanggal_akhir, 
      concat('https://api.insw.go.id/api/report/preview/masterlist-bkpm?p=',(split_part(url_kep_masterlist,'/',8))) as cetakan, 
      (
        select 
          json_agg(x) detail 
        from 
          (
            select 
              b.hs_code, 
              b.no_item as seri, 
              concat(
                b.jenis_barang, ';Merk: ', b.merk, 
                ';Tipe: ', b.tipe, ';Model: ', b.model, 
                ';Daya Listrik: ', b.daya_listrik, 
                ';Kapasitas Baterai: ', b.kapasitas_baterai
              ) as uraian, 
              '-' as keterangan, 
              b.jml_satuan::int as jumlah, 
              b.kd_sat as satuan, 
(
select array_agg(c.kd_negara)
from nsw_bkpm.td_bkpm_negara c 
where c.id_dtl = b.id_dtl
) as negara_asal,
(
select array_agg(c.kd_pelabuhan)
from nsw_bkpm.td_bkpm_pelabuhan c 
where c.id_dtl = b.id_dtl
) as pelabuhan_tujuan
            from 
              nsw_bkpm.td_bkpm_dtl b 
            where 
              b.id_hdr = a.id_hdr
          ) x
      ) as detail,
      (
        select json_agg(t) lampiran
from (select '0400JF3' as kode_dokumen, a.no_kep as nomor_dokumen,a.tgl_kep as tanggal_keputusan, a.tgl_kep as tanggal_awal_berlaku, 
      a.tgl_akhir_berlaku as tanggal_akhir_berlaku,concat('https://api.insw.go.id/api/report/preview/masterlist-bkpm?p=',(split_part(a.url_kep_masterlist,'/',8))) as url) t
        ) as lampiran
    from 
      nsw_bkpm.td_bkpm_hdr a 
    where 
      no_kep = '28/KBLBB-CBU/1/OSS/PMDN/2024'
  ) t;


select split_part('https://api-stg.oss.go.id/stg/v1/file/download/U-202402231404396837618','/',8)  

select concat('https://api.insw.go.id/api/report/preview/masterlist-bkpm?p=',(split_part('https://api-stg.oss.go.id/stg/v1/file/download/U-202402231404396837618','/',8)))

drop view nsw_bkpm.v_masterlist;

select * from nsw_bkpm.td_bkpm_hdr order by id_hdr desc limit 10;

 select
	row_to_json(headernya) as pib
from
	(
	select
		a.id_permohonan,
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
		'https://api.insw.go.id/api/report/preview/masterlist-bkpm?p=' || 
           substring(a.url_kep_masterlist
	from
		'/v[0-9]+/file/download/([^/]+)$') as url_kep_masterlist,
		(
		select
			array_agg(dokumennya) as dokumen
		from
			(
			select
				g.kd_dokumen,
				g.no_dokumen,
				case when g.tgl_dokumen is null then a.tgl_kep else g.tgl_dokumen end as tgl_dokumen,
				'https://api.insw.go.id/api/report/preview/masterlist-bkpm?p=' || 
           substring(g.url_dokumen
			from
				'/v[0-9]+/file/download/([^/]+)$') as url_dokumen
			from
				nsw_bkpm.td_bkpm_dokumen g
			where
				g.id_hdr = a.id_hdr) dokumennya),
		(
		select
			array_agg(detailnya) as detail
		from
			(
			select
				b.id_permohonan,
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
				select
					array_agg(sub_detil) as sub
				from
					(
					select
						c.no_sub_item,
						c.jml_sat,
						c.uraian,
						c.kd_satuan,
						c.hs_code,
						c.harga
					from
						nsw_bkpm.td_bkpm_sub c
					where
						c.id_dtl = b.id_dtl
                                    ) sub_detil
                           ),
				(
				select
					array_agg(negaranya) as negara
				from
					(
					select
						e.kd_negara
					from
						nsw_bkpm.td_bkpm_negara e
					where
						e.id_dtl = b.id_dtl
                                    ) negaranya
                           ),
				(
				select
					array_agg(pelnya) as pelabuhan
				from
					(
					select
						f.kd_pelabuhan
					from
						nsw_bkpm.td_bkpm_pelabuhan f
					where
						f.id_dtl = b.id_dtl
                                    ) pelnya
                           )
			from
				nsw_bkpm.td_bkpm_dtl b
			where
				b.id_hdr = a.id_hdr
				and b.fl_status_item <> 'K'
			order by
				b.no_item asc
                ) detailnya
                  ) as detail
	from
		nsw_bkpm.td_bkpm_hdr a
	where
		no_kep = $1
		and tgl_kep = $2 and npwp_perusahaan=$3
       ) headernya



