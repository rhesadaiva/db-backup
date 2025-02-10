select * from nsw_nle.td_berita tb limit 1;



select * from nsw_nle.td_log_integration as tli;


select COUNT(*)
from dosp.tblreqdo_header
--where statusreqdo ilike '4%'
where noreqdo is null;


select a.id_reqdo_header, ts.uraian, noreqdo , tglreqdo , nama_requestor, status_requestor, tgldoawal, tgldoakhir, nobl, tglbl, nodo
from dosp.tblreqdo_header as a
join referensi.tr_status as ts on
a.statusreqdo = ts.kd_status
where a.tglreqdo is not null
and ts.id_tab_status = 'D4'
order by tglreqdo desc;


select * from dosp.tblref_depo as td;

select * from referensi.tr_status ts where id_tab_status = 'D4';