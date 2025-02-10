select * from nsw_sso."Clients" c where c.id ='e7daaeee-b552-4540-a1e3-13ae5a6ca4d1';

select * from nsw_sso."RegistrationAccessTokens" as rat where rat. = 'e7daaeee-b552-4540-a1e3-13ae5a6ca4d1';

select * from nsw_sso."RegistrationAccessTokens" as rat where rat.data->>'clientId' = 'e7daaeee-b552-4540-a1e3-13ae5a6ca4d1';

select * from access_tools.users where username = 'admin_pu_dasindo';