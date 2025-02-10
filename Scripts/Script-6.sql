-- get PIB dengan kep skbppn
select b.car,b.pibno,b.pibtg,t.dokkd,t.dokno,t.doktg  from nswdb1_fdw_new.tblpibdok t 
join nswdb1_fdw_new.tblpibhdr b on t.cusdecid = b.cusdecid 
where t.create_dt::date between '2021-09-01' and now()::date
and t.dokkd ='456' and pibno is not null;


-- get kep skb
select no_kep_skbppn,tgl_kep_skbppn,
case when no_kep_skbppn like '%KET-SKB%' then split_part(no_kep_skbppn,'KET-SKB-',2)
else split_part(no_kep_skbppn,'KET-',2)
end
as format_pib from nsw_skbppn.td_skb_keputusan tsk  where kd_keputusan='50' and not no_kep_skbppn like '%TEST%';


-- test gabung
with dok_skb as (select no_kep_skbppn,tgl_kep_skbppn,
case when no_kep_skbppn like '%KET-SKB%' then split_part(no_kep_skbppn,'KET-SKB-',2)
else split_part(no_kep_skbppn,'KET-',2)
end
as format_pib from nsw_skbppn.td_skb_keputusan tsk  where kd_keputusan='50' and not no_kep_skbppn like '%TEST%'),
dok_pib as (
select b.car,b.pibno,b.pibtg,t.dokkd,t.dokno,t.doktg  from nswdb1_fdw_new.tblpibdok t 
join nswdb1_fdw_new.tblpibhdr b on t.cusdecid = b.cusdecid 
where t.create_dt::date between '2021-09-01' and now()::date
and t.dokkd ='456' and pibno is not null
)
select b.car,b.pibno as no_pib,b.pibtg as tgl_pib,b.dokno as no_skb_pib, b.doktg as tgl_skb_pib,

from dok_pib a right join dok_skb b on a.dokno = b.format_pib