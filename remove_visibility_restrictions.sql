update
    mdl_course_modules cm
    inner join mdl_course c on c.id = cm.course
    inner join mdl_course_categories cc on cc.id = c.category
set
    cm.visible = 1
where
    cm.visible = 0
    and module = 1
    and cc.parent = :category;