
select th.id_header id_header_parent, i.* from
    (select a.id_header, a.no_pengajuan, pb.kd_kantor,
      (select tk3.uraian from referensi.tr_kppbc tk3 where pb.kd_kantor = tk3.kd_kppbc) ur_kppbc, pb.kd_pelabuhan, pb.ur_pelabuhan,
      a.kd_ga, (select ur_ga from referensi.tr_ga b where a.kd_ga=b.kd_ga) ur_ga, 
        a.kd_perijinan, (select c.uraian_dokumen from referensi.tr_dokumen c where a.kd_perijinan = c.id_dokumen) ur_perijinan,
        a.no_perijinan, a.no_perijinan_parent, to_char(a.tgl_perijinan::date, 'YYYY-MM-DD') as tgl_perijinan,a.npwp,a.nama,a.wk_pengiriman, a.status_dokumen,
        (select d.ur_status_dokumen from nsw_potong_kuota.tr_status_dokumen d where a.status_dokumen=d.kd_status_dokumen) AS status,
        a.kd_jns_dokumen,
        (select e.ur_jenis_dokumen from nsw_potong_kuota.tr_jns_dokumen e where a.kd_jns_dokumen=e.kd_jenis_dokumen) AS jenis_dokumen,
        (select g.uraian from nsw_potong_kuota.tr_jns_dokumen_final g where a.kd_jns_dokumen_final=g.kd_jns_dokumen_final) AS jenis_dokumen_final,
        case 
        when (select count(id_kuota) from nsw_potong_kuota.td_komoditi where id_header = a.id_header) = 0 then 'Non Kuota'
        when h.jml_sisa > 0 then 'Tersedia' else 'Tidak Tersedia' end status_kuota
    from nsw_potong_kuota.td_header a 
        left join (select d.id_header, sum(d.jml_sisa) jml_sisa from (
      select a.id_header, a.id_komoditi,
      case
      when c.jml_terpakai_subkom is null then sum(b.jml_sisa)
      when b.jml_terpakai > 0 then sum(b.jml_sisa) 
      else sum(c.jml_sisa_subkom) end jml_sisa
      from nsw_potong_kuota.td_komoditi a
      left join nsw_potong_kuota.td_kuota b 
      on a.id_kuota = b.id_kuota
      left join (select tk3.id_komoditi, sum(tk5.jml_kuota) jml_kuota_subkom, sum(tk5.jml_terpakai) jml_terpakai_subkom, sum(tk5.jml_sisa) jml_sisa_subkom 
      from nsw_potong_kuota.td_komoditi tk3
      left join nsw_potong_kuota.td_komoditisub tk4 on tk3.id_komoditi = tk4.id_komoditi
      left join nsw_potong_kuota.td_kuota tk5 on tk4.id_kuota = tk5.id_kuota
      group by tk3.id_komoditi) c on a.id_komoditi = c.id_komoditi
      group by a.id_header, a.id_komoditi, b.jml_terpakai, c.jml_terpakai_subkom) d
      group by d.id_header) h on a.id_header = h.id_header
        left join nsw_potong_kuota.pelabuhan_bongkar pb on a.id_header = pb.id_header
       group by a.id_header, pb.kd_kantor, pb.kd_pelabuhan, pb.ur_pelabuhan, h.jml_sisa 
       order by pb.kd_kantor) i
       left join nsw_potong_kuota.td_header th on i.no_perijinan_parent = th.no_perijinan 
       
       
       
select * from nsw_bkpm.td_bkpm_hdr where no_kep=''

select * from nsw_bkpm.td_bkpm_negara as tbn;

select * from nsw_bkpm.td_bkpm_dtl where id_hdr='17305';    


select * from nsw_bkpm.td_bkpm_hdr
where no_kep  ='01/KBLBB-CBU/1/OSS/PMDN/2024';

call nsw_bkpm.p_delete_masterlist_id(18963) 

select * from nsw_potong_kuota.td_komoditi_spesifikasi_teknis as tkst;


select * from nsw_potong_kuota.td_header
where no_perijinan ='05/KBLBB-CBU/1/OSS/PMDN/2024'

select a.id_komoditi,a.uraian,b.merk from nsw_potong_kuota.td_komoditi a
join nsw_potong_kuota.td_komoditi_spesifikasi_teknis b 
on a.id_komoditi  = b.id_komoditi
where a.id_header = 1625720


select * from nsw_bkpm.td_bkpm_dtl limit 10;

select * from nsw_ppbj.td_kd_4;



