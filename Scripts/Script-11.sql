WITH base_query AS (
    SELECT a.id_skb_header,
           a.no_aju,
           to_char(wk_rekam, 'DDMMYYYY HH24:MI:SS') as tgl_aju,
           a.kd_jns_permohonan,
           a.kd_jns_pengajuan,
           a.kd_jns_pemohon,
           coalesce(a.no_kep_bkpm,'') as no_kep_bkpm,
           coalesce(to_char(a.tgl_kep_bkpm,'DDMMYYYY'),'') as tgl_kep_bkpm,
           coalesce(a.no_kep_skbppn,'') as no_kep_skbppn,
           coalesce(to_char(a.tgl_kep_skbppn,'DDMMYYYY'),'') as tgl_kep_skbppn,
           a.pmh_npwp_perusahaan,
           a.pmh_nip,
           a.pmh_nm_perusahaan,
           -- Company Information
           a.pmh_kd_badan_usaha,
           a.pmh_status_penanaman_modal,
           -- Location Information
           a.pmh_kd_negara,
           a.pmh_kd_provinsi,
           a.pmh_kd_kab_kota,
           a.pmh_alamat_perusahaan,
           a.pmh_rt,
           a.pmh_rw,
           a.pmh_kelurahan_desa,
           a.pmh_kecamatan,
           a.pmh_kode_pos,
           -- Contact Information
           a.pmh_no_telepon,
           a.pmh_no_faximile,
           a.pmh_email,
           -- PKP Information
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
           -- PJ Information
           a.pmh_pic_nama as pj_nama,
           a.pmh_pic_email as pj_email,
           a.pmh_pic_telepon as pj_no_telepon,
           a.pmh_kd_provinsi as pj_kd_provinsi,
           a.pmh_kd_kab_kota as pj_kd_kab_kota,
           a.pmh_alamat_perusahaan as pj_alamat,
           a.pmh_rt as pj_rt,
           a.pmh_rw as pj_rw,
           a.pmh_kelurahan_desa as pj_kelurahan_desa,
           a.pmh_kecamatan as pj_kecamatan,
           a.pmh_kode_pos as pj_kode_pos,
           -- Location Details
           a.lok_kd_provinsi,
           a.lok_kd_kab_kota,
           a.lok_alamat,
           a.lok_rt,
           a.lok_rw,
           a.lok_kelurahan_desa,
           a.lok_kecamatan,
           a.lok_kode_pos,
           -- Additional Information
           a.tahun_takwim_mohon,
           a.fl_pkp_listrik,
           a.epc_no_kontrak, 
           coalesce(to_char(a.epc_tgl_kontrak,'DDMMYYYY'),'') as epc_tgl_kontrak, 
           a.total_harga as harga_total,
           a.total_ppn as nilai_ppn,
           a.seri_perubahan
    FROM nsw_skbppn.td_skb_header a
    WHERE a.no_aju = $1 
--    AND a.seri_perubahan = $2
    LIMIT 1
),
bkpm_expiry AS (
    SELECT h.tgl_akhir_berlaku
    FROM nsw_bkpm.td_bkpm_hdr h
    WHERE h.no_kep = (SELECT no_kep_bkpm FROM base_query)
),
skbppn_expiry AS (
    SELECT tgl_akhir_skbppn
    FROM nsw_skbppn.td_skb_keputusan
    WHERE no_kep_skbppn = (SELECT no_kep_skbppn FROM base_query)
),
epc_data AS (
    SELECT COALESCE(json_agg(
        json_build_object(
            'epc_npwp_perusahaan', b.epc_npwp_perusahaan,
            'epc_nm_perusahaan', b.epc_nm_perusahaan,
            'epc_kd_badan_usaha', b.epc_kd_badan_usaha,
            'epc_status_penanaman_modal', b.epc_status_penanaman_modal,
            'epc_kd_negara', b.epc_kd_negara,
            'epc_kd_provinsi', b.epc_kd_provinsi,
            'epc_kd_kab_kota', b.epc_kd_kab_kota,
            'epc_alamat_perusahaan', b.epc_alamat_perusahaan,
            'epc_rt', b.epc_rt,
            'epc_rw', b.epc_rw,
            'epc_kelurahan_desa', b.epc_kelurahan_desa,
            'epc_kecamatan', b.epc_kecamatan,
            'epc_kode_pos', b.epc_kode_pos,
            'epc_no_telepon', b.epc_no_telepon,
            'epc_no_faximile', b.epc_no_faximile,
            'epc_email', b.epc_email,
            'no_kontrak_epc', b.epc_no_kontrak,
            'tgl_kontrak_epc', to_char(b.epc_tgl_kontrak,'DDMMYYYY')
        )
    ), '[]'::json) as epc
    FROM nsw_skbppn.td_skb_epc b
    WHERE b.id_skb_header = (SELECT id_skb_header FROM base_query)
),
dokumen_data AS (
    SELECT json_agg(
        json_build_object(
            'kd_jenis_dokumen', c.kd_jenis_dokumen,
            'no_dokumen', c.no_dokumen,
            'url_dokumen', c.url_dokumen,
            'tgl_dokumen', c.tgl_dokumen
        )
    ) as dokumen
    FROM nsw_skbppn.td_skb_dokumen c
    WHERE c.id_skb_header = (SELECT id_skb_header FROM base_query)
),
barang_data AS (
    SELECT json_agg(
        json_build_object(
            'no_item', d.no_item,
            'jenis_barang', d.jenis_barang,
            'spesifikasi', d.spesifikasi,
            'jml_satuan', d.jml_satuan,
            'kd_satuan', d.kd_satuan,
            'kd_kondisi', d.kd_kondisi,
            'harga_satuan', d.harga_satuan,
            'harga_total', d.nilai_rupiah,
            'nilai_ppn', d.nilai_ppn,
            'hs_code', d.hs_code,
            'fl_berlaku', d.fl_berlaku,
            'jml_satuan_terpakai', d.jml_satuan_terpakai,
            'jml_satuan_sisa', d.jml_satuan_sisa,
            'no_surat', d.no_surat,
            'npwp_pkp_penyerahan', d.npwp_pkp_penyerahan,
            'nama_pkp_penyerahan', d.nama_pkp_penyerahan,
            'fl_epc', d.fl_epc,
            'epc_npwp', d.epc_npwp,
            'kd_jenis_pemasukan', d.kd_jenis_pemasukan,
            'npwp_penjual', d.npwp_penjual,
            'nama_penjual', d.nama_penjual,
            'subItem', (
                SELECT coalesce (
                json_agg(
                    json_build_object(
                        'no_sub_item', e.no_sub_item,
                        'hs_code', e.hs_code,
                        'jenis_barang', e.jenis_barang,
                        'jml_satuan', e.jml_satuan,
                        'kd_satuan', e.kd_satuan,
                        'harga_satuan', e.harga_satuan
                    )
                ),'[]'::json
                )
                FROM nsw_skbppn.td_skb_barang_detail e
                WHERE e.id_skb_barang = d.id_skb_barang
            ),
            'negara', (
                SELECT json_agg(f.kd_negara)
                FROM nsw_skbppn.td_skb_barang_negara f
                WHERE f.id_skb_barang = d.id_skb_barang
            ),
            'pelabuhan', (
                SELECT json_agg(g.kd_pelabuhan)
                FROM nsw_skbppn.td_skb_barang_pelabuhan g
                WHERE g.id_skb_barang = d.id_skb_barang
            )
        )
    ) as barang
    FROM nsw_skbppn.td_skb_barang d
    WHERE d.id_skb_header = (SELECT id_skb_header FROM base_query)
)

SELECT row_to_json(result) as getSKBPPN
FROM (
    SELECT 
        bq.*,
        be.tgl_akhir_berlaku as tgl_akhir_kep_bkpm,
        se.tgl_akhir_skbppn as tgl_akhir_kep_skbppn,
        ed.epc,
        dd.dokumen,
        bd.barang
    FROM base_query bq
    LEFT JOIN bkpm_expiry be ON true
    LEFT JOIN skbppn_expiry se ON true
    LEFT JOIN epc_data ed ON true
    LEFT JOIN dokumen_data dd ON true
    LEFT JOIN barang_data bd ON true
) result;