create or replace package body com_fos_spinner_actions
as

-- =============================================================================
--
--  FOS = FOEX Open Source (fos.world), by FOEX GmbH, Austria (www.foex.at)
--
--  This plug-in provides you with a Spinner Actions dynamic action.
--
--  License: MIT
--
--  GitHub: https://github.com/foex-open-source/fos-spinner-actions
--
-- =============================================================================

function render
    ( p_dynamic_action in apex_plugin.t_dynamic_action
    , p_plugin         in apex_plugin.t_plugin
    )

return apex_plugin.t_dynamic_action_render_result
as
    l_result apex_plugin.t_dynamic_action_render_result;
    -- dynamic action id
    l_id               p_dynamic_action.id%type            := p_dynamic_action.id;
    -- plug-in attributes
    l_action           p_dynamic_action.attribute_01%type  := p_dynamic_action.attribute_01;
    l_spinner_type     p_dynamic_action.attribute_02%type  := p_dynamic_action.attribute_02;
    l_spinner_html     p_dynamic_action.attribute_03%type  := p_dynamic_action.attribute_03;
    l_spinner_css      p_dynamic_action.attribute_04%type  := p_dynamic_action.attribute_04;
    l_overlay_type     p_dynamic_action.attribute_05%type  := p_dynamic_action.attribute_05;
    l_overlay_color    p_dynamic_action.attribute_06%type  := p_dynamic_action.attribute_06;
    l_overlay_opacity  p_dynamic_action.attribute_07%type  := p_dynamic_action.attribute_07;
    l_access_text      p_dynamic_action.attribute_08%type  := p_dynamic_action.attribute_08;
    l_spinner_class    p_dynamic_action.attribute_09%type  := p_dynamic_action.attribute_09;
    l_spinner_color    p_dynamic_action.attribute_10%type  := p_dynamic_action.attribute_10;

begin
    -- standard debugginng
    if apex_application.g_debug and substr(:DEBUG,6) >= 6
    then
        apex_plugin_util.debug_dynamic_action
            ( p_dynamic_action => p_dynamic_action
            , p_plugin         => p_plugin
            );
    end if;

    if instr(l_spinner_type, 'def-') > 0
    then
        apex_css.add_file
            ( p_name       => 'fos-sa-spinner-styles#MIN#'
            , p_directory  =>  p_plugin.file_prefix || 'css/'
            );
    end if;

    apex_json.initialize_clob_output;
    apex_json.open_object;

    apex_json.write('id'               , l_id                );
    apex_json.write('spinnerType'      , l_spinner_type      );
    apex_json.write('spinnerColor'     , l_spinner_color     );
    apex_json.write('spinnerHTML'      , l_spinner_html      );
    apex_json.write('spinnerCSS'       , l_spinner_css       );
    apex_json.write('overlayType'      , l_overlay_type      );
    apex_json.write('overlayColor'     , l_overlay_color     );
    apex_json.write('overlayOpacity'   , l_overlay_opacity   );
    apex_json.write('spinnerClass'     , l_spinner_class     );
    apex_json.write('accessText'       , l_access_text       );

    apex_json.close_object;

    l_result.javascript_function := 'function(){return FOS.utils.spinnerActions.' ||
        case l_action
            when 'show-spinner' then
                'showSpinner'
            when 'convert-default' then
                'convertDefault'
            else
                'removeSpinner'
        end || '(this,'|| apex_json.get_clob_output ||');}';

    apex_json.free_output;

    return l_result;

end;

end;
/


