with cek as (select a.id_keputusan,
                    a.no_aju,
                    row_number() over (partition by a.no_aju order by a.id_keputusan desc) as urut,
                    a.tgl_kep_skbppn
             from nsw_skbppn.td_skb_keputusan a
                      join nsw_skbppn.td_skb_header b on a.no_aju = b.no_aju
             where pmh_npwp_perusahaan <> '024804635651000')
select distinct no_aju, tgl_kep_skbppn
from cek
where urut > 1;

