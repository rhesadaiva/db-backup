SELECT no_kep_bkpm, tgl_kep_bkpm,pmh_npwp_perusahaan,pmh_nm_perusahaan FROM nsw_skbppn.td_skb_header WHERE no_kep_bkpm like '%OSS%';

select * from nsw_skbppn.td_skb_dokumen tsk where id_skb_header ='7054';





select * from nsw_skbppn.td_skb_keputusan where no_aju ='302007DC4CED1';

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
      )
      select * from getLastData where no_aju='302008352782F' order by wk_rekam desc;
      
  
  select a.id_skb_header,a.pmh_nm_perusahaan,a.no_aju, a.wk_rekam,
    a.seri_perubahan, a.kd_jns_permohonan, e.ur_jenis_permohonan ,
    a.kd_jns_pemohon, d.ur_jenis_pemohon, a.kd_jns_pengajuan, concat(a.kd_jns_pengajuan,a.kd_jns_pemohon) as kd_pengajuan,b.url_kep_skbppn, 
    b.no_kep_skbppn, b.tgl_kep_skbppn,b.keterangan_kep_skbppn, a.kd_proses,
    (select c.ur_proses from nsw_skbppn.tr_proses c where c.kd_proses=a.kd_proses ),
    count(*) over() as total_count
    from nsw_skbppn.td_skb_header a 
    left join nsw_skbppn.td_skb_keputusan b on a.no_aju = b.no_aju and a.seri_perubahan = b.seri_perubahan
    left join nsw_skbppn.tr_jenis_pengajuan c ON a.kd_jns_pengajuan = c.kd_jenis_pengajuan
    left join nsw_skbppn.tr_jenis_pemohon d ON a.kd_jns_pemohon = d.kd_jenis_pemohon
    left join nsw_skbppn.tr_jenis_permohonan e ON a.kd_jns_permohonan = e.kd_jenis_permohonan 
--    where a.no_aju='302008352782F' order by seri_perubahan desc limit 1;
    
    
    
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
      ROW_NUMBER() OVER (PARTITION BY a.no_aju order by a.seri_perubahan desc) as urut,
      count(*) over() as total_count
      from nsw_skbppn.td_skb_header a 
      left join nsw_skbppn.td_skb_keputusan b on a.no_aju = b.no_aju and a.seri_perubahan = b.seri_perubahan
      left join nsw_skbppn.tr_jenis_pengajuan c ON a.kd_jns_pengajuan = c.kd_jenis_pengajuan
      left join nsw_skbppn.tr_jenis_pemohon d ON a.kd_jns_pemohon = d.kd_jenis_pemohon
      left join nsw_skbppn.tr_jenis_permohonan e ON a.kd_jns_permohonan = e.kd_jenis_permohonan 
      WHERE a.user_id=$1
      order by a.wk_rekam desc limit $2 offset $3
      )
      select * from getLastData where urut = 1 order by wk_rekam desc;
  
  
  with master as (select no_aju,count(*) jumlah from nsw_skbppn.td_skb_keputusan group by no_aju)
  select * from master order by jumlah desc limit 10;
  
  with master as (
  select a.no_aju,b.no_aju as no_aju_kep,concat(a.kd_jns_pengajuan,a.kd_jns_pemohon) as jenis_pengajuan
  from nsw_skbppn.td_skb_header a
  left join nsw_skbppn.td_skb_keputusan b
  on a.no_aju = b.no_aju
  )
  select * from master where no_aju_kep is null limit 20;
 
 SELECT * FROM nsw_skbppn.td_skb_barang LIMIT 1;
  
 
 select * from nsw_skbppn.td_skb_epc;