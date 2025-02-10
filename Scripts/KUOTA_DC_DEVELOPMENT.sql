select no_perijinan  from nsw_potong_kuota.td_header order by id_header desc limit 10;


select * from nsw_potong_kuota.td_header where no_perijinan  ilike '%kblbb%'

select * from nsw_potong_kuota.td_komoditi tk where tk.id_header=1625683;

select * from nsw_potong_kuota.tr_jns_asal_barang tjab;

select * from nsw_potong_kuota.td_kuota where id_kuota in (108498514,
108498515)

select * from referensi.tr_dokumen where uraian_dokumen ilike '%migas%';

      
call p_delete_kuota(1625691); 
      
     
select * from nsw_potong_kuota.td_komoditi_spesifikasi_teknis as tkst limit 10;



select * from nsw_potong_kuota.td_header where no_perijinan ='001/BC.01/XI/2023';


 select concat_ws(':',i.no_perijinan,i.tgl_perijinan) as id ,i.* from
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
      left join nsw_potong_kuota.td_header th on i.no_perijinan = th.no_perijinan_parent
      where i.id_header is not null
      LIMIT 5;

  
  select * from nsw_potong_kuota.td_header as th where th.no_perijinan ilike '%kblbb%';

  
  select * from nsw_potong_kuota.td_komoditi_spesifikasi_teknis as tkst
  
  
  select row_to_json(header)
    from (
    select (
    select row_to_json(d)
    from(
    select a.status_dokumen, a.kd_jns_dokumen,a.kd_jns_dokumen_final,
    a.kd_perijinan,a.no_perijinan,a.tgl_perijinan,a.tgl_awal_perijinan,
    a.tgl_akhir_perijinan, a.kd_ga, a.npwp, a.nib, a.nama,a.alamat,a.kd_pos,
    a.kd_kota,a.kd_provinsi,a.telp,a.fax,a.email,a.url_doc,
    (
    select json_agg(header_negara) from (
    select b.kd_negara from nsw_potong_kuota.td_headernegara b where b.id_header = a.id_header
    ) header_negara
    ) as negara,
    (
    select json_agg(header_pelabuhan) from (
    select c.kd_pelabuhan from nsw_potong_kuota.td_headerpelabuhan c where c.id_header = a.id_header 
    ) header_pelabuhan
    ) as pelabuhan,
    (
    select json_agg(komoditi_header) from (
    select 
    d.id_komoditi,d.seri,d.kd_hs,d.bm,d.ppn,d.uraian,d.nilai_total_barang,
    d.kd_jns_satuan, e.jml_kuota as jml_total_kuota, e.jml_terpakai, e.jml_sisa,
    (select row_to_json(komoditi_spek_teknis) from (
      select x.* from nsw_potong_kuota.td_komoditi_spesifikasi_teknis x where x.id_komoditi = d.id_komoditi) 
      komoditi_spek_teknis
    ) as spesifikasi_teknis,
    (
    select json_agg(komoditi_sub) from (
    select h.id_subkomoditi, h.seri,h.kd_hs, h.uraian, h.kd_jns_satuan,
    i.jml_kuota as jml_total_kuota, i.jml_terpakai, i.jml_sisa 
    from nsw_potong_kuota.td_komoditisub h inner join nsw_potong_kuota.td_kuota i on i.id_kuota=h.id_kuota where h.id_komoditi = d.id_komoditi
    )komoditi_sub
    ) as subkomoditi,
    (
    select json_agg(komoditi_negara) from (
    select f.kd_negara from nsw_potong_kuota.td_komoditinegara f where f.id_komoditi = d.id_komoditi 
    )komoditi_negara
    )as komoditi_negara,
    (
    select json_agg(komoditi_pelabuhan) from (
    select g.kd_pelabuhan from nsw_potong_kuota.td_komoditipelabuhan g where g.id_komoditi = d.id_komoditi 
    )komoditi_pelabuhan
    )as komoditi_pelabuhan
    from nsw_potong_kuota.td_komoditi d inner join nsw_potong_kuota.td_kuota e on d.id_kuota=e.id_kuota where d.id_header = a.id_header 
    )komoditi_header
    ) as komoditi
    from nsw_potong_kuota.td_header a where a.no_perijinan = $1
    ) d
    ) as data
    from nsw_potong_kuota.td_header a where a.no_perijinan = $1
    ) header
    
    
    
    select * from nsw_potong_kuota.td_header;

select * from nsw_potong_kuota.td_headernegara as th;
select * from nsw_potong_kuota.td_headerpelabuhan as th2;

select * from nsw_potong_kuota.td_komoditinegara as tk;


select d.id_header_kuota, d.no_perijinan, th.no_perijinan_parent, d.tgl_perijinan, th.no_pengajuan, d.kd_kppbc, d.ur_kppbc, d.kd_pel_bongkar, d.ur_pelabuhan, th.kd_perijinan,(select td.uraian_dokumen
from referensi.tr_dokumen td
where th.kd_perijinan = td.id_dokumen) ur_perijinan, th.kd_ga,(select tg.ur_ga
from referensi.tr_ga tg
where th.kd_ga = tg.kd_ga), th.nama, th.npwp, th.wk_pengiriman,(select tjd.ur_jenis_dokumen
from nsw_potong_kuota.tr_jns_dokumen tjd
where th.kd_jns_dokumen = tjd.kd_jenis_dokumen) as jenis_dokumen,(select tjf.uraian
from nsw_potong_kuota.tr_jns_dokumen_final tjf
where th.kd_jns_dokumen_final = tjf.kd_jns_dokumen_final) as jenis_dokumen_final,(select tsd.ur_status_dokumen
from nsw_potong_kuota.tr_status_dokumen tsd
where th.status_dokumen = tsd.kd_status_dokumen) as status, count(d.id_realisasi) jml_dokumen_realisasi, case
      when e.jml_sisa > 0 then 'Tersedia'
