select * from nsw_skbppn.td_skb_barang tsb 
where tsb.id_skb_header = (select x.id_skb_header from nsw_skbppn.td_skb_header x where x.no_aju='302008FA81F97')


select  * from nsw_skbppn.td_skb_header tsh 
where tsh.no_aju ='302008FA81F97';


select * from nsw_skbppn.td_skb_keputusan tsk
where tsk.no_kep_skbppn ='KET-000007/PPN/KPP.2202/2024'

select id_skb_header from nsw_skbppn.td_skb_header tsh
where tsh.no_kep_bkpm='48/PABEAN-PB/OSS/PMDN/2024';

select b.no_aju ,b.no_kep_bkpm ,no_item,jenis_barang,spesifikasi from nsw_skbppn.td_skb_barang a
join nsw_skbppn.td_skb_header b on a.id_skb_header = b.id_skb_header
where a.id_skb_header ='15308'
order by no_item::integer asc;