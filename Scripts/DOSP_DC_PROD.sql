select a.id_reqdo_header , (select x.nobl from nswdb1.tblreqdo_header x where x.id_reqdo_header = a.id_reqdo_header) as nobl, B.URAIAN, to_char(A.CREATED_DATE, 'YYYY-MM-DD HH24:MI:SS') AS CREATED_DATE, A.keterangan 
    from nswdb1.tblreqdo_status A join nswdb1.tbltab B on A.kode_status=B.kdnsw and B.kdtab='D4' 
--    where id_reqdo_header = (select id_reqdo_header from nswdb1.tblreqdo_header where nobl=$1) 
    ORDER BY A.id_reqdo_status desc limit 20