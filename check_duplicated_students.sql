select
    u1.id,
    u1.username,
    u1.idnumber,
    u1.firstname,
    u1.lastname,
    u2.id,
    u2.username
from
    mdl_user u1
    inner join mdl_user u2 on u1.username = u2.username
    and u1.id <> u2.id
where
    u1.username like ':username'