<script id="sucursal" type="text/html">
<fieldset>
    <legend style="color:#006699;">
        Sucursales
    </legend>
    <br>
    <span id="span_sucursal_1">
        <table width="684" cellspacing="6" cellpadding="0" border="0">
            <tbody>
                <tr>
                    <td colspan="2">
                        <table width="667" cellspacing="0" cellpadding="" border="0">
                            <tbody>
                                <tr>
                                    <td>
                                        <strong>
                                            Número:                            
                                            <input type="hidden" value="{{id}}" ame="sucursal_id_1">
                                            <input type="text" maxlength="100" size="20" value="{{numero}}" name="sucursal_nombre_1">
                                        </strong>
                                    </td>
                                    <td>
                                        <strong>
                                            Pcia:
                                        </strong>
                                        <input type="hidden" value="0" name="sucursal_id_provincia_hidden_1">
                                        <select style="width: 180px;" id="pais" name="pais">
                                            <option value="0">
                                                Seleccione un Pais
                                            </option>
                                        </select>       
                                        <select style="width: 180px;" id="sucursal_id_provincia_1" name="sucursal_id_provincia_1">

                                            <option value="0">
                                                Seleccione una Provincia
                                            </option>
                                        </select>
                                    </td>
                                    <td align="right">
                                        <strong>
                                            Localidad:                           
                                            <input type="text" maxlength="100" size="18" value="{{localidad}}" name="sucursal_localidad_1">
                                        </strong>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr style="" id="sucursal_renglon1_1">
                    <td align="right">
                        <strong>
                            Dirección:                      
                            <input type="text" maxlength="100" size="35" value="{{direccion}}" name="sucursal_direccion_1">
                        </strong>
                    </td>
                    <td align="right">
                        <strong>
                            Encargados:                      
                            <input type="text" maxlength="100" size="35" value="{{encargados}}" name="sucursal_encargados_1">
                        </strong>
                    </td>
                </tr>
                <tr style="" id="sucursal_renglon2_1">
                    <td align="right">
                        <strong>
                            Teléfono 1:                      
                            <input type="text" maxlength="100" size="35" value="{{telefono1}}" name="sucursal_tel1_1">
                        </strong>
                    </td>
                    <td align="right">
                        <strong>
                            Teléfono 2:                      
                            <input type="text" maxlength="100" size="35" value="{{telefono2}}" name="sucursal_tel2_1">
                        </strong>
                    </td>
                </tr>
                <tr style="" id="sucursal_renglon3_1">
                    <td colspan="2">
                        <strong>
                            Observaciones:
                        </strong>
                        <textarea rows="3" cols="70" name="sucursal_observaciones_1">{{observaciones}}</textarea>
                    </td>
                </tr>
            </tbody>
        </table>
        <span id="span_sucursal_2">
        </span>
    </span>
</fieldset>
</script>