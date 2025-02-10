select company_no_telfon from nle_dev.mst_platform mp;


select count(*) from nle_dev.mst_platform mp;

SELECT
    company_no_telfon,
    regexp_replace( (
        regexp_replace(
            regexp_replace(company_no_telfon, '/', ' ', 'g'),
            '-',
            '',
            'g'
        ),
        '^62',
        '0',
        1,
        'g'
    ) AS cleansed
FROM
    nle_dev.mst_platform mp;
   
   
   select regex



--insert into nsw_nle.td_platform (
--	id_platform,
--	uri,
--	nama,
--	email,
--	phone_number,
--	platform_id,
--	wk_rekam,
--	wk_simpan,
--	icon
--)
--select
--	gen_random_uuid(),
--	app_url,
--	platform_name,
--	company_email,
--	company_no_telfon,
--	platform_id,
--	now(),
--	now(),
--	original_platform_logo
--from
--	nle_dev.mst_platform;


select gen_random_uuid();