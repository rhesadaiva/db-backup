select row_to_json(skbppn) as getSKBPPN
    from (
             select a.no_aju,
                    to_char(wk_rekam, 'DDMMYYYY') as tgl_aju,
                    a.kd_jns_permohonan,
                    a.kd_jns_pengajuan,
                    a.kd_jns_pemohon,
                    a.no_kep_bkpm,
                    case when a.tgl_kep_bkpm is null then '' else to_char(a.tgl_kep_bkpm,'DDMMYYYY') end as tgl_kep_bkpm,
                    case when a.no_kep_bkpm is null or a.no_kep_bkpm = '' then '' else (
                    select to_char(h.tgl_akhir_berlaku, 'DDMMYYYY')
                     from nsw_bkpm.td_bkpm_hdr h
                     where h.no_kep = a.no_kep_bkpm) end as tgl_akhir_kep_bkpm,
                    a.no_kep_skbppn,
                     case when a.tgl_kep_skbppn is null then '' else to_char(a.tgl_kep_skbppn,'DDMMYYYY') end as tgl_kep_skbppn,
--                    (select tgl_akhir_skbppn
--                     from nsw_skbppn.td_skb_keputusan
--                     where td_skb_keputusan.no_kep_skbppn = a.no_kep_skbppn)   as tgl_akhir_kep_skbppn,
                      case when a.no_kep_skbppn is null or a.no_kep_skbppn = '' then '' else (
                    select to_char(x.tgl_akhir_skbppn, 'DDMMYYYY')
                     from nsw_skbppn.td_skb_keputusan x
                     where x.no_kep_skbppn = a.no_kep_skbppn) end as tgl_akhir_kep_skbppntgl_akhir_kep_skbppntgl_akhir_kep_skbppntgl_akhir_kep_skbppntgl_akhir_kep_skbppntgl_akhir_kep_skbppntgl_akhir_kep_skbppntgl_akhir_kep_skbppntgl_akhir_kep_skbppntgl_akhir_kep_skbppntgl_akhir_kep_skbppntgl_akhir_kep_skbppntgl_akhir_kep_skbppntgl_akhir_kep_skbppn,
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
                    a.pmh_pic_nama                               as pj_nama,
                    a.pmh_pic_email                              as pj_email,
                    a.pmh_pic_telepon                            as pj_no_telepon,
                    a.pmh_kd_provinsi                            as pj_kd_provinsi,
                    a.pmh_kd_kab_kota                            as pj_kd_kab_kota,
                    a.pmh_alamat_perusahaan                      as pj_alamat,
                    a.pmh_rt                                     as pj_rt,
                    a.pmh_rw                                     as pj_rw,
                    a.pmh_kelurahan_desa                         as pj_kelurahan_desa,
                    a.pmh_kecamatan                              as pj_kecamatan,
                    a.pmh_kode_pos                               as pj_kode_pos,
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
                    a.epc_no_kontrak                             as no_kontrak_epc,
                    a.epc_tgl_kontrak                            as tgl_kontrak_epc,
                    a.total_harga                                as "harga_total",
                    a.total_ppn                                  as "nilai_PPN",
                    a.seri_perubahan,
                    (
                        select json_agg(getepc)
                        from (
                                 select b.epc_npwp_perusahaan,
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
                                 where a.id_skb_header = b.id_skb_header
                             ) getepc
                    )                                            as epc,
                    (
                        select json_agg(getdokumen)
                        from (
                                 select c.kd_jenis_dokumen,
                                        c.no_dokumen,
                                        c.url_dokumen as url_dokumen,
                                        c.tgl_dokumen
                                 from nsw_skbppn.td_skb_dokumen c
                                 where a.id_skb_header = c.id_skb_header
                             ) getdokumen
                    )                                            as dokumen,
                    (
                        select json_agg(detailnya)
                        from (
                                 select d.no_item,
                                        d.jenis_barang,
                                        d.spesifikasi,
                                        d.jml_satuan,
                                        d.kd_satuan,
                                        d.kd_kondisi,
                                        d.harga_satuan,
                                        d.nilai_rupiah as harga_total,
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
                                        (
                                            select json_agg(subnya)
                                            from (
                                                     select e.no_sub_item,
                                                            e.hs_code,
                                                            e.jenis_barang,
                                                            e.jml_satuan,
                                                            e.kd_satuan,
                                                            e.harga_satuan
                                                     from nsw_skbppn.td_skb_barang_detail e
                                                     where d.id_skb_barang = e.id_skb_barang
                                                 ) subnya
                                        ) as subItem,
                                        (
                                            select json_agg(negaranya)
                                            from (
                                                     select f.kd_negara
                                                     from nsw_skbppn.td_skb_barang_negara f
                                                     where d.id_skb_barang = f.id_skb_barang
                                                 ) negaranya
                                        ) as negara,
                                        (
                                            select json_agg(pelnya)
                                            from (
                                                     select g.kd_pelabuhan
                                                     from nsw_skbppn.td_skb_barang_pelabuhan g
                                                     where d.id_skb_barang = g.id_skb_barang
                                                 ) pelnya
                                        ) as pelabuhan
                                 from nsw_skbppn.td_skb_barang d
                                 where a.id_skb_header = d.id_skb_header
                             ) detailnya
                    )                                            as barang
             from nsw_skbppn.td_skb_header a
           where a.no_aju='302008FC89FD2'
            limit 1
         ) skbppn;