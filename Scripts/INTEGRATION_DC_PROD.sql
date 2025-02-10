select * from integrasi.td_log_integration as tli where dest = 'sendGetResponseImporGen2';


select uuid from integrasi.td_log_integration as tli where dest='sendResponseToSSMQCGen1';


select * from referensi.tr_identifier_respon_ceisa40 as tirc;


select * from integrasi.td_log_service as tls where proses_at ilike 'send response ceisa40'; 


select * from integrasi.td_log_service as tls where proses_at ilike 'response ssmqc ceisa from djbc';