else 'Tidak Tersedia'
      end status_kuota
from nsw_potong_kuota.td_header th
left join 
      (select c.*
from(select distinct on
(tr.id_realisasi) tp.id_header_kuota, tr.id_komoditi, tr.id_subkomoditi, tr.id_realisasi, tp.kd_proses,(select tpr.uraian as ur_proses
from nsw_potong_kuota.tr_proses_realisasi tpr
where tp.kd_proses = tpr.kd_proses_realisasi) ur_proses, tp.wk_proses, tr.no_perijinan, tr.tgl_perijinan, tr.kd_kppbc,(select tk.uraian
from referensi.tr_kppbc tk
where tr.kd_kppbc = tk.kd_kppbc) as ur_kppbc, tr.kd_pel_bongkar,(select tp2.ur_pelabuhan
from referensi.tr_pelabuhan tp2
where tr.kd_pel_bongkar = tp2.kd_pelabuhan)
from nsw_potong_kuota.td_realisasi tr
left join nsw_potong_kuota.td_proses tp 
      on
tr.id_realisasi = tp.id_realisasi
group by tp.id_header_kuota, tr.id_komoditi, tr.id_subkomoditi, tr.id_realisasi, tp.kd_proses, tp.wk_proses
order by tr.id_realisasi, tp.kd_proses desc
      ) c
where c.kd_proses in ('03', '04')) d
      on
th.id_header = d.id_header_kuota
left join (select d.id_header, sum(d.jml_sisa) jml_sisa
from(
        select a.id_header, a.id_komoditi, case
        when c.jml_terpakai_subkom is null then sum(b.jml_sisa)
when b.jml_terpakai > 0 then sum(b.jml_sisa)
else sum(c.jml_sisa_subkom) end jml_sisa
from nsw_potong_kuota.td_komoditi a
left join nsw_potong_kuota.td_kuota b 
        on
a.id_kuota = b.id_kuota
left join (select tk3.id_komoditi, sum(tk5.jml_kuota) jml_kuota_subkom, sum(tk5.jml_terpakai) jml_terpakai_subkom, sum(tk5.jml_sisa) jml_sisa_subkom
from nsw_potong_kuota.td_komoditi tk3
left join nsw_potong_kuota.td_komoditisub tk4 on
tk3.id_komoditi = tk4.id_komoditi
left join nsw_potong_kuota.td_kuota tk5 on
tk4.id_kuota = tk5.id_kuota
group by tk3.id_komoditi) c on
a.id_komoditi = c.id_komoditi
group by a.id_header, a.id_komoditi, b.jml_terpakai, c.jml_terpakai_subkom) d
group by d.id_header) e on
th.id_header = e.id_header
where d.id_header_kuota is not null
and th.kd_ga ilike ${kdGaHandler}
and th.status_dokumen ilike ${statusDokumenHandler}
and 
th.kd_jns_dokumen ilike ${jnsDokumenHandler}
and th.kd_jns_dokumen_final ilike ${jnsDokumenFinalHandler}
and 
d.kd_kppbc ilike ${kdKppbcHandler}
and d.kd_pel_bongkar like ${kdPelabuhanHandler} ${kdProsesHandler} ${filter}
group by d.id_header_kuota, th.no_perijinan_parent, d.no_perijinan, d.tgl_perijinan, th.no_pengajuan, d.kd_kppbc, d.ur_kppbc, d.kd_pel_bongkar, d.ur_pelabuhan, th.kd_perijinan, th.kd_ga, th.wk_pengiriman, th.nama, th.npwp, th.kd_jns_dokumen, th.kd_jns_dokumen_final, th.status_dokumen, th.status_kuota, e.jml_sisa
${limitHandler} ${offsetHandler}

select * from nsw_potong_kuota.tr_jns_dokumen as tjd;

select * from nsw_potong_kuota.tr_status_dokumen as tsd;

select * from nsw_potong_Kuota.tr_jns_dokumen_final as tjdf;

select * from nsw_potong_kuota.td_referensi limit 1;

select * from nsw_potong_kuota.tr_jns_perijinan;

select distinct kd_ga from referensi.tr_dokumen_all where id_dokumen like '0500%'

select * from nsw_potong_kuota.tr_jns_negara as tjk;


select distinct status_kuota from nsw_potong_kuota.td_komoditi as tsd;

select * from nsw_potong_kuota.td_komoditipelabuhan as tk2;

select * from nsw_potong_kuota.td_ko limit 1;


select * from nsw_potong_kuota.td_komoditi_spesifikasi_teknis as tkst;

select * from nsw_potong_kuota.td_header where no_perijinan like 'TEST1%'
