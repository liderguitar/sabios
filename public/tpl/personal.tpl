<script id="personal" type="text/html">
<span id="span_personal">
    <fieldset>
        <legend>Personal</legend>                    
        <table style="border-bottom:1px solid #CCCCCC;" border="0" cellpadding="0" cellspacing="10" width="693">
            <tbody>
                <tr>
                    <td align="right" width="319">
                        <strong>
                            Nombre y Apellido:				  
                            <input name="personal_id[]" value="{{id}}" type="hidden">
                            <input name="personal_nombre[]" id="personal_nombre[]" value="{{nombre_apellido}}" size="25" maxlength="100" type="text">
                        </strong>
                    </td>
                    <td align="right" width="304">
                        <strong>
                            Cargo:				  
                            <select name="personal_cargo[]" style="width:180px;">
                                <option value="0">
                                    Seleccione un Cargo
                                </option>
                                {{#viajantes}}
                                <option value="{{id}}">{{nombre}}</option>
                                {{/viajantes}} 
                            </select>
                        </strong>
                    </td>
                    <td align="right" width="30">
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <strong>
                            Apodo:				  
                            <input name="personal_apodo[]" value="{{apodo}}" size="25" maxlength="100" type="text">
                        </strong>
                    </td>
                    <td align="right">
                        <strong>
                            Fecha de Nacimiento:				  
                            <input name="personal_fecha[]" id="personal_fecha[]" value="{{fecha_nacimiento}}" size="21" maxlength="100" type="text">
                        </strong>
                    </td>
                    <td align="right">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <strong>
                            Tel&eacute;ono Fijo:				  
                            <input name="personal_tel1[]" value="{{telefono}}" size="25" maxlength="100" type="text">

                        </strong>
                    </td>

                    <td align="right">
                        <strong>
                            Tel&eacute;fono Movil:				  
                            <input name="personal_tel2[]" value="{{movil}}" size="25" maxlength="100" type="text">
                        </strong>
                    </td>
                    <td align="right">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <strong>
                            E-mail:				  
                            <input name="personal_email1[]" value="{{email}}" size="25" maxlength="100" type="text">
                        </strong>
                    </td>
                    <td colspan="2" align="right">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <strong>
                            Observaciones:
                        </strong>
                        <br>

                        <textarea name="personal_observaciones[]" cols="75" rows="4">
                            {{observaciones}}
                        </textarea>
                    </td>
                </tr>
            </tbody>
        </table>
    </fieldset>
</span>
</script>