delete from
    mdl_user_preferences
where
    userid = :userid
    and name like "block%hidden";