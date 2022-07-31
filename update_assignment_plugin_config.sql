select
    *
from
    mdl_assign_plugin_config
group by
    name;

update
    mdl_assign_plugin_config
set
    value = 1
where
    value = 0
    and subtype = 'assignsubmission'
    and name = 'enabled';

update
    mdl_assign_plugin_config
set
    value = 1
where
    value = 0
    and subtype = 'assignfeedback'
    and name = 'commentinline';