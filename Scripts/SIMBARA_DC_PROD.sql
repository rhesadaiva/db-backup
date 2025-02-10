select ntpn,trx_kmdt_jual from batubara.td_pnbp_v3 limit 100;

select
	ntpn ,
	tgl_ntpn,
	komoditi,
	npwp,
	nama_perusahaan ,
	tonase_ntpn,
	terpakai,
	( tonase_ntpn - terpakai ) as saldo
from
	(
	select
		ntpn ,
		tgl_ntpn,
		a.trx_kmdt_jual as komoditi,
		npwp,
		a.drpr_nmperush as nama_perusahaan,
		kn_tonase tonase_ntpn,
		(case
			when (
			select
				sum (case
					when c.satuan in ('TNE', 'MT') then c.jumlah_volume
					when c.satuan in ('KGM') then c.jumlah_volume / 1000
					else 0
				end)
			from
				batubara.td_header ta
			join batubara.td_barang b on
				ta.id_header = b.id_header
			join batubara.td_royalti c on
				b.id_barang = c.id_barang
			where
				c.no_bayar_royalti = a.ntpn
				and ta."status" not in ('002')) is null then 0
			else (
			select
				sum (case
					when c.satuan in ('TNE', 'MT') then c.jumlah_volume
					when c.satuan in ('KGM') then c.jumlah_volume / 1000
					else 0
				end)
			from
				batubara.td_header ta
			join batubara.td_barang b on
				ta.id_header = b.id_header
			join batubara.td_royalti c on
				b.id_barang = c.id_barang
			where
				c.no_bayar_royalti = a.ntpn
				and ta."status" not in ('002'))
		end
            ) terpakai
	from
		batubara.td_pnbp_v3 a
        ) x
where
	ntpn = $1;


select * from batubara.td_pnbp_v3 limit 10;



--sumbu y 
with bounds as (
SELECT (AVG(ton_tertimbang) - STDDEV_SAMP(ton_tertimbang) * 2) as lower_bound,
           (AVG(ton_tertimbang) + STDDEV_SAMP(ton_tertimbang) * 2) as upper_bound
    FROM (
select * from (
select a.ntpn, (kn_tonase*drpr_hj_perush)/drpr_hrg_acu as ton_tertimbang
from batubara.td_pnbp_v3 a
where trx_kmdt_jual ilike '%batubara%' and jenis_ntpn = 'PROVISIONAL' and a.tgl_ntpn between $1 and $2 and (kn_tonase*drpr_hj_perush)/drpr_hrg_acu <>0)x)y)
select count(*) as datas from (
select left(a.npwp,9) as npwp, a.ntpn, kn_tonase, drpr_hj_perush, drpr_hrg_acu,  (kn_tonase*drpr_hj_perush)/drpr_hrg_acu as ton_tertimbang, a.tgl_ntpn
from batubara.td_pnbp_v3 a
where trx_kmdt_jual ilike '%batubara%' and jenis_ntpn = 'PROVISIONAL' and a.tgl_ntpn between $1 and $2 and (kn_tonase*drpr_hj_perush)/drpr_hrg_acu <>0 )x
WHERE ton_tertimbang BETWEEN (SELECT lower_bound FROM bounds) AND (SELECT upper_bound FROM bounds)


--Penggunaan NTPN (NTPN di LS)
select y.*, case when y.jml_dipakai = 0 or y.jml_dipakai=1 then '0 atau 1'
				when y.jml_dipakai between 2 and 3 then '2 s.d 3'
				when y.jml_dipakai > 3 then '>3' end as kelompok1,
	case when y.jml_dipakai = 0 or y.jml_dipakai=1 then 20
				when y.jml_dipakai between 2 and 3 then 60
				when y.jml_dipakai > 3 then 100 end as skor1
from (
select left(a.npwp,9)as npwp, drpr_nmperush as perusahaan, a.ntpn, a.tgl_ntpn,
(select coalesce (count(distinct no_ls) ,0) from 
	(select no_ls , c.no_bayar_royalti 
		from  batubara.td_header a, batubara.td_barang b, batubara.td_royalti c
		where a.id_header =b.id_header and b.id_barang =c.id_barang) x where x.no_bayar_royalti = a.ntpn) jml_dipakai
from batubara.td_pnbp_v3 a
where trx_kmdt_jual ilike '%batubara%' and jenis_ntpn ='PROVISIONAL' and a.tgl_ntpn between $1 and $2) y 
where npwp is not null

--Pengguna NTPN (ntpn dipakai oleh lebih dari 1 npwp)
select x.*, case when x.jumlah_dipakai =1 then 0
				else 100 end as skor2,
			case when x.jumlah_dipakai =1 then 'Sekali Pakai'
				else 'Lebih dari 1' end as kelompok2		
from (
select a.ntpn, count(distinct d.npwp) as jumlah_dipakai,a.tgl_ntpn
from batubara.td_pnbp_v3 a
join batubara.td_royalti b on a.ntpn =b.no_bayar_royalti
join batubara.td_barang c on c.id_barang =b.id_barang 
join batubara.td_header d on c.id_header =d.id_header 
where trx_kmdt_jual ilike '%batubara%' and jenis_ntpn ='PROVISIONAL' and a.tgl_ntpn between $1 and $2
group by 1)x

--masa penggunaan NTPN (selisih tanggal) 
select *,case when y.selisih between 0 and 30 then '1 Bulan'
			when y.selisih between 31 and 60 then '1 s.d 2 Bulan'
			when y.selisih between 61 and 120 then '2 s.d 4 Bulan'
			when y.selisih between 121 and 180 then '4 s.d 6 Bulan'
			when y.selisih >180 then '>6 bulan'
		end as kelompok3,
		case when y.selisih between 0 and 30 then 20
			when y.selisih between 31 and 60 then 40
			when y.selisih between 61 and 120 then 60
			when y.selisih between 121 and 180 then 80
			when y.selisih >180 then 100
		end as skor3
from (
select a.ntpn, a.tgl_ntpn,  a.npwp, b.no_ls, b.tgl_ls,a.tgl_ntpn,
b.tgl_ls - a.tgl_ntpn selisih
from batubara.td_pnbp_v3 a, batubara.td_header b, batubara.td_barang c, batubara.td_royalti d 
where a.ntpn = d.no_bayar_royalti
and a.tgl_ntpn between $1 and $2
and b.id_header = c.id_header 
and c.id_barang = d.id_barang)y

--rasio tonase
select *, case when y.selisih <=0.2 then '<=20%'
			 when y.selisih between 0.2 and 0.5 then '20%-50%'
			 when y.selisih >0.5 then '>50%' end as kelompok4,
		case when y.selisih <=0.2 then 10
			 when y.selisih between 0.2 and 0.5 then 50
			 when y.selisih >0.5 then 100 end as skor4
from (
select ntpn, tonase_di_ls , tonase_di_pnbp , rasio, ABS(rasio-1) as selisih
from 
(select a.ntpn, 
		sum(case when b.satuan='KGM' then b.jumlah_volume/1000 else b.jumlah_volume end ) tonase_di_ls, 
		sum(a.kn_tonase) tonase_di_pnbp, 
		sum(case when b.satuan='KGM' then b.jumlah_volume/1000 else b.jumlah_volume end)/sum(a.kn_tonase) rasio,
		a.tgl_ntpn
from batubara.v_pnbp a,
batubara.td_royalti b
where trx_kmdt_jual ilike '%batubara%' and jenis_ntpn ='PROVISIONAL' and a.ntpn = b.no_bayar_royalti and a.tgl_ntpn between $1 and $2
group by a.ntpn) x)y

--kesesuaian kalori
select *, 
		case when x.selisih <=0.1 then '<=10%'
			when x.selisih between 0.1 and 0.2 then '10%-20%'
			else '>20%'
		end as kelompok5,
				case when x.selisih <=0.1 then 10
			when x.selisih between 0.1 and 0.2 then 50
			else 100
		end as skor5
from (
with datapnbp as (
select a.ntpn, a.kl_kalori as kalori_ntpn,a.tgl_ntpn
from batubara.td_pnbp_v3 a
where trx_kmdt_jual ilike '%batubara%' and jenis_ntpn = 'PROVISIONAL' and a.tgl_ntpn between $1 and $2),
datals as (
select d.no_bayar_royalti, a.cal_arb 
from batubara.td_batubara a
join batubara.td_header b on a.id_header =b.id_header
join batubara.td_barang c on c.id_header =b.id_header 
join batubara.td_royalti d on d.id_barang =c.id_barang)
select a.ntpn, a.tgl_ntpn, a.kalori_ntpn, b.cal_arb as kalori_ls, b.cal_arb/a.kalori_ntpn as rasio, ABS(1-(b.cal_arb/a.kalori_ntpn)) as selisih 
from datapnbp a
join datals b on b.no_bayar_royalti=a.ntpn )x


--rasio HJ
select *, 
		case when x.selisih <=0.05 then '<=5%'
			when x.selisih between 0.05 and 0.1 then '5%-10%'
			else '>10%'
		end as kelompok6,
				case when x.selisih <=0.05 then 10
			when x.selisih between 0.05 and 0.1 then 50
			else 100
		end as skor6
from (
with datals as (
select b.no_bayar_royalti, a.value_currency/a.jumlah_volume as hj_perton
from batubara.td_barang a
join batubara.td_royalti b on a.id_barang =b.id_barang
where a.currency ='USD'),
datapnbp as (
select ntpn, drpr_hj_perush/kn_tonase as hj_perton,a.tgl_ntpn
from batubara.td_pnbp_v3 tpv 
where trx_kmdt_jual ilike '%batubara%' and jenis_ntpn = 'PROVISIONAL' and a.tgl_ntpn between $1 and $2)
select a.ntpn, a.tgl_ntpn, a.hj_perton as hj_ntpn_peton, b.hj_perton as hj_ls_peton, abs(b.hj_perton-a.hj_perton)/NULLIF(a.hj_perton,0) as selisih,a.tgl_ntpn
from datapnbp a
join datals b on b.no_bayar_royalti =a.ntpn)x

--HBA
select a.ntpn, a,tgl_ntpn, b.jns_pasar, a.drha_nilai,
		case when b.jns_pasar ='Ekspor' and a.drha_nilai >=90 then 0
			when b.jns_pasar ='Ekspor' and  a.drha_nilai <90 then 100
			when b.jns_pasar ='Domestik' then 0
		end as skor7,
		case when b.jns_pasar ='Ekspor' and a.drha_nilai >=90 then 'HBA Normal'
			when b.jns_pasar ='Ekspor' and  a.drha_nilai <90 then 'HBA tidak Sesuai'
			when b.jns_pasar ='Domestik' then 'HBA Normal'
		end as kelompok7
from batubara.td_pnbp_v3 a
join batubara.td_moms_mvp_trx b on a.ntpn =b.no_ntpn 
where trx_kmdt_jual ilike '%batubara%' and jenis_ntpn ='PROVISIONAL' and a.tgl_tpn between $1 and $2


select * from batubara.td_pnbp_kendali_kuota as tpkk where no_aju_ls ilike  'LNSW-4993018FB7A02023121%'

select * from batubara.td_pnbp_kendali_kuota as tpkk where tpkk.ntpn = 'B793F0NA046TA350';

select * from batubara.td_header as th where th.ref_number like 'LNSW%';






       
       
       