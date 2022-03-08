create or replace package com_fos_spinner_actions
as

    function render
      ( p_dynamic_action in apex_plugin.t_dynamic_action
      , p_plugin         in apex_plugin.t_plugin
      )
    return apex_plugin.t_dynamic_action_render_result;

end;
/


